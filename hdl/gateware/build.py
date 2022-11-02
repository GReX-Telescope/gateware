"""The instantiation of the top level module to be embedded in the Simulink model.

This postprocessing block runs after the CASPER FFT, to prepare data for the 10 GbE
core. As such, it takes both complex FFT outputs, and creates words for the core, with
all the syncronization, gain, etc.
"""

from math import ceil, log2
from amaranth import Module, Signal
from gateware.packetizer import Packetizer
from gateware.requant import Requant
from amaranth.back import verilog

CHANNELS = 2048
# As there are two channels per outgoing word, and 2048 channels, we output 1024 words
N_WORDS = CHANNELS // 2
# The output of the FFT is 12+12 bit
IN_BITS = 12
# We need to create 8 bit words
OUT_BITS = 8
# 10 GbE core words with 64 bit words
WORD_SIZE = 64
N_BITS = ceil(log2(CHANNELS))
GAIN_BITS = IN_BITS - OUT_BITS + 1


def build():
    # Setup all the sub-components
    m = Module()

    m.submodules.packetizer = packetizer = Packetizer(N_WORDS)
    m.submodules.requant_a = requant_a = Requant(IN_BITS, OUT_BITS, CHANNELS)
    m.submodules.requant_b = requant_b = Requant(IN_BITS, OUT_BITS, CHANNELS)

    # Inputs
    in_a = Signal(2 * IN_BITS)
    in_b = Signal(2 * IN_BITS)
    arm = Signal()
    sync_in = Signal()
    ce = Signal()
    gain = Signal(GAIN_BITS)

    # Outputs
    tx_data = Signal(WORD_SIZE)
    tx_valid = Signal()
    tx_eof = Signal()
    addr = Signal(N_BITS)
    ovf_a = Signal()
    ovf_b = Signal()

    # Connect requant_a
    m.d.comb += [
        # Inputs
        requant_a.input.eq(in_a),
        requant_a.sync_in.eq(sync_in),
        requant_a.gain.eq(gain),
        requant_a.arm.eq(arm),
        requant_a.ce.eq(ce),
        # Outputs
        addr.eq(requant_a.addr),
        ovf_a.eq(requant_a.overflow),
    ]

    # Connect requant_b
    m.d.comb += [
        # Inputs
        requant_b.input.eq(in_b),
        requant_b.sync_in.eq(sync_in),
        requant_b.gain.eq(gain),
        requant_b.arm.eq(arm),
        requant_b.ce.eq(ce),
        # Outputs
        ovf_b.eq(requant_b.overflow),
    ]

    # We only need the addr and sync output from one
    m.d.comb += [
        packetizer.arm.eq(arm),
        packetizer.ce.eq(ce),
        packetizer.ch_a_in.eq(requant_a.output),
        packetizer.ch_b_in.eq(requant_b.output),
        packetizer.sync_in.eq(requant_a.sync_out),
    ]

    # And buffer all the outputs to the 10 GbE core
    m.d.sync += [
        tx_valid.eq(packetizer.tx_valid),
        tx_data.eq(packetizer.tx_data),
        tx_eof.eq(packetizer.tx_eof),
    ]

    # Finally, generate the verilog
    with open("artifacts/postprocess.v", "w") as f:
        f.write(
            verilog.convert(
                m,
                ports=[
                    in_a,
                    in_b,
                    arm,
                    sync_in,
                    ce,
                    gain,
                    tx_data,
                    tx_valid,
                    tx_eof,
                    addr,
                    ovf_a,
                    ovf_b,
                ],
                name="postprocess",
                strip_internal_attrs=True,
            )
        )

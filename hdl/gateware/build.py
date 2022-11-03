"""The instantiation of the blocks to be embedded in the Simulink model.
"""

from gateware.packetizer import Packetizer, PacketizerState
from gateware.requant import Requant
from amaranth.back import verilog, rtlil
from amaranth import Module
from amaranth.asserts import Assert, Assume, Cover

CHANNELS = 2048
# As there are two channels per outgoing word, and 2048 channels, we output 1024 words
N_WORDS = CHANNELS // 2
# The output of the FFT is 12+12 bit
IN_BITS = 12
# We need to create 8 bit words
OUT_BITS = 8

# Setup the modules
PACKETIZER = Packetizer(N_WORDS)
REQUANT = Requant(IN_BITS, OUT_BITS, CHANNELS)

def verify():
    """Generate the output needed for formal verifaction"""

    # Create a top level module we can add assertions to
    m = Module()
    m.submodules.adder = pktzr = PACKETIZER

    # Verify we can get to all the states we want to get to
    m.d.comb += Cover(pktzr.state == PacketizerState.WaitArm)
    m.d.comb += Cover(pktzr.state == PacketizerState.WaitSync)
    m.d.comb += Cover(pktzr.state == PacketizerState.Running)

    # Now verify behavior
    # Under the assumption that we are in the running state
    with m.If(pktzr.state == PacketizerState.Running):
        # The FIFO shall never overflow
        m.d.comb += Assert(~pktzr.buffer_ovfl)

    # And write the il file to give to sby
    with open("artifacts/packetizer.il","w") as f:
        f.write(rtlil.convert(m))


def build():
    """Build the verilog output to give to Simulink"""

    # Generate the verilog
    with open("artifacts/packetizer.v", "w") as f:
        f.write(
            verilog.convert(
                PACKETIZER,
                ports=PACKETIZER.ports(),
                name="packetizer",
                strip_internal_attrs=True,
            )
        )

    with open("artifacts/requant.v", "w") as f:
        f.write(
            verilog.convert(
                REQUANT,
                ports=REQUANT.ports(),
                name="requant",
                strip_internal_attrs=True,
            )
        )

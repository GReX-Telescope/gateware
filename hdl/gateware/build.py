"""The instantiation of the blocks to be embedded in the Simulink model.
"""

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


def build():
    # Setup the modules
    packetizer = Packetizer(N_WORDS)
    requant = Requant(IN_BITS, OUT_BITS, CHANNELS)

    # Generate the verilog
    with open("artifacts/packetizer.v", "w") as f:
        f.write(
            verilog.convert(
                packetizer,
                ports=packetizer.ports(),
                name="packetizer",
                strip_internal_attrs=True,
            )
        )

    with open("artifacts/requant.v", "w") as f:
        f.write(
            verilog.convert(
                requant,
                ports=requant.ports(),
                name="requant",
                strip_internal_attrs=True,
            )
        )

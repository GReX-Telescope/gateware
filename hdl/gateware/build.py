"""The instantiation of the blocks to be embedded in the Simulink model.
"""

from gateware.requant import Requant
from amaranth.back import verilog

CHANNELS = 2048
# As there are two channels per outgoing word, and 2048 channels, we output 1024 words
N_WORDS = CHANNELS // 2
# The output of the FFT is 18+18 bit as Fix18_17
IN_BITS = 18
# We need to create 8 bit words
OUT_BITS = 8

# Setup the modules
REQUANT = Requant(IN_BITS, OUT_BITS, CHANNELS)

def build():
    """Build the verilog output to give to Simulink"""

    # Generate the verilog
    with open("artifacts/requant.v", "w") as f:
        f.write(
            verilog.convert(
                REQUANT,
                ports=REQUANT.ports(),
                name="requant",
            )
        )

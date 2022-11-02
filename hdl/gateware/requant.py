from enum import Enum
from math import log2, ceil
from amaranth import Signal, Module, Elaboratable, Cat, Const, signed
from gateware.complex import ComplexMult


class RequantState(Enum):
    WaitArm = 0
    WaitSync = 1
    Running = 2


class Requant(Elaboratable):
    """A saturating requant stage"""

    def __init__(self, in_bits: int, out_bits: int, channels: int):
        """
        `<in/out>_bits` - Number of bits for both the real and imaginary
        The gain term will be an unsigned integer with in_bits-out_bits+1
        in order to move the LSB of the input to the LSB of the output
        """

        # First, we figure out how many bits to use to hold state about channels
        n_bits = ceil(log2(channels))
        self.in_bits = in_bits
        self.out_bits = out_bits

        ## Inputs
        self.requant_in = Signal(2 * in_bits)
        self.gain = Signal(in_bits - out_bits + 1)
        self.sync_in = Signal()
        # To prepare for incoming data
        self.arm = Signal()
        # To make MATLAB happy
        self.ce = Signal()

        ## Outputs
        self.requant_out = Signal(2 * out_bits)
        self.sync_out = Signal()
        # Booleans to indicate that some multiplication overflowed
        self.overflow = Signal()
        # To address external memory to get the gain for this channel
        self.addr = Signal(n_bits)

        ## Intermediate Signals
        self.inter_re = Signal(signed(in_bits))
        self.inter_im = Signal(signed(in_bits))

        ## State
        self.channels = Const(channels)
        # Counter
        self.chan_count = Signal(n_bits)
        self.state = Signal(RequantState, reset=RequantState.WaitArm)

    def ports(self):
        return [
            # Inputs
            self.requant_in,
            self.sync_in,
            self.gain,
            self.arm,
            self.ce,
            # Outputs
            self.requant_out,
            self.sync_out,
            self.overflow,
            self.addr,
        ]

    def elaborate(self, _):
        # Instatiate the module
        m = Module()

        # Add out complex mults as submodules
        m.submodules.cm = cm = ComplexMult(
            self.in_bits, self.in_bits - self.out_bits + 1
        )

        with m.If(self.ce):

            # State Transitions
            with m.If(self.arm):
                with m.If(self.state == RequantState.WaitArm):
                    m.d.sync += self.state.eq(RequantState.WaitSync)
                with m.Elif(self.state == RequantState.Running):
                    m.d.sync += self.state.eq(RequantState.WaitSync)
            with m.If(self.sync_in):
                with m.If(self.state == RequantState.WaitSync):
                    m.d.sync += self.state.eq(RequantState.Running)
                    # And send the ouput sync
                    m.d.sync += self.sync_out.eq(1)

            # Don't do anything until we're running
            with m.If(self.state == RequantState.Running):
                # We sent the sync pulse on the state transition, so, we'll always
                # set sync_out to 0 when we're running
                m.d.sync += self.sync_out.eq(0)

                # If we've counted to the end, reset
                with m.If(self.chan_count == self.channels - 1):
                    m.d.sync += self.chan_count.eq(0)
                with m.Else():
                    m.d.sync += self.chan_count.eq(self.chan_count + 1)

                # We'll assume that whatever is storing the gain values is
                # indexed by the `addr` field that we'll set (now)
                m.d.comb += self.addr.eq(self.chan_count)

                # Perfom the multiplication
                m.d.comb += [
                    cm.cm_in.eq(self.requant_in),
                    cm.gain.eq(self.gain),
                    self.inter_re.eq(cm.re),
                    self.inter_im.eq(cm.im),
                ]

                # Then grab the most significant bits and concat, im is LSB
                out = Cat(
                    self.inter_im[-self.out_bits :], self.inter_re[-self.out_bits :]
                )

                # And assign these on the next clock
                m.d.sync += self.requant_out.eq(out)

                # Check the overflow bits, and OR them together
                m.d.sync += self.overflow.eq(cm.im_overflow | cm.re_overflow)

        # Return module for elaboration
        return m

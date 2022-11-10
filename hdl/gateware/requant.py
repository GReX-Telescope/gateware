from amaranth import Signal, Module, Elaboratable, Cat, Const, signed
from gateware.complex import ComplexMult
from amaranth.lib.fifo import SyncFIFOBuffered

TOTAL_DELAY = 5  # Figured out from context


class Requant(Elaboratable):
    """A pipelined, saturating requantization stage. 5 Cycle Latency"""

    def __init__(self, in_bits: int, out_bits: int, channels: int):
        """
        `<in/out>_bits` - Number of bits for both the real and imaginary
        The gain term will be an unsigned integer with in_bits-out_bits+1
        in order to move the LSB of the input to the LSB of the output
        """

        self.in_bits = in_bits
        self.out_bits = out_bits

        ## Inputs
        self.pol_a_in = Signal(2 * in_bits)
        self.pol_b_in = Signal(2 * in_bits)
        self.gain = Signal(in_bits - out_bits + 1)
        # This sync pulse will reset the counter
        self.sync_in = Signal()
        self.ce = Signal()

        ## Outputs
        self.pol_a_out = Signal(2 * out_bits)
        self.pol_b_out = Signal(2 * out_bits)
        self.sync_out = Signal()
        # Booleans to indicate that some multiplication overflowed
        self.pol_a_overflow = Signal()
        self.pol_b_overflow = Signal()
        # To address external memory to get the gain for this channel
        self.addr = Signal(range(channels))

        ## Intermediate Signals
        self.inter_re_a = Signal(signed(in_bits))
        self.inter_im_a = Signal(signed(in_bits))
        self.inter_ovfl_a = Signal()

        self.inter_re_b = Signal(signed(in_bits))
        self.inter_im_b = Signal(signed(in_bits))
        self.inter_ovfl_b = Signal()

        self.sync_buf = Signal(TOTAL_DELAY - 1)

        ## State
        self.channels = Const(channels)

    def ports(self):
        return [
            # Inputs
            self.pol_a_in,
            self.pol_b_in,
            self.sync_in,
            self.gain,
            self.ce,
            # Outputs
            self.pol_a_out,
            self.pol_b_out,
            self.sync_out,
            self.pol_a_overflow,
            self.pol_b_overflow,
            self.addr,
        ]

    def elaborate(self, _):
        # Instatiate the module
        m = Module()

        # Add out complex mults as submodules
        m.submodules.cm_a = cm_a = cm_b = ComplexMult(
            self.in_bits, self.in_bits - self.out_bits + 1
        )
        m.submodules.cm_b = cm_b = ComplexMult(
            self.in_bits, self.in_bits - self.out_bits + 1
        )

        with m.If(self.ce):
            # The sync pulse resets the address counter
            with m.If(self.sync_in):
                m.d.sync += self.addr.eq(0)
            with m.Else():
                # Increment
                m.d.sync += self.addr.eq((self.addr + 1) % self.channels)

            # Setup the multiplications, all buffered
            m.d.sync += [
                cm_a.complex_in.eq(self.pol_a_in),
                cm_a.gain.eq(self.gain),
                self.inter_re_a.eq(cm_a.re),
                self.inter_im_a.eq(cm_a.im),
                self.inter_ovfl_a.eq(cm_a.re_overflow | cm_a.im_overflow),
            ]
            m.d.sync += [
                cm_b.complex_in.eq(self.pol_b_in),
                cm_b.gain.eq(self.gain),
                self.inter_re_b.eq(cm_b.re),
                self.inter_im_b.eq(cm_b.im),
                self.inter_ovfl_b.eq(cm_b.re_overflow | cm_b.im_overflow),
            ]

            # Then grab the most significant bits and concat, im is LSB
            out_a = Cat(
                self.inter_im_a[-self.out_bits :], self.inter_re_a[-self.out_bits :]
            )
            out_b = Cat(
                self.inter_im_b[-self.out_bits :], self.inter_re_b[-self.out_bits :]
            )

            # And assign these on the next clock
            m.d.sync += self.pol_a_out.eq(out_a)
            m.d.sync += self.pol_b_out.eq(out_b)

            # Check the overflow bits, and OR them together
            m.d.sync += self.pol_a_overflow.eq(self.inter_ovfl_a)
            m.d.sync += self.pol_b_overflow.eq(self.inter_ovfl_b)

            # And do the delays
            m.d.sync += Cat(self.sync_out, self.sync_buf).eq(
                Cat(self.sync_buf, self.sync_in)
            )

        # Return module for elaboration
        return m

from typing import List
from amaranth import Signal, Module, Elaboratable, Cat, Const, signed


class UnpackComplex(Elaboratable):
    """Combinational circuit to unpack a complex number."""

    def __init__(self, bits: int):
        self.unpack_in = Signal(2 * bits)
        self.re = Signal(signed(bits))
        self.im = Signal(signed(bits))
        self.bits = bits

    def ports(self) -> List[Signal]:
        return [self.unpack_in, self.re, self.im]

    def elaborate(self, _):
        m = Module()
        # least significant bits are imaginary
        m.d.comb += [
            self.im.eq(self.unpack_in[: self.bits]),
            self.re.eq(self.unpack_in[self.bits :]),
        ]
        return m


class ComplexMult(Elaboratable):
    """A module for truncated multiplication of a signed complex number by an unsigned scalar.

    Given an `in_bits` + `in_bits`j (signed) input, we multiply by an unsigned `gain_bits` term
    and truncate to the size of the input, saturating when we overflow.

    We'll also throw an overflow flag when we do so.
    """

    def __init__(self, in_bits: int, gain_bits: int):
        self.in_bits = in_bits
        self.inter_bits = gain_bits + in_bits
        # Inputs
        self.complex_in = Signal(2 * in_bits)
        self.gain = Signal(gain_bits)
        self.sync_in = Signal()
        # Outputs
        self.re = Signal(signed(in_bits))
        self.im = Signal(signed(in_bits))
        self.re_overflow = Signal()
        self.im_overflow = Signal()
        self.sync_out = Signal()
        # Intermediate signals
        self.re_gain = Signal(signed(self.inter_bits))
        self.im_gain = Signal(signed(self.inter_bits))
        self.sync_buf = Signal()

    def ports(self) -> List[Signal]:
        return [self.complex_in, self.gain, self.re, self.im]

    def elaborate(self, _):
        # Instatiate the module and submodules
        m = Module()

        m.submodules.unpack = unpack = UnpackComplex(self.in_bits)

        # Unpack
        m.d.comb += unpack.unpack_in.eq(self.complex_in)

        # Bring in the sync signal
        m.d.sync += self.sync_buf.eq(self.sync_in)

        # Multiply, ensuring we do sign extension
        m.d.sync += [
            self.im_gain.eq(unpack.im * self.gain),
            self.re_gain.eq(unpack.re * self.gain),
        ]

        # Check for overflow
        # Because we are truncating to `in_bits`, we have to check if
        # the resulting number is gt/lt  2**(in_bits-1) - 1

        clamp_high = Const(2 ** (self.in_bits - 1) - 1, signed(self.inter_bits))
        clamp_low = Const(-(2 ** (self.in_bits - 1)), signed(self.inter_bits))

        with m.If(self.im_gain > clamp_high):
            m.d.sync += self.im_overflow.eq(1)
            m.d.sync += self.im.eq(clamp_high)
        with m.Elif(self.im_gain < clamp_low):
            m.d.sync += self.im_overflow.eq(1)
            m.d.sync += self.im.eq(clamp_low)
        with m.Else():
            m.d.sync += self.im_overflow.eq(0)
            m.d.sync += self.im.eq(self.im_gain[: self.in_bits])

        with m.If(self.re_gain > clamp_high):
            m.d.sync += self.re_overflow.eq(1)
            m.d.sync += self.re.eq(clamp_high)
        with m.Elif(self.re_gain < clamp_low):
            m.d.sync += self.re_overflow.eq(1)
            m.d.sync += self.re.eq(clamp_low)
        with m.Else():
            m.d.sync += self.re_overflow.eq(0)
            m.d.sync += self.re.eq(self.re_gain[: self.in_bits])

        # And buffer out the sync
        m.d.sync += self.sync_out.eq(self.sync_buf)

        # And return the module to instantiate
        return m

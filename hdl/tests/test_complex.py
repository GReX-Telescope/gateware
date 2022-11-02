from amaranth.sim import Simulator, Settle, Delay
from gateware.complex import ComplexMult
from bitstring import BitStream


def complex_input(dut: ComplexMult, real: int, imag: int):
    """Write a complex number to the DUT input"""
    bits = dut.in_bits
    # Check to make sure the input fits
    min = -(2 ** (bits - 1)) + 1
    max = 2 ** (bits - 1) - 1
    assert min <= real <= max
    assert min <= imag <= max
    # Pack (imag lsb)
    word = BitStream(f"int:{bits}={real}, int:{bits}={imag}")
    yield dut.input.eq(word.int)


def test_complex():
    # Create DUT
    dut = ComplexMult(4, 2)

    # Setup the simulation
    sim = Simulator(dut)

    # Define the actual test process
    def process():
        # Test passthrough (gain = 1)
        yield dut.gain.eq(1)

        yield from complex_input(dut, 3, 5)
        yield Settle()
        yield Delay(1e-6)
        assert (yield dut.re) == 3
        assert (yield dut.im) == 5
        assert not (yield dut.re_overflow)
        assert not (yield dut.im_overflow)

        yield from complex_input(dut, -3, -5)
        yield Settle()
        yield Delay(1e-6)
        assert (yield dut.re) == -3
        assert (yield dut.im) == -5
        assert not (yield dut.re_overflow)
        assert not (yield dut.im_overflow)

        yield from complex_input(dut, -7, 7)
        yield Settle()
        yield Delay(1e-6)
        assert (yield dut.re) == -7
        assert (yield dut.im) == 7
        assert not (yield dut.re_overflow)
        assert not (yield dut.im_overflow)

        # Now test with gain
        yield dut.gain.eq(2)

        yield from complex_input(dut, 1, 2)
        yield Settle()
        yield Delay(1e-6)
        assert (yield dut.re) == 2
        assert (yield dut.im) == 4
        assert not (yield dut.re_overflow)
        assert not (yield dut.im_overflow)

        yield from complex_input(dut, -1, -2)
        yield Settle()
        yield Delay(1e-6)
        assert (yield dut.re) == -2
        assert (yield dut.im) == -4
        assert not (yield dut.re_overflow)
        assert not (yield dut.im_overflow)

        yield from complex_input(dut, 3, -4)
        yield Settle()
        yield Delay(1e-6)
        assert (yield dut.re) == 6
        assert (yield dut.im) == -8
        assert not (yield dut.re_overflow)
        assert not (yield dut.im_overflow)

        yield from complex_input(dut, -7, 7)
        yield Settle()
        yield Delay(1e-6)
        assert (yield dut.re) == -8
        assert (yield dut.im) == 7
        assert (yield dut.re_overflow)
        assert (yield dut.im_overflow)

    # Tell the simulation about the process and the waveform context to run
    sim.add_process(process)
    with sim.write_vcd(
        "artifacts/complex.vcd", "artifacts/complex.gtkw", traces=dut.ports()
    ):
        sim.run()

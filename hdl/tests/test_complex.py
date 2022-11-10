from typing import List
from amaranth.sim import Simulator
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
    yield dut.complex_in.eq(word.int)


def full_cycle_pipelined(
    dut: ComplexMult, reals: List[int], imags: List[int], gains: List[int]
):
    assert len(reals) == len(imags) == len(gains)
    for i in range(len(reals) + 3):
        if i < len(reals):
            yield dut.gain.eq(gains[i])
            yield from complex_input(dut, reals[i], imags[i])
        # Start checking old values
        if i > 2:
            assert (yield dut.re) == reals[i - 3] * gains[i - 3]
            assert (yield dut.im) == imags[i - 3] * gains[i - 3]
            assert not (yield dut.re_overflow)
            assert not (yield dut.im_overflow)
        yield


def test_complex():
    # Create DUT
    dut = ComplexMult(4, 2)

    # Setup the simulation
    sim = Simulator(dut)

    # Define the actual test process
    def process():
        # Test sync pulse latency
        yield dut.sync_in.eq(1)
        yield
        yield dut.sync_in.eq(0)
        yield
        # This is where data would go
        yield
        # One cycle of crunching, sync should be high now as we are one cycle before valid daya
        assert (yield dut.sync_out)

        # Now some number-based tests
        yield from full_cycle_pipelined(dut, [3, -3, 7], [5, -5, 7], [1, 1, 1])
        yield from full_cycle_pipelined(dut, [2, -3, 3], [-2, 3, -4], [2, 2, 2])

        # Now test the overflow cases
        yield dut.gain.eq(2)
        yield from complex_input(dut, 4, 4)
        yield
        yield
        yield
        assert (yield dut.re) == 7
        assert (yield dut.im) == 7
        assert (yield dut.re_overflow)
        assert (yield dut.im_overflow)

        yield dut.gain.eq(3)
        yield from complex_input(dut, -4, -4)
        yield
        yield
        yield
        assert (yield dut.re) == -8
        assert (yield dut.im) == -8
        assert (yield dut.re_overflow)
        assert (yield dut.im_overflow)

    # Tell the simulation about the process and the waveform context to run
    sim.add_sync_process(process)
    sim.add_clock(1e-6)
    with sim.write_vcd(
        "artifacts/complex.vcd", "artifacts/complex.gtkw", traces=dut.ports()
    ):
        sim.run()

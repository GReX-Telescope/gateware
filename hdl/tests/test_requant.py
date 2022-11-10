from amaranth.sim import Simulator
from gateware.requant import Requant


def test_requant():
    # Create DUT
    dut = Requant(8, 4, 4)

    # Setup the simulation
    sim = Simulator(dut)

    # Define the actual test process
    def process():
        # Setup and check initial state transitions
        yield dut.ce.eq(1)
        yield dut.sync_in.eq(1)
        yield
        yield dut.sync_in.eq(0)
        # Try to move the LSB of the input to the output
        yield dut.gain.eq(16)
        yield dut.pol_a_in.eq(0b00000001_00000001)  # => 0b0001_0001
        yield dut.pol_b_in.eq(0b00000001_00000001)  # => 0b0001_0001
        yield
        assert (yield dut.addr) == 0
        yield dut.gain.eq(1)
        yield dut.pol_a_in.eq(0b11111110_11111110)  # => 0b1111_1111
        yield dut.pol_b_in.eq(0b11000000_10010000)  # => 0b1100_1001
        yield
        assert (yield dut.addr) == 1
        yield dut.gain.eq(2)
        yield dut.pol_a_in.eq(0b00010000_00010000)  # => 0b0010_0010
        yield dut.pol_b_in.eq(0b01010101_10101010)  # => 0b0111_1000
        yield
        assert (yield dut.addr) == 2
        # Now the gain 3 is set, we could pipeline in a 4th and 5th input
        yield
        assert (yield dut.addr) == 3
        yield
        # This is where the sync out should be
        assert (yield dut.addr) == 0
        assert (yield dut.sync_out)
        yield
        # And this is the beginning of valid data
        assert (yield dut.pol_a_out) == 0b0001_0001
        assert (yield dut.pol_b_out) == 0b0001_0001
        assert not (yield dut.pol_a_overflow)
        assert not (yield dut.pol_b_overflow)
        yield
        assert (yield dut.pol_a_out) == 0b1111_1111
        assert (yield dut.pol_b_out) == 0b1100_1001
        assert not (yield dut.pol_a_overflow)
        assert not (yield dut.pol_b_overflow)
        yield
        assert (yield dut.pol_a_out) == 0b0010_0010
        assert (yield dut.pol_b_out) == 0b0111_1000
        assert not (yield dut.pol_a_overflow)
        assert (yield dut.pol_b_overflow)

    # Tell the simulation about the process and the waveform context to run
    sim.add_sync_process(process)
    sim.add_clock(1e-6)
    with sim.write_vcd(
        "artifacts/requant.vcd", "artifacts/requant.gtkw", traces=dut.ports()
    ):
        sim.run()

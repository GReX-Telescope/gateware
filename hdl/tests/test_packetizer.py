from gateware.packetizer import Packetizer, PacketizerState
from amaranth.sim import Simulator


def test_packetizer():
    n_words = 1024
    dut = Packetizer(n_words)
    sim = Simulator(dut)

    def process():
        yield dut.arm.eq(0)
        yield dut.sync_in.eq(0)
        yield dut.ce.eq(0)
        yield
        # Check the state
        assert (yield dut.state) == PacketizerState.WaitArm.value
        # Enable the clock and toggle arm
        yield dut.ce.eq(1)
        yield dut.arm.eq(1)
        yield
        yield dut.arm.eq(0)
        yield
        # Check the state
        assert (yield dut.state) == PacketizerState.WaitSync.value
        # Toggle the sync_in
        yield dut.sync_in.eq(1)
        yield
        yield dut.sync_in.eq(0)
        # Write some words
        for i in range(0, 8 * n_words, 4):
            # Set our test values
            yield dut.pol_a.eq(i)
            yield dut.pol_b.eq(i + 1)
            yield
            yield dut.pol_a.eq(i + 2)
            yield dut.pol_b.eq(i + 3)
            yield
        yield  # One cycle to latch the last word
        yield  # One cycle to enter the drain state
        yield  # One cycle for it to propogate to the output
        # Then check the output
        # First is the header (1, we skipped testing the first one)
        assert (yield dut.tx_valid)
        assert (yield dut.tx_data) == 1
        yield
        for i in range(4 * n_words, 8 * n_words, 4):
            # Test our last values
            value = (i + 2) << 48 | (i + 3) << 32 | (i) << 16 | (i + 1)
            assert (yield dut.tx_data) == value
            assert (yield dut.tx_valid)
            yield

    sim.add_sync_process(process)
    sim.add_clock(1e-6)
    with sim.write_vcd( "artifacts/packetizer.vcd", "artifacts/packetizer.gtkw", traces=dut.ports()):
        sim.run()

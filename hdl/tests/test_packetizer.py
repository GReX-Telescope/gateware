from gateware.packetizer import Packetizer, PacketizerState
from amaranth.sim import Simulator


def test_requant():
    # Create DUT
    dut = Packetizer(4)

    # Setup the simulation
    sim = Simulator(dut)

    def process():
        # Set initial values
        yield dut.arm.eq(0)
        yield dut.sync_in.eq(0)
        # Wait a clock cycle and check state
        yield
        assert (yield dut.state) == PacketizerState.WaitArm.value
        # Reset
        yield dut.arm.eq(1)
        yield
        yield dut.arm.eq(0)
        # Wait a clock cycle and check state
        yield
        assert (yield dut.state) == PacketizerState.WaitSync.value
        # Sync
        yield dut.sync_in.eq(1)
        yield
        # This cycle contains the first valid data
        yield dut.sync_in.eq(0)
        # Write a bunch of words
        for i in range(0, 512, 2):
            yield dut.ch_a_in.eq(i)
            yield dut.ch_b_in.eq(i + 1)
            yield

    # Tell the simulation about the process and the waveform context to run
    sim.add_sync_process(process)
    sim.add_clock(1e-6)
    with sim.write_vcd(
        "artifacts/packetizer.vcd", "artifacts/packetizer.gtkw", traces=dut.ports()
    ):
        sim.run()

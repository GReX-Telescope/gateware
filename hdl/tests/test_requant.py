from amaranth.sim import Simulator
from gateware.requant import Requant, RequantState

def test_requant():
    # Create DUT
    dut = Requant(8,4,4)

    # Setup the simulation
    sim = Simulator(dut)

    # Define the actual test process
    def process():
        # Setup and check initial state transitions
        yield dut.ce.eq(1)
        yield dut.arm.eq(1)
        assert (yield dut.state) == RequantState.WaitArm.value
        yield
        yield dut.arm.eq(0)
        yield dut.sync_in.eq(1)
        yield
        yield dut.sync_in.eq(0)
        assert (yield dut.state) == RequantState.WaitSync.value
        # Try to move the LSB of the input to the output
        yield dut.gain.eq(16)
        yield dut.requant_in.eq(0b00000001_00000001)
        yield
        assert (yield dut.state) == RequantState.Running.value
        # At this point, the addr selector should be on zero
        assert (yield dut.addr) == 0
        # And sync_out should be high as the next clock will contain the valid data
        assert (yield dut.sync_out)
        # Now we'll set a new gain, input, and output for the next cycle
        yield dut.requant_in.eq(0b11111110_11111110)
        yield dut.gain.eq(1)
        yield
        # On this cyle, we should have 1,1
        assert (yield dut.requant_out) == 0b0001_0001
        # And be selecting the the second address
        assert (yield dut.addr) == 1
        # And now set the gain too high to show clamping
        yield dut.gain.eq(3)
        yield dut.requant_in.eq(0b01000000_10000000)
        yield
        assert (yield dut.requant_out) == 0b1111_1111
        yield
        assert (yield dut.overflow)
        assert (yield dut.requant_out) == 0b0111_1000


    # Tell the simulation about the process and the waveform context to run
    sim.add_sync_process(process)
    sim.add_clock(1e-6)
    with sim.write_vcd(
        "artifacts/requant.vcd", "artifacts/requant.gtkw", traces=dut.ports()
    ):
        sim.run()

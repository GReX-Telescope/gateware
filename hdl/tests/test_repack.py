from gateware.reorder_packetizer import PackPol, State
from amaranth.sim import Simulator

CHANNELS = 2048

def test_repack():
    n_words = 4
    dut = PackPol(CHANNELS)
    sim = Simulator(dut)

    def process():
        yield dut.ce.eq(1)
        yield dut.arm.eq(1)
        yield
        yield dut.arm.eq(0)
        yield dut.sync_in.eq(1)
        yield
        yield dut.sync_in.eq(0)
        yield dut.pol_in.eq(0xCAFE)
        yield
        yield dut.pol_in.eq(0xB0BA)
        yield
        yield dut.pol_in.eq(0xBEEF)
        yield
        yield dut.pol_in.eq(0xDEAD)
        yield
        yield
        yield
        yield

    sim.add_sync_process(process)
    sim.add_clock(1e-6)
    with sim.write_vcd( "artifacts/repack.vcd", "artifacts/repack.gtkw", traces=dut.ports()):
        sim.run()

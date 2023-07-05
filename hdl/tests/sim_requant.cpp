#include "Vrequant.h"
#include <cstdlib>
#include <iostream>
#include <memory>
#include <sys/types.h>
#include <verilated.h>
#include <verilated_vcd_c.h>

#define MODEL Vrequant
#define MAX_SIM_TIME 4102

vluint64_t sim_time = 0;
vluint64_t posedge_cnt = 0;

int main() {
  // Create DUT
  MODEL *dut = new MODEL;

  // Setup waveform logging
  Verilated::traceEverOn(true);
  VerilatedVcdC *trace = new VerilatedVcdC;
  dut->trace(trace, 99);
  trace->open("traces/requant.vcd");

  // Initial states for input wires
  dut->rst = false;
  dut->ce = true;
  dut->gain = 1024;

  while (sim_time < 1024) {
    dut->clk ^= 1; // Invert clock
    dut->eval();   // Evaluate DUT on this edge
    if (dut->clk == 1) {
      dut->gain = (posedge_cnt + 1024) & 0b11111111111;
      // Posedge events
      posedge_cnt++;
      if (posedge_cnt > 3)
        dut->data_in =
            ((posedge_cnt << 18) & 0xFFFFC0000 | (-posedge_cnt - 1) & 0x3FFFF);

      if (posedge_cnt == 3)
        dut->sync_in = 1;
      else
        dut->sync_in = 0;
    }

    // Dump the waveform
    trace->dump(sim_time);
    // Advance the simulation
    sim_time++;
  }

  // Cleanup
  trace->close();
  dut->final();
  delete dut;
  delete trace;
  return 0;
}
#include "Vvacc.h"
#include <cstdlib>
#include <iostream>
#include <memory>
#include <sys/types.h>
#include <verilated.h>
#include <verilated_vcd_c.h>

#define MODEL Vvacc
#define MAX_SIM_TIME 2048 * 30

vluint64_t sim_time = 0;
vluint64_t posedge_cnt = 0;

int main() {
  // Create DUT
  MODEL *dut = new MODEL;

  // Setup waveform logging
  Verilated::traceEverOn(true);
  VerilatedVcdC *trace = new VerilatedVcdC;
  dut->trace(trace, 99);
  trace->open("traces/vacc.vcd");

  // Initial states for input wires
  dut->rst = false;
  dut->ce = true;
  dut->acc_n = 8;

  // dut->data_in = 1;
  dut->trig = 0;

  while (sim_time < MAX_SIM_TIME) {
    dut->clk ^= 1; // Invert clock
    dut->eval();   // Evaluate DUT on this edge
    if (dut->clk == 1) {
      // Posedges
      posedge_cnt++;

      if (posedge_cnt == 15)
        dut->sync = 1;
      else
        dut->sync = 0;

      if (posedge_cnt == 69)
        dut->trig = 1;
      else
        dut->trig = 0;

      dut->data_in = (posedge_cnt - 16) % 2048;
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
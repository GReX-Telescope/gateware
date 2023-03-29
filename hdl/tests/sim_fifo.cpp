#include "Vfifo.h"
#include <cstdlib>
#include <iostream>
#include <memory>
#include <sys/types.h>
#include <verilated.h>
#include <verilated_vcd_c.h>

#define MODEL Vfifo
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
  trace->open("traces/fifo.vcd");

  // Initial states for input wires
  dut->rst = false;

  // Run
  while (sim_time < MAX_SIM_TIME) {
    dut->clk ^= 1; // Invert clock
    dut->eval();   // Evaluate DUT on this edge
    if (dut->clk == 1) {
      // Posedge events
      posedge_cnt++;

      // Write all
      if (posedge_cnt >= 2 && posedge_cnt < 1026) {
        dut->din = posedge_cnt - 2;
        dut->we = true;
      } else {
        dut->we = false;
      }

      // Read all
      if (posedge_cnt >= 1026) {
        dut->re = true;
      } else {
        dut->re = false;
      }
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
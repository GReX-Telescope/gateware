#include "Vpacketizer.h"
#include <iostream>
#include <memory>
#include <sys/types.h>
#include <verilated.h>
#include <verilated_vcd_c.h>

#define MODEL Vpacketizer

vluint64_t sim_time = 0;
vluint64_t posedge_cnt = 0;

int main() {
  // Create DUT
  MODEL *dut = new MODEL;

  // Setup waveform logging
  Verilated::traceEverOn(true);
  VerilatedVcdC *trace = new VerilatedVcdC;
  dut->trace(trace, 99);
  trace->open("traces/packetizer.vcd");

  // Initial states for input wires
  dut->rst = false;
  dut->ce = true;

  while (sim_time < 16384) {
    dut->clk ^= 1; // Invert clock
    dut->eval();   // Evaluate DUT on this edge
    if (dut->clk == 1) {
      // Posedge events
      posedge_cnt++;

      if (posedge_cnt == 2) {
        dut->sync = true;
      } else {
        dut->sync = false;
      }

      if (posedge_cnt > 2) {
        dut->pol_a = (uint16_t)(posedge_cnt - 3);
        dut->pol_b = (uint16_t)(posedge_cnt - 3);
      } else {
        dut->pol_a = 0;
        dut->pol_b = 0;
      }
    }

    // Dump the waveform
    trace->dump(sim_time);
    // Advance the simulation
    sim_time++;
  }

  // And toggle reset and do it again
  dut->clk ^= 1;
  dut->rst = 1;
  dut->eval();
  trace->dump(sim_time);
  sim_time++;

  dut->clk ^= 1;
  dut->rst = 0;
  dut->eval();
  trace->dump(sim_time);
  sim_time++;

  posedge_cnt = 0;

  while (sim_time < 32768) {
    dut->clk ^= 1; // Invert clock
    dut->eval();   // Evaluate DUT on this edge
    if (dut->clk == 1) {
      // Posedge events
      posedge_cnt++;

      if (posedge_cnt == 2) {
        dut->sync = true;
      } else {
        dut->sync = false;
      }

      if (posedge_cnt > 2) {
        dut->pol_a = (uint16_t)(posedge_cnt - 3);
        dut->pol_b = (uint16_t)(posedge_cnt - 3);
      } else {
        dut->pol_a = 0;
        dut->pol_b = 0;
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
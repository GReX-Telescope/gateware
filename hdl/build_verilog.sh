#!/usr/bin/env bash

# First convert sv to v
sv2v src/fifo.sv -w build/verilog/fifo.v
sv2v src/packetizer.sv -w build/verilog/packetizer.v
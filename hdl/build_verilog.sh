#!/usr/bin/env bash

# First convert sv to v
sv2v src/fifo.sv -w artifacts/fifo.v
sv2v src/packetizer.sv -w artifacts/packetizer.v
sv2v src/requant.sv -w artifacts/requant.v
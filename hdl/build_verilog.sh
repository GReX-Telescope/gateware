#!/usr/bin/env bash

# Call sv2v on every system verilog file in the src directory
for file in src/*.sv; do
    sv2v $file -w artifacts/$(basename $file .sv).v
done
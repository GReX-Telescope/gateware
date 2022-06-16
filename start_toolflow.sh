#!/usr/bin/env bash

# Ensure the venv is installed and provisioned
poetry install
venv=$(poetry env info -p)

# Export all the variables casper expects
export XILINX_PATH=/opt/Xilinx/Vivado/2019.1
export MATLAB_PATH=/opt/MATLAB/R2019a
export PLATFORM=lin64
export JASPER_BACKEND=vivado
export CASPER_PYTHON_VENV_ON_START="$venv"
export LD_PRELOAD=${LD_PRELOAD}:"/usr/lib/libfreetype.so"
export LD_PRELOAD=${LD_PRELOAD}:"/usr/lib/libstdc++.so"

# Run the toolflow
./startsg

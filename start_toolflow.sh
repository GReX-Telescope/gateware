#!/usr/bin/env bash

# Ensure the venv is installed and provisioned
poetry install
venv=$(poetry env info -p)

# Export all the variables casper expects
export XILINX_PATH=/opt/Xilinx/Vivado/2019.1
export MATLAB_PATH=/opt/MATLAB/R2018a
export PLATFORM=lin64
export JASPER_BACKEND=vivado
export CASPER_PYTHON_VENV_ON_START="$venv"

# Run the toolflow
./startsg

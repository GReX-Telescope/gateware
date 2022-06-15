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
export LD_PRELOAD=${LD_PRELOAD}:"/usr/lib/libfreetype.so"
export LD_PRELOAD=${LD_PRELOAD}:"/usr/lib/libstdc++.so"
export MATLAB_JAVA=/usr/lib/jvm/java-8-adoptopenjdk/jre

# Run the toolflow
./mlib_devel/startsg

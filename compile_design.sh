#!/usr/bin/env bash

venv=$(poetry env info -p)

# Export all the variables casper expects
export XILINX_PATH=/opt/Xilinx/Vivado/2019.1
export MATLAB_PATH=/opt/MATLAB/R2018a
export PLATFORM=lin64
export JASPER_BACKEND=vivado
export CASPER_PYTHON_VENV_ON_START="$venv"
#export LD_PRELOAD=${LD_PRELOAD}:"/usr/lib/libfreetype.so"
#export LD_PRELOAD=${LD_PRELOAD}:"/usr/lib/libstdc++.so"
#export LD_PRELOAD=${LD_PRELOAD}:"/lib/libgio-2.0.so"
#export LD_PRELOAD=${LD_PRELOAD}:"/lib/libglib-2.0.so"
#export LD_PRELOAD=${LD_PRELOAD}:"/lib/libcrypto.so"

. startsg

poetry run python mlib_devel/jasper_library/exec_flow.py \
    -m "$(pwd)/grex_gateware.slx"                        \
    --perfile                                            \
    --frontend                                           \
    --middleware                                         \
    --backend                                            \
    --software

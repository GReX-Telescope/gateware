# gateware
Simulink model for the SNAP Gateware for the GReX Telescope

## Compiling the Model

To compile this model, the machine need to be setup very specifically. I tried to get things to work with docker or otherwise, but it's a nightmare. Just make a VM with
- Ubuntu 16.04
- MATLAB 2018a installed to /opt/MATLAB/R2018a
- Vivado 2019.1 installed to /opt/Xilinx/Vivado/2019.1
- Python 3.9.7 (I used pyenv for this)
- Poetry

After you do that, make sure you get a license for Vivado and install according to the CASPER docs.

### Setup

First grab this repo and the submodules
```sh
git clone https://github.com/GReX-Telescope/gateware --recurse-submodules
```

Install all the python deps
```sh
poetry install
```

### Compile

To run the existing model, simply
```sh
./compile_design.sh
```

There is another script, `start_toolflow.sh` which will bring up MATLAB to work on the design.

## Artifacts

Each tagged release will have an associated precompiled gateware, which can be found [here](https://github.com/GReX-Telescope/gateware/releases)

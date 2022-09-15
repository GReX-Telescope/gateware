# gateware

Simulink model for the SNAP Gateware for the GReX Telescope

## Compiling the Model

To compile this model, the machine need to be setup very specifically. Follow
the CASPER docs for more info, but I managed to get things working on Arch Linux
without _too_ much fuss. You'll nneed the following:

- MATLAB 2021a installed to /opt/MATLAB/R2021a
- Vivado 2021.1 installed to /opt/Xilinx/Vivado/2021.1 with Vitis and Model Composer
- A venv in the source directory with the casper tools installed

After you do that, make sure you get a license for Vivado and install according to the CASPER docs.

### Setup

First grab this repo and the submodules

```sh
git clone https://github.com/GReX-Telescope/gateware --recurse-submodules
```

### Compile

To run the existing model, open the simulink model in MATLAB and run `jasper`

## Artifacts

Each tagged release will have an associated precompiled gateware, which can be found [here](https://github.com/GReX-Telescope/gateware/releases)

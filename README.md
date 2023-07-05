# gateware

Simulink model for the SNAP Gateware for the GReX Telescope

## Compiling the Model

I was provided a machine that had MATLAB r2019a and Vivado 2019.1 installed on it, which are setup and required per the CASPER docs. You'll have to replicate this setup somehow to compile on your own.

### Setup

First grab this repo and the submodules

```sh
git clone https://github.com/GReX-Telescope/gateware --recurse-submodules
```

Then create the python virtualenv, start it up, and install the dependencies

```sh
cd gateware
python3 -m venv ./casper_venv
source casper_venv/bin/activate
pip3 install -r mlib_devel/requirements.txt
```

### External HDL

Simulink gives me cancer, so I wrote some blocks in SystemVerilog.
I'm including the "translated" verilog in this repo, but one can regenerate it by running `build_verilog.sh` in the `hdl` directory.
This requires the [sv2v](https://github.com/zachjs/sv2v) program to be on the path. Complain to Mathworks that their expensive software
doesn't support the verilog standard from over 2 decades ago.


### Compile

To run the existing model, open the simulink model in MATLAB and run `jasper`

## Artifacts

Each tagged release will have an associated precompiled gateware, which can be found [here](https://github.com/GReX-Telescope/gateware/releases)

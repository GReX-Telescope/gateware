#!/usr/bin/env perl

use Verilog::EditFiles;
my $split = Verilog::EditFiles->new(outdir => "artifacts/simulink");
$split->read_and_split(glob("artifacts/*.v"));
$split->write_files();
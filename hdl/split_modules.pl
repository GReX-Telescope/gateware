#!/usr/bin/env perl

use Verilog::EditFiles;
my $split = Verilog::EditFiles->new
    (outdir => "simulink",
    translate_synthesis => 0,
    lint_header => undef,
    celldefine => 1,
    );
$split->read_and_split(glob("artifacts/*.v"));
$split->write_files();
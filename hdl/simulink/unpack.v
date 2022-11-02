// Created by Verilog::EditFiles from requant.v

`celldefine
module unpack(im, re, \input );
  output [11:0] im;
  wire [11:0] im;
  input [23:0] \input ;
  wire [23:0] \input ;
  output [11:0] re;
  wire [11:0] re;
  assign re = \input [23:12];
  assign im = \input [11:0];
endmodule
`endcelldefine


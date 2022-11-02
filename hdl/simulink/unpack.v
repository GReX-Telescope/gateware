// Created by Verilog::EditFiles from requant.v

`celldefine
module unpack(im, re, unpack_in);
  output [11:0] im;
  wire [11:0] im;
  output [11:0] re;
  wire [11:0] re;
  input [23:0] unpack_in;
  wire [23:0] unpack_in;
  assign re = unpack_in[23:12];
  assign im = unpack_in[11:0];
endmodule
`endcelldefine


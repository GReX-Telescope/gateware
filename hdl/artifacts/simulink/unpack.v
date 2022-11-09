// Created by Verilog::EditFiles from requant.v

module unpack(im, re, unpack_in);
  output [24:0] im;
  wire [24:0] im;
  output [24:0] re;
  wire [24:0] re;
  input [49:0] unpack_in;
  wire [49:0] unpack_in;
  assign re = unpack_in[49:25];
  assign im = unpack_in[24:0];
endmodule


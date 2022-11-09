// Created by Verilog::EditFiles from requant.v

module unpack(im, re, unpack_in);
  output [17:0] im;
  wire [17:0] im;
  output [17:0] re;
  wire [17:0] re;
  input [35:0] unpack_in;
  wire [35:0] unpack_in;
  assign re = unpack_in[35:18];
  assign im = unpack_in[17:0];
endmodule


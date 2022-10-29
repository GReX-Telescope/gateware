/* Generated by Yosys 0.21 (git sha1 e6d2a900a97, gcc 12.2.0 -march=x86-64 -mtune=generic -O2 -fno-plt -fexceptions -fstack-clash-protection -fcf-protection -fPIC -Os) */

module fifo(w_en, r_en, r_data, rst, clk, w_data);
  reg \$auto$verilog_backend.cc:2083:dump_module$1  = 0;
  wire \$1 ;
  wire \$3 ;
  wire \$5 ;
  wire [11:0] \$7 ;
  wire [11:0] \$8 ;
  input clk;
  wire clk;
  wire [10:0] level;
  output [63:0] r_data;
  wire [63:0] r_data;
  input r_en;
  wire r_en;
  wire [10:0] r_level;
  reg r_rdy = 1'h0;
  reg \r_rdy$next ;
  input rst;
  wire rst;
  wire [10:0] unbuffered_level;
  wire [63:0] unbuffered_r_data;
  wire unbuffered_r_en;
  wire unbuffered_r_rdy;
  wire [63:0] unbuffered_w_data;
  wire unbuffered_w_en;
  wire unbuffered_w_rdy;
  input [63:0] w_data;
  wire [63:0] w_data;
  input w_en;
  wire w_en;
  wire [10:0] w_level;
  wire w_rdy;
  always @(posedge clk)
    r_rdy <= \r_rdy$next ;
  assign \$1  = ~ r_rdy;
  assign \$3  = \$1  | r_en;
  assign \$5  = unbuffered_r_rdy & \$3 ;
  assign \$8  = unbuffered_level + r_rdy;
  unbuffered unbuffered (
    .clk(clk),
    .level(unbuffered_level),
    .r_data(unbuffered_r_data),
    .r_en(unbuffered_r_en),
    .r_rdy(unbuffered_r_rdy),
    .rst(rst),
    .w_data(unbuffered_w_data),
    .w_en(unbuffered_w_en),
    .w_rdy(unbuffered_w_rdy)
  );
  always @* begin
    if (\$auto$verilog_backend.cc:2083:dump_module$1 ) begin end
    \r_rdy$next  = r_rdy;
    casez ({ r_en, unbuffered_r_en })
      2'b?1:
          \r_rdy$next  = 1'h1;
      2'b1?:
          \r_rdy$next  = 1'h0;
    endcase
    casez (rst)
      1'h1:
          \r_rdy$next  = 1'h0;
    endcase
  end
  assign \$7  = \$8 ;
  assign r_level = level;
  assign w_level = level;
  assign level = \$8 [10:0];
  assign unbuffered_r_en = \$5 ;
  assign r_data = unbuffered_r_data;
  assign w_rdy = unbuffered_w_rdy;
  assign unbuffered_w_en = w_en;
  assign unbuffered_w_data = w_data;
endmodule
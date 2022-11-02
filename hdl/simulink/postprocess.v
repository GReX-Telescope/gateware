module postprocess(in_b, arm, sync_in, ce, gain, tx_data, tx_valid, tx_eof, addr, ovf_a, ovf_b, clk, rst, in_a);
reg \$auto$verilog_backend.cc:
    2083:
      dump_module$5  = 0;
  output [10:0] addr;
  wire [10:0] addr;
  input arm;
  wire arm;
  input ce;
  wire ce;
  wire \ce$1 ;
  input clk;
  wire clk;
  input [4:0] gain;
  wire [4:0] gain;
  input [23:0] in_a;
  wire [23:0] in_a;
  input [23:0] in_b;
  wire [23:0] in_b;
  output ovf_a;
  wire ovf_a;
  output ovf_b;
  wire ovf_b;
  wire packetizer_arm;
  wire [15:0] packetizer_ch_a_in;
  wire [15:0] packetizer_ch_b_in;
  wire packetizer_sync_in;
  wire [63:0] packetizer_tx_data;
  wire packetizer_tx_eof;
  wire packetizer_tx_valid;
  wire [10:0] requant_a_addr;
  wire requant_a_arm;
  wire requant_a_ce;
  wire [4:0] requant_a_gain;
  wire [23:0] requant_a_input;
  wire [15:0] requant_a_output;
  wire requant_a_overflow;
  wire requant_a_sync_in;
  wire requant_a_sync_out;
  wire requant_b_arm;
  wire requant_b_ce;
  wire [4:0] requant_b_gain;
  wire [23:0] requant_b_input;
  wire [15:0] requant_b_output;
  wire requant_b_overflow;
  wire requant_b_sync_in;
  input rst;
  wire rst;
  input sync_in;
  wire sync_in;
  output [63:0] tx_data;
  reg [63:0] tx_data = 64'h0000000000000000;
  reg [63:0] \tx_data$next ;
  output tx_eof;
  reg tx_eof = 1'h0;
  reg \tx_eof$next ;
  output tx_valid;
  reg tx_valid = 1'h0;
  reg \tx_valid$next ;
  always @(posedge clk)
    tx_valid <= \tx_valid$next ;
  always @(posedge clk)
    tx_data <= \tx_data$next ;
  always @(posedge clk)
    tx_eof <= \tx_eof$next ;
  packetizer packetizer (
               .arm(packetizer_arm),
               .ch_a_in(packetizer_ch_a_in),
               .ch_b_in(packetizer_ch_b_in),
               .clk(clk),
               .rst(rst),
               .sync_in(packetizer_sync_in),
               .tx_data(packetizer_tx_data),
               .tx_eof(packetizer_tx_eof),
               .tx_valid(packetizer_tx_valid)
             );
  requant_a requant_a (
              .addr(requant_a_addr),
              .arm(requant_a_arm),
              .ce(requant_a_ce),
              .clk(clk),
              .gain(requant_a_gain),
              .\input (requant_a_input),
              .\output (requant_a_output),
              .overflow(requant_a_overflow),
              .rst(rst),
              .sync_in(requant_a_sync_in),
              .sync_out(requant_a_sync_out)
            );
  requant_b requant_b (
              .arm(requant_b_arm),
              .ce(requant_b_ce),
              .clk(clk),
              .gain(requant_b_gain),
              .\input (requant_b_input),
              .\output (requant_b_output),
              .overflow(requant_b_overflow),
              .rst(rst),
              .sync_in(requant_b_sync_in)
            );
  always @*
    begin
      if (\$auto$verilog_backend.cc:2083:dump_module$5 )
        begin
        end
      \tx_valid$next  = packetizer_tx_valid;
      casez (rst)
        1'h1:
          \tx_valid$next  = 1'h0;
      endcase
    end
  always @*
    begin
      if (\$auto$verilog_backend.cc:2083:dump_module$5 )
        begin
        end
      \tx_data$next  = packetizer_tx_data;
      casez (rst)
        1'h1:
          \tx_data$next  = 64'h0000000000000000;
      endcase
    end
  always @*
    begin
      if (\$auto$verilog_backend.cc:2083:dump_module$5 )
        begin
        end
      \tx_eof$next  = packetizer_tx_eof;
      casez (rst)
        1'h1:
          \tx_eof$next  = 1'h0;
      endcase
    end
  assign packetizer_sync_in = requant_a_sync_out;
  assign packetizer_ch_b_in = requant_b_output;
  assign packetizer_ch_a_in = requant_a_output;
  assign \ce$1  = ce;
  assign packetizer_arm = arm;
  assign ovf_b = requant_b_overflow;
  assign requant_b_ce = ce;
  assign requant_b_arm = arm;
  assign requant_b_gain = gain;
  assign requant_b_sync_in = sync_in;
  assign requant_b_input = in_b;
  assign ovf_a = requant_a_overflow;
  assign addr = requant_a_addr;
  assign requant_a_ce = ce;
  assign requant_a_arm = arm;
  assign requant_a_gain = gain;
  assign requant_a_sync_in = sync_in;
  assign requant_a_input = in_a;
endmodule
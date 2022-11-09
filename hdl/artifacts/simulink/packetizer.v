// Created by Verilog::EditFiles from packetizer.v

module packetizer(pol_b, sync_in, arm, ce, tx_data, tx_valid, tx_eof, clk, rst, pol_a);
  reg \$auto$verilog_backend.cc:2083:dump_module$2  = 0;
  wire \$1 ;
  wire [64:0] \$11 ;
  wire [64:0] \$12 ;
  wire \$14 ;
  wire \$16 ;
  wire \$18 ;
  wire \$20 ;
  wire \$22 ;
  wire \$24 ;
  wire \$26 ;
  wire \$28 ;
  wire \$3 ;
  wire \$30 ;
  wire \$32 ;
  wire \$34 ;
  wire \$36 ;
  wire \$38 ;
  wire [11:0] \$40 ;
  wire [11:0] \$41 ;
  wire \$43 ;
  wire \$45 ;
  wire \$47 ;
  wire [64:0] \$49 ;
  wire \$5 ;
  wire [64:0] \$50 ;
  wire \$52 ;
  wire \$54 ;
  wire \$56 ;
  wire \$58 ;
  wire \$60 ;
  wire \$62 ;
  wire \$64 ;
  wire \$66 ;
  wire \$68 ;
  wire \$7 ;
  wire \$70 ;
  wire \$72 ;
  wire \$74 ;
  wire \$76 ;
  wire \$78 ;
  wire \$80 ;
  wire \$82 ;
  wire \$84 ;
  wire \$86 ;
  wire \$88 ;
  wire \$9 ;
  wire \$90 ;
  wire [11:0] \$92 ;
  wire [11:0] \$93 ;
  wire \$95 ;
  wire \$97 ;
  wire \$99 ;
  input arm;
  wire arm;
  input ce;
  wire ce;
  input clk;
  wire clk;
  reg [10:0] drain_count = 11'h000;
  reg [10:0] \drain_count$next ;
  wire [63:0] fifo_r_data;
  reg fifo_r_en = 1'h0;
  reg \fifo_r_en$next ;
  (* enum_base_type = "FIFOState" *)
  (* enum_value_00 = "Loading" *)
  (* enum_value_01 = "Draining" *)
  (* enum_value_10 = "EOF" *)
  reg [1:0] fifo_state = 2'h0;
  reg [1:0] \fifo_state$next ;
  reg [63:0] fifo_w_data;
  reg fifo_w_en;
  reg high_bit = 1'h0;
  reg \high_bit$next ;
  reg [31:0] last_inputs = 32'd0;
  reg [31:0] \last_inputs$next ;
  reg [63:0] payloads = 64'h0000000000000000;
  reg [63:0] \payloads$next ;
  input [15:0] pol_a;
  wire [15:0] pol_a;
  input [15:0] pol_b;
  wire [15:0] pol_b;
  input rst;
  wire rst;
  (* enum_base_type = "PacketizerState" *)
  (* enum_value_00 = "WaitArm" *)
  (* enum_value_01 = "WaitSync" *)
  (* enum_value_10 = "Running" *)
  reg [1:0] state = 2'h0;
  reg [1:0] \state$next ;
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
  reg [10:0] words = 11'h000;
  reg [10:0] \words$next ;
  assign \$9  = words == 11'h400;
  assign \$99  = fifo_state == 2'h2;
  always @(posedge clk)
    state <= \state$next ;
  always @(posedge clk)
    last_inputs <= \last_inputs$next ;
  always @(posedge clk)
    high_bit <= \high_bit$next ;
  always @(posedge clk)
    words <= \words$next ;
  always @(posedge clk)
    payloads <= \payloads$next ;
  always @(posedge clk)
    fifo_state <= \fifo_state$next ;
  always @(posedge clk)
    fifo_r_en <= \fifo_r_en$next ;
  always @(posedge clk)
    tx_valid <= \tx_valid$next ;
  always @(posedge clk)
    tx_data <= \tx_data$next ;
  always @(posedge clk)
    drain_count <= \drain_count$next ;
  always @(posedge clk)
    tx_eof <= \tx_eof$next ;
  assign \$12  = payloads + 1'h1;
  assign \$14  = state == 2'h1;
  assign \$16  = state == 2'h2;
  assign \$18  = ~ high_bit;
  assign \$1  = state == 2'h1;
  assign \$20  = words == 11'h400;
  assign \$22  = state == 2'h2;
  assign \$24  = ~ high_bit;
  assign \$26  = state == 2'h2;
  assign \$28  = ~ high_bit;
  assign \$30  = ~ high_bit;
  assign \$32  = ~ high_bit;
  assign \$34  = state == 2'h2;
  assign \$36  = ~ high_bit;
  assign \$38  = words == 11'h400;
  assign \$3  = state == 2'h1;
  assign \$41  = words + 1'h1;
  assign \$43  = state == 2'h2;
  assign \$45  = ~ high_bit;
  assign \$47  = words == 11'h400;
  assign \$50  = payloads + 1'h1;
  assign \$52  = state == 2'h2;
  assign \$54  = ~ high_bit;
  assign \$56  = words == 11'h400;
  assign \$58  = fifo_state == 2'h1;
  assign \$5  = state == 2'h2;
  assign \$60  = fifo_state == 2'h2;
  assign \$62  = drain_count == 10'h3ff;
  assign \$64  = state == 2'h2;
  assign \$66  = ~ high_bit;
  assign \$68  = words == 11'h400;
  assign \$70  = fifo_state == 2'h1;
  assign \$72  = fifo_state == 2'h2;
  assign \$74  = state == 2'h2;
  assign \$76  = fifo_state == 2'h1;
  assign \$78  = fifo_state == 2'h2;
  assign \$7  = ~ high_bit;
  assign \$80  = state == 2'h2;
  assign \$82  = fifo_state == 2'h1;
  assign \$84  = fifo_state == 2'h2;
  assign \$86  = state == 2'h2;
  assign \$88  = fifo_state == 2'h1;
  assign \$90  = fifo_state == 2'h2;
  assign \$93  = drain_count + 1'h1;
  assign \$95  = state == 2'h2;
  assign \$97  = fifo_state == 2'h1;
  fifo fifo (
    .clk(clk),
    .r_data(fifo_r_data),
    .r_en(fifo_r_en),
    .rst(rst),
    .w_data(fifo_w_data),
    .w_en(fifo_w_en)
  );
  always @* begin
    if (\$auto$verilog_backend.cc:2083:dump_module$2 ) begin end
    \state$next  = state;
    casez (ce)
      1'h1:
        begin
          casez (arm)
            1'h1:
                \state$next  = 2'h1;
          endcase
          casez (sync_in)
            1'h1:
                casez (\$1 )
                  1'h1:
                      \state$next  = 2'h2;
                endcase
          endcase
        end
    endcase
    casez (rst)
      1'h1:
          \state$next  = 2'h0;
    endcase
  end
  always @* begin
    if (\$auto$verilog_backend.cc:2083:dump_module$2 ) begin end
    fifo_w_data = 64'h0000000000000000;
    casez (ce)
      1'h1:
        begin
          casez (sync_in)
            1'h1:
                casez (\$3 )
                  1'h1:
                      fifo_w_data = payloads;
                endcase
          endcase
          casez (\$5 )
            1'h1:
                (* full_case = 32'd1 *)
                casez (\$7 )
                  1'h1:
                      casez (\$9 )
                        1'h1:
                            fifo_w_data = \$12 [63:0];
                      endcase
                  default:
                      fifo_w_data = { pol_a, pol_b, last_inputs };
                endcase
          endcase
        end
    endcase
  end
  always @* begin
    if (\$auto$verilog_backend.cc:2083:dump_module$2 ) begin end
    \tx_data$next  = tx_data;
    casez (ce)
      1'h1:
          casez (\$80 )
            1'h1:
                (* full_case = 32'd1 *)
                casez ({ \$84 , \$82  })
                  2'b?1:
                      \tx_data$next  = fifo_r_data;
                  2'b1?:
                      \tx_data$next  = fifo_r_data;
                  default:
                      \tx_data$next  = 64'h0000000000000000;
                endcase
          endcase
    endcase
    casez (rst)
      1'h1:
          \tx_data$next  = 64'h0000000000000000;
    endcase
  end
  always @* begin
    if (\$auto$verilog_backend.cc:2083:dump_module$2 ) begin end
    \drain_count$next  = drain_count;
    casez (ce)
      1'h1:
          casez (\$86 )
            1'h1:
                casez ({ \$90 , \$88  })
                  2'b?1:
                      \drain_count$next  = \$93 [10:0];
                  2'b1?:
                      \drain_count$next  = 11'h000;
                endcase
          endcase
    endcase
    casez (rst)
      1'h1:
          \drain_count$next  = 11'h000;
    endcase
  end
  always @* begin
    if (\$auto$verilog_backend.cc:2083:dump_module$2 ) begin end
    \tx_eof$next  = tx_eof;
    casez (ce)
      1'h1:
          casez (\$95 )
            1'h1:
                (* full_case = 32'd1 *)
                casez ({ \$99 , \$97  })
                  2'b?1:
                      /* empty */;
                  2'b1?:
                      \tx_eof$next  = 1'h1;
                  default:
                      \tx_eof$next  = 1'h0;
                endcase
          endcase
    endcase
    casez (rst)
      1'h1:
          \tx_eof$next  = 1'h0;
    endcase
  end
  always @* begin
    if (\$auto$verilog_backend.cc:2083:dump_module$2 ) begin end
    fifo_w_en = 1'h0;
    casez (ce)
      1'h1:
        begin
          casez (sync_in)
            1'h1:
                casez (\$14 )
                  1'h1:
                      fifo_w_en = 1'h1;
                endcase
          endcase
          casez (\$16 )
            1'h1:
                (* full_case = 32'd1 *)
                casez (\$18 )
                  1'h1:
                      casez (\$20 )
                        1'h1:
                            fifo_w_en = 1'h1;
                      endcase
                  default:
                      fifo_w_en = 1'h1;
                endcase
          endcase
        end
    endcase
  end
  always @* begin
    if (\$auto$verilog_backend.cc:2083:dump_module$2 ) begin end
    \last_inputs$next  = last_inputs;
    casez (ce)
      1'h1:
          casez (\$22 )
            1'h1:
                casez (\$24 )
                  1'h1:
                      \last_inputs$next  = { pol_a, pol_b };
                endcase
          endcase
    endcase
    casez (rst)
      1'h1:
          \last_inputs$next  = 32'd0;
    endcase
  end
  always @* begin
    if (\$auto$verilog_backend.cc:2083:dump_module$2 ) begin end
    \high_bit$next  = high_bit;
    casez (ce)
      1'h1:
          casez (\$26 )
            1'h1:
                (* full_case = 32'd1 *)
                casez (\$28 )
                  1'h1:
                      \high_bit$next  = \$30 ;
                  default:
                      \high_bit$next  = \$32 ;
                endcase
          endcase
    endcase
    casez (rst)
      1'h1:
          \high_bit$next  = 1'h0;
    endcase
  end
  always @* begin
    if (\$auto$verilog_backend.cc:2083:dump_module$2 ) begin end
    \words$next  = words;
    casez (ce)
      1'h1:
          casez (\$34 )
            1'h1:
                (* full_case = 32'd1 *)
                casez (\$36 )
                  1'h1:
                      casez (\$38 )
                        1'h1:
                            \words$next  = 11'h000;
                      endcase
                  default:
                      \words$next  = \$41 [10:0];
                endcase
          endcase
    endcase
    casez (rst)
      1'h1:
          \words$next  = 11'h000;
    endcase
  end
  always @* begin
    if (\$auto$verilog_backend.cc:2083:dump_module$2 ) begin end
    \payloads$next  = payloads;
    casez (ce)
      1'h1:
          casez (\$43 )
            1'h1:
                casez (\$45 )
                  1'h1:
                      casez (\$47 )
                        1'h1:
                            \payloads$next  = \$50 [63:0];
                      endcase
                endcase
          endcase
    endcase
    casez (rst)
      1'h1:
          \payloads$next  = 64'h0000000000000000;
    endcase
  end
  always @* begin
    if (\$auto$verilog_backend.cc:2083:dump_module$2 ) begin end
    \fifo_state$next  = fifo_state;
    casez (ce)
      1'h1:
          casez (\$52 )
            1'h1:
              begin
                casez (\$54 )
                  1'h1:
                      casez (\$56 )
                        1'h1:
                            \fifo_state$next  = 2'h1;
                      endcase
                endcase
                casez ({ \$60 , \$58  })
                  2'b?1:
                      casez (\$62 )
                        1'h1:
                            \fifo_state$next  = 2'h2;
                      endcase
                  2'b1?:
                      \fifo_state$next  = 2'h0;
                endcase
              end
          endcase
    endcase
    casez (rst)
      1'h1:
          \fifo_state$next  = 2'h0;
    endcase
  end
  always @* begin
    if (\$auto$verilog_backend.cc:2083:dump_module$2 ) begin end
    \fifo_r_en$next  = fifo_r_en;
    casez (ce)
      1'h1:
          casez (\$64 )
            1'h1:
              begin
                casez (\$66 )
                  1'h1:
                      casez (\$68 )
                        1'h1:
                            \fifo_r_en$next  = 1'h1;
                      endcase
                endcase
                casez ({ \$72 , \$70  })
                  2'b?1:
                      \fifo_r_en$next  = 1'h1;
                  2'b1?:
                      \fifo_r_en$next  = 1'h0;
                endcase
              end
          endcase
    endcase
    casez (rst)
      1'h1:
          \fifo_r_en$next  = 1'h0;
    endcase
  end
  always @* begin
    if (\$auto$verilog_backend.cc:2083:dump_module$2 ) begin end
    \tx_valid$next  = tx_valid;
    casez (ce)
      1'h1:
          casez (\$74 )
            1'h1:
                (* full_case = 32'd1 *)
                casez ({ \$78 , \$76  })
                  2'b?1:
                      \tx_valid$next  = 1'h1;
                  2'b1?:
                      \tx_valid$next  = 1'h1;
                  default:
                      \tx_valid$next  = 1'h0;
                endcase
          endcase
    endcase
    casez (rst)
      1'h1:
          \tx_valid$next  = 1'h0;
    endcase
  end
  assign \$11  = \$12 ;
  assign \$40  = \$41 ;
  assign \$49  = \$50 ;
  assign \$92  = \$93 ;
endmodule


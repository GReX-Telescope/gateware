// Created by Verilog::EditFiles from packetizer.v

`celldefine
module packetizer(sync_in, ch_a_in, ch_b_in, tx_data, tx_valid, tx_eof, clk, rst, ce);
  reg \$auto$verilog_backend.cc:2083:dump_module$2  = 0;
  wire \$1 ;
  wire \$11 ;
  wire [64:0] \$13 ;
  wire [64:0] \$14 ;
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
  wire [64:0] \$34 ;
  wire [64:0] \$35 ;
  wire \$37 ;
  wire \$39 ;
  wire [11:0] \$41 ;
  wire [11:0] \$42 ;
  wire \$44 ;
  wire \$46 ;
  wire \$48 ;
  wire \$5 ;
  wire \$50 ;
  wire [11:0] \$52 ;
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
  wire [11:0] \$82 ;
  wire [11:0] \$83 ;
  wire \$85 ;
  wire \$87 ;
  wire \$89 ;
  wire \$9 ;
  wire arm;
  input ce;
  wire ce;
  input [15:0] ch_a_in;
  wire [15:0] ch_a_in;
  input [15:0] ch_b_in;
  wire [15:0] ch_b_in;
  input clk;
  wire clk;
  reg [10:0] fifo_drain_count = 11'h000;
  reg [10:0] \fifo_drain_count$next ;
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
  reg [31:0] last_data = 32'd0;
  reg [31:0] \last_data$next ;
  reg low_word = 1'h1;
  reg \low_word$next ;
  reg [63:0] payload_count = 64'h0000000000000000;
  reg [63:0] \payload_count$next ;
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
  reg [10:0] word_count = 11'h000;
  reg [10:0] \word_count$next ;
  assign \$9  = state == 2'h2;
  always @(posedge clk)
    fifo_drain_count <= \fifo_drain_count$next ;
  always @(posedge clk)
    tx_eof <= \tx_eof$next ;
  assign \$11  = word_count == 11'h400;
  assign \$14  = payload_count + 1'h1;
  assign \$16  = state == 2'h1;
  assign \$18  = state == 2'h2;
  assign \$1  = ! state;
  assign \$20  = word_count == 11'h400;
  assign \$22  = state == 2'h2;
  assign \$24  = state == 2'h2;
  assign \$26  = ~ low_word;
  assign \$28  = ~ low_word;
  assign \$30  = state == 2'h2;
  assign \$32  = word_count == 11'h400;
  assign \$35  = payload_count + 1'h1;
  assign \$37  = state == 2'h2;
  assign \$3  = state == 2'h2;
  assign \$39  = word_count == 11'h400;
  assign \$42  = word_count + 1'h1;
  assign \$44  = state == 2'h2;
  assign \$46  = word_count == 11'h400;
  assign \$48  = fifo_state == 2'h1;
  assign \$50  = fifo_state == 2'h2;
  assign \$54  = fifo_drain_count == 12'h3ff;
  assign \$56  = state == 2'h2;
  assign \$58  = word_count == 11'h400;
  assign \$5  = state == 2'h1;
  assign \$60  = fifo_state == 2'h1;
  assign \$62  = fifo_state == 2'h2;
  assign \$64  = state == 2'h2;
  assign \$66  = fifo_state == 2'h1;
  assign \$68  = fifo_state == 2'h2;
  assign \$70  = state == 2'h2;
  assign \$72  = fifo_state == 2'h1;
  assign \$74  = fifo_state == 2'h2;
  assign \$76  = state == 2'h2;
  assign \$78  = fifo_state == 2'h1;
  assign \$7  = state == 2'h1;
  assign \$80  = fifo_state == 2'h2;
  assign \$83  = fifo_drain_count + 1'h1;
  assign \$85  = state == 2'h2;
  assign \$87  = fifo_state == 2'h1;
  assign \$89  = fifo_state == 2'h2;
  always @(posedge clk)
    state <= \state$next ;
  always @(posedge clk)
    last_data <= \last_data$next ;
  always @(posedge clk)
    low_word <= \low_word$next ;
  always @(posedge clk)
    payload_count <= \payload_count$next ;
  always @(posedge clk)
    word_count <= \word_count$next ;
  always @(posedge clk)
    fifo_state <= \fifo_state$next ;
  always @(posedge clk)
    fifo_r_en <= \fifo_r_en$next ;
  always @(posedge clk)
    tx_valid <= \tx_valid$next ;
  always @(posedge clk)
    tx_data <= \tx_data$next ;
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
    casez (arm)
      1'h1:
          casez ({ \$3 , \$1  })
            2'b?1:
                \state$next  = 2'h1;
            2'b1?:
                \state$next  = 2'h1;
          endcase
    endcase
    casez (sync_in)
      1'h1:
          casez (\$5 )
            1'h1:
                \state$next  = 2'h2;
          endcase
    endcase
    casez (rst)
      1'h1:
          \state$next  = 2'h0;
    endcase
  end
  always @* begin
    if (\$auto$verilog_backend.cc:2083:dump_module$2 ) begin end
    fifo_w_data = 64'h0000000000000000;
    casez (sync_in)
      1'h1:
          casez (\$7 )
            1'h1:
                fifo_w_data = payload_count;
          endcase
    endcase
    casez (\$9 )
      1'h1:
          (* full_case = 32'd1 *)
          casez (low_word)
            1'h1:
                casez (\$11 )
                  1'h1:
                      fifo_w_data = \$14 [63:0];
                endcase
            default:
                fifo_w_data = { last_data, ch_a_in, ch_b_in };
          endcase
    endcase
  end
  always @* begin
    if (\$auto$verilog_backend.cc:2083:dump_module$2 ) begin end
    (* full_case = 32'd1 *)
    casez (\$70 )
      1'h1:
          (* full_case = 32'd1 *)
          casez ({ \$74 , \$72  })
            2'b?1:
                \tx_data$next  = fifo_r_data;
            2'b1?:
                \tx_data$next  = fifo_r_data;
            default:
                \tx_data$next  = 64'h0000000000000000;
          endcase
      default:
          \tx_data$next  = 64'h0000000000000000;
    endcase
    casez (rst)
      1'h1:
          \tx_data$next  = 64'h0000000000000000;
    endcase
  end
  always @* begin
    if (\$auto$verilog_backend.cc:2083:dump_module$2 ) begin end
    \fifo_drain_count$next  = fifo_drain_count;
    casez (\$76 )
      1'h1:
          casez ({ \$80 , \$78  })
            2'b?1:
                \fifo_drain_count$next  = \$83 [10:0];
            2'b1?:
                \fifo_drain_count$next  = 11'h000;
          endcase
    endcase
    casez (rst)
      1'h1:
          \fifo_drain_count$next  = 11'h000;
    endcase
  end
  always @* begin
    if (\$auto$verilog_backend.cc:2083:dump_module$2 ) begin end
    \tx_eof$next  = tx_eof;
    (* full_case = 32'd1 *)
    casez (\$85 )
      1'h1:
          (* full_case = 32'd1 *)
          casez ({ \$89 , \$87  })
            2'b?1:
                /* empty */;
            2'b1?:
                \tx_eof$next  = 1'h1;
            default:
                \tx_eof$next  = 1'h0;
          endcase
      default:
          \tx_eof$next  = 1'h0;
    endcase
    casez (rst)
      1'h1:
          \tx_eof$next  = 1'h0;
    endcase
  end
  always @* begin
    if (\$auto$verilog_backend.cc:2083:dump_module$2 ) begin end
    fifo_w_en = 1'h0;
    casez (sync_in)
      1'h1:
          casez (\$16 )
            1'h1:
                fifo_w_en = 1'h1;
          endcase
    endcase
    casez (\$18 )
      1'h1:
          (* full_case = 32'd1 *)
          casez (low_word)
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
  always @* begin
    if (\$auto$verilog_backend.cc:2083:dump_module$2 ) begin end
    \last_data$next  = last_data;
    casez (\$22 )
      1'h1:
          casez (low_word)
            1'h1:
                \last_data$next  = { ch_a_in, ch_b_in };
          endcase
    endcase
    casez (rst)
      1'h1:
          \last_data$next  = 32'd0;
    endcase
  end
  always @* begin
    if (\$auto$verilog_backend.cc:2083:dump_module$2 ) begin end
    \low_word$next  = low_word;
    casez (\$24 )
      1'h1:
          (* full_case = 32'd1 *)
          casez (low_word)
            1'h1:
                \low_word$next  = \$26 ;
            default:
                \low_word$next  = \$28 ;
          endcase
    endcase
    casez (rst)
      1'h1:
          \low_word$next  = 1'h1;
    endcase
  end
  always @* begin
    if (\$auto$verilog_backend.cc:2083:dump_module$2 ) begin end
    \payload_count$next  = payload_count;
    casez (\$30 )
      1'h1:
          casez (low_word)
            1'h1:
                casez (\$32 )
                  1'h1:
                      \payload_count$next  = \$35 [63:0];
                endcase
          endcase
    endcase
    casez (rst)
      1'h1:
          \payload_count$next  = 64'h0000000000000000;
    endcase
  end
  always @* begin
    if (\$auto$verilog_backend.cc:2083:dump_module$2 ) begin end
    \word_count$next  = word_count;
    casez (\$37 )
      1'h1:
          (* full_case = 32'd1 *)
          casez (low_word)
            1'h1:
                casez (\$39 )
                  1'h1:
                      \word_count$next  = 11'h000;
                endcase
            default:
                \word_count$next  = \$42 [10:0];
          endcase
    endcase
    casez (rst)
      1'h1:
          \word_count$next  = 11'h000;
    endcase
  end
  always @* begin
    if (\$auto$verilog_backend.cc:2083:dump_module$2 ) begin end
    \fifo_state$next  = fifo_state;
    casez (\$44 )
      1'h1:
        begin
          casez (low_word)
            1'h1:
                casez (\$46 )
                  1'h1:
                      \fifo_state$next  = 2'h1;
                endcase
          endcase
          casez ({ \$50 , \$48  })
            2'b?1:
                casez (\$54 )
                  1'h1:
                      \fifo_state$next  = 2'h2;
                endcase
            2'b1?:
                \fifo_state$next  = 2'h0;
          endcase
        end
    endcase
    casez (rst)
      1'h1:
          \fifo_state$next  = 2'h0;
    endcase
  end
  always @* begin
    if (\$auto$verilog_backend.cc:2083:dump_module$2 ) begin end
    \fifo_r_en$next  = fifo_r_en;
    casez (\$56 )
      1'h1:
        begin
          casez (low_word)
            1'h1:
                casez (\$58 )
                  1'h1:
                      \fifo_r_en$next  = 1'h1;
                endcase
          endcase
          casez ({ \$62 , \$60  })
            2'b?1:
                \fifo_r_en$next  = 1'h1;
            2'b1?:
                \fifo_r_en$next  = 1'h0;
          endcase
        end
    endcase
    casez (rst)
      1'h1:
          \fifo_r_en$next  = 1'h0;
    endcase
  end
  always @* begin
    if (\$auto$verilog_backend.cc:2083:dump_module$2 ) begin end
    (* full_case = 32'd1 *)
    casez (\$64 )
      1'h1:
          (* full_case = 32'd1 *)
          casez ({ \$68 , \$66  })
            2'b?1:
                \tx_valid$next  = 1'h1;
            2'b1?:
                \tx_valid$next  = 1'h1;
            default:
                \tx_valid$next  = 1'h0;
          endcase
      default:
          \tx_valid$next  = 1'h0;
    endcase
    casez (rst)
      1'h1:
          \tx_valid$next  = 1'h0;
    endcase
  end
  assign \$13  = \$14 ;
  assign \$34  = \$35 ;
  assign \$41  = \$42 ;
  assign \$82  = \$83 ;
  assign arm = 1'h0;
  assign \$52  = 12'h3ff;
endmodule
`endcelldefine


module cm(gain, re, im, im_overflow, re_overflow, \input );
reg \$auto$verilog_backend.cc:
    2083:
      dump_module$1  = 0;
  wire [11:0] \$1 ;
  wire \$11 ;
  wire \$13 ;
  wire \$15 ;
  wire \$17 ;
  wire \$19 ;
  wire \$21 ;
  wire \$23 ;
  wire [16:0] \$3 ;
  wire [11:0] \$5 ;
  wire [16:0] \$7 ;
  wire \$9 ;
  input [4:0] gain;
  wire [4:0] gain;
  output [11:0] im;
  reg [11:0] im;
  wire [16:0] im_gain;
  output im_overflow;
  reg im_overflow;
  input [23:0] \input ;
  wire [23:0] \input ;
  output [11:0] re;
  reg [11:0] re;
  wire [16:0] re_gain;
  output re_overflow;
  reg re_overflow;
  wire [11:0] unpack_im;
  wire [23:0] unpack_input;
  wire [11:0] unpack_re;
  assign \$9  = $signed(im_gain) > $signed(17'h007ff);
  assign \$11  = $signed(im_gain) < $signed(17'h1f800);
  assign \$13  = $signed(im_gain) > $signed(17'h007ff);
  assign \$15  = $signed(im_gain) < $signed(17'h1f800);
  assign \$17  = $signed(re_gain) > $signed(17'h007ff);
  assign \$1  = + gain;
  assign \$19  = $signed(re_gain) < $signed(17'h1f800);
  assign \$21  = $signed(re_gain) > $signed(17'h007ff);
  assign \$23  = $signed(re_gain) < $signed(17'h1f800);
  assign \$3  = $signed(unpack_im) * $signed(\$1 );
  assign \$5  = + gain;
  assign \$7  = $signed(unpack_re) * $signed(\$5 );
  unpack unpack (
           .im(unpack_im),
           .\input (unpack_input),
           .re(unpack_re)
         );
  always @*
    begin
      if (\$auto$verilog_backend.cc:2083:dump_module$1 )
        begin
        end
      (* full_case = 32'd1 *)
      casez ({ \$11 , \$9  })
        2'b?1:
          im_overflow = 1'h1;
        2'b1?:
          im_overflow = 1'h1;
        default:
          im_overflow = 1'h0;
      endcase
    end
  always @*
    begin
      if (\$auto$verilog_backend.cc:2083:dump_module$1 )
        begin
        end
      (* full_case = 32'd1 *)
      casez ({ \$15 , \$13  })
        2'b?1:
          im = 12'h7ff;
        2'b1?:
          im = 12'h800;
        default:
          im = im_gain[11:0];
      endcase
    end
  always @*
    begin
      if (\$auto$verilog_backend.cc:2083:dump_module$1 )
        begin
        end
      (* full_case = 32'd1 *)
      casez ({ \$19 , \$17  })
        2'b?1:
          re_overflow = 1'h1;
        2'b1?:
          re_overflow = 1'h1;
        default:
          re_overflow = 1'h0;
      endcase
    end
  always @*
    begin
      if (\$auto$verilog_backend.cc:2083:dump_module$1 )
        begin
        end
      (* full_case = 32'd1 *)
      casez ({ \$23 , \$21  })
        2'b?1:
          re = 12'h7ff;
        2'b1?:
          re = 12'h800;
        default:
          re = re_gain[11:0];
      endcase
    end
  assign re_gain = \$7 ;
  assign im_gain = \$3 ;
  assign unpack_input = \input ;
endmodule

module \cm$1 (gain, re, im, im_overflow, re_overflow, \input );
reg \$auto$verilog_backend.cc:
    2083:
      dump_module$2  = 0;
  wire [11:0] \$1 ;
  wire \$11 ;
  wire \$13 ;
  wire \$15 ;
  wire \$17 ;
  wire \$19 ;
  wire \$21 ;
  wire \$23 ;
  wire [16:0] \$3 ;
  wire [11:0] \$5 ;
  wire [16:0] \$7 ;
  wire \$9 ;
  input [4:0] gain;
  wire [4:0] gain;
  output [11:0] im;
  reg [11:0] im;
  wire [16:0] im_gain;
  output im_overflow;
  reg im_overflow;
  input [23:0] \input ;
  wire [23:0] \input ;
  output [11:0] re;
  reg [11:0] re;
  wire [16:0] re_gain;
  output re_overflow;
  reg re_overflow;
  wire [11:0] unpack_im;
  wire [23:0] unpack_input;
  wire [11:0] unpack_re;
  assign \$9  = $signed(im_gain) > $signed(17'h007ff);
  assign \$11  = $signed(im_gain) < $signed(17'h1f800);
  assign \$13  = $signed(im_gain) > $signed(17'h007ff);
  assign \$15  = $signed(im_gain) < $signed(17'h1f800);
  assign \$17  = $signed(re_gain) > $signed(17'h007ff);
  assign \$1  = + gain;
  assign \$19  = $signed(re_gain) < $signed(17'h1f800);
  assign \$21  = $signed(re_gain) > $signed(17'h007ff);
  assign \$23  = $signed(re_gain) < $signed(17'h1f800);
  assign \$3  = $signed(unpack_im) * $signed(\$1 );
  assign \$5  = + gain;
  assign \$7  = $signed(unpack_re) * $signed(\$5 );
  \unpack$2  unpack (
    .im(unpack_im),
    .\input (unpack_input),
    .re(unpack_re)
  );
  always @*
    begin
      if (\$auto$verilog_backend.cc:2083:dump_module$2 )
        begin
        end
      (* full_case = 32'd1 *)
      casez ({ \$11 , \$9  })
        2'b?1:
          im_overflow = 1'h1;
        2'b1?:
          im_overflow = 1'h1;
        default:
          im_overflow = 1'h0;
      endcase
    end
  always @*
    begin
      if (\$auto$verilog_backend.cc:2083:dump_module$2 )
        begin
        end
      (* full_case = 32'd1 *)
      casez ({ \$15 , \$13  })
        2'b?1:
          im = 12'h7ff;
        2'b1?:
          im = 12'h800;
        default:
          im = im_gain[11:0];
      endcase
    end
  always @*
    begin
      if (\$auto$verilog_backend.cc:2083:dump_module$2 )
        begin
        end
      (* full_case = 32'd1 *)
      casez ({ \$19 , \$17  })
        2'b?1:
          re_overflow = 1'h1;
        2'b1?:
          re_overflow = 1'h1;
        default:
          re_overflow = 1'h0;
      endcase
    end
  always @*
    begin
      if (\$auto$verilog_backend.cc:2083:dump_module$2 )
        begin
        end
      (* full_case = 32'd1 *)
      casez ({ \$23 , \$21  })
        2'b?1:
          re = 12'h7ff;
        2'b1?:
          re = 12'h800;
        default:
          re = re_gain[11:0];
      endcase
    end
  assign re_gain = \$7 ;
  assign im_gain = \$3 ;
  assign unpack_input = \input ;
endmodule

module fifo(clk, w_data, w_en, r_en, r_data, rst);
reg \$auto$verilog_backend.cc:
    2083:
      dump_module$3  = 0;
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
  always @*
    begin
      if (\$auto$verilog_backend.cc:2083:dump_module$3 )
        begin
        end
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

module packetizer(ch_a_in, ch_b_in, sync_in, tx_valid, tx_data, tx_eof, rst, clk, arm);
reg \$auto$verilog_backend.cc:
    2083:
      dump_module$4  = 0;
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
  input arm;
  wire arm;
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
  always @*
    begin
      if (\$auto$verilog_backend.cc:2083:dump_module$4 )
        begin
        end
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
  always @*
    begin
      if (\$auto$verilog_backend.cc:2083:dump_module$4 )
        begin
        end
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
  always @*
    begin
      if (\$auto$verilog_backend.cc:2083:dump_module$4 )
        begin
        end
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
  always @*
    begin
      if (\$auto$verilog_backend.cc:2083:dump_module$4 )
        begin
        end
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
  always @*
    begin
      if (\$auto$verilog_backend.cc:2083:dump_module$4 )
        begin
        end
      \tx_eof$next  = tx_eof;
      (* full_case = 32'd1 *)
      casez (\$85 )
        1'h1:
          (* full_case = 32'd1 *)
          casez ({ \$89 , \$87  })
            2'b?1:
              /* empty */
              ;
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
  always @*
    begin
      if (\$auto$verilog_backend.cc:2083:dump_module$4 )
        begin
        end
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
  always @*
    begin
      if (\$auto$verilog_backend.cc:2083:dump_module$4 )
        begin
        end
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
  always @*
    begin
      if (\$auto$verilog_backend.cc:2083:dump_module$4 )
        begin
        end
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
  always @*
    begin
      if (\$auto$verilog_backend.cc:2083:dump_module$4 )
        begin
        end
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
  always @*
    begin
      if (\$auto$verilog_backend.cc:2083:dump_module$4 )
        begin
        end
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
  always @*
    begin
      if (\$auto$verilog_backend.cc:2083:dump_module$4 )
        begin
        end
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
  always @*
    begin
      if (\$auto$verilog_backend.cc:2083:dump_module$4 )
        begin
        end
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
  always @*
    begin
      if (\$auto$verilog_backend.cc:2083:dump_module$4 )
        begin
        end
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
  assign \$52  = 12'h3ff;
endmodule

module requant_a(sync_in, gain, arm, ce, addr, overflow, \output , sync_out, rst, clk, \input );
reg \$auto$verilog_backend.cc:
    2083:
      dump_module$6  = 0;
  wire \$1 ;
  wire \$11 ;
  wire [12:0] \$13 ;
  wire \$15 ;
  wire [11:0] \$17 ;
  wire [11:0] \$18 ;
  wire \$20 ;
  wire \$22 ;
  wire \$24 ;
  wire \$26 ;
  wire \$28 ;
  wire \$3 ;
  wire \$30 ;
  wire \$32 ;
  wire \$34 ;
  wire \$5 ;
  wire \$7 ;
  wire \$9 ;
  output [10:0] addr;
  reg [10:0] addr;
  input arm;
  wire arm;
  input ce;
  wire ce;
  reg [10:0] chan_count = 11'h000;
  reg [10:0] \chan_count$next ;
  input clk;
  wire clk;
  reg [4:0] cm_gain;
  wire [11:0] cm_im;
  wire cm_im_overflow;
  reg [23:0] cm_input;
  wire [11:0] cm_re;
  wire cm_re_overflow;
  input [4:0] gain;
  wire [4:0] gain;
  input [23:0] \input ;
  wire [23:0] \input ;
  reg [11:0] inter_im;
  reg [11:0] inter_re;
  output [15:0] \output ;
  reg [15:0] \output  = 16'h0000;
  reg [15:0] \output$next ;
  output overflow;
  reg overflow = 1'h0;
  reg \overflow$next ;
  input rst;
  wire rst;
  (* enum_base_type = "RequantState" *)
  (* enum_value_00 = "WaitArm" *)
  (* enum_value_01 = "WaitSync" *)
  (* enum_value_10 = "Running" *)
  reg [1:0] state = 2'h0;
  reg [1:0] \state$next ;
  input sync_in;
  wire sync_in;
  output sync_out;
  reg sync_out = 1'h0;
  reg \sync_out$next ;
  assign \$9  = state == 2'h2;
  assign \$11  = state == 2'h2;
  assign \$15  = chan_count == 13'h07ff;
  assign \$18  = chan_count + 1'h1;
  assign \$1  = ! state;
  assign \$20  = state == 2'h2;
  assign \$22  = state == 2'h2;
  assign \$24  = state == 2'h2;
  assign \$26  = state == 2'h2;
  assign \$28  = state == 2'h2;
  assign \$30  = state == 2'h2;
  assign \$32  = state == 2'h2;
  assign \$34  = cm_im_overflow | cm_re_overflow;
  always @(posedge clk)
    state <= \state$next ;
  always @(posedge clk)
    sync_out <= \sync_out$next ;
  always @(posedge clk)
    chan_count <= \chan_count$next ;
  always @(posedge clk)
    \output  <= \output$next ;
  assign \$3  = state == 2'h2;
  always @(posedge clk)
    overflow <= \overflow$next ;
  assign \$5  = state == 2'h1;
  assign \$7  = state == 2'h1;
  cm cm (
       .gain(cm_gain),
       .im(cm_im),
       .im_overflow(cm_im_overflow),
       .\input (cm_input),
       .re(cm_re),
       .re_overflow(cm_re_overflow)
     );
  always @*
    begin
      if (\$auto$verilog_backend.cc:2083:dump_module$6 )
        begin
        end
      \state$next  = state;
      casez (ce)
        1'h1:
          begin
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
          end
      endcase
      casez (rst)
        1'h1:
          \state$next  = 2'h0;
      endcase
    end
  always @*
    begin
      if (\$auto$verilog_backend.cc:2083:dump_module$6 )
        begin
        end
      \sync_out$next  = sync_out;
      casez (ce)
        1'h1:
          begin
            casez (sync_in)
              1'h1:
                casez (\$7 )
                  1'h1:
                    \sync_out$next  = 1'h1;
                endcase
            endcase
            casez (\$9 )
              1'h1:
                \sync_out$next  = 1'h0;
            endcase
          end
      endcase
      casez (rst)
        1'h1:
          \sync_out$next  = 1'h0;
      endcase
    end
  always @*
    begin
      if (\$auto$verilog_backend.cc:2083:dump_module$6 )
        begin
        end
      \chan_count$next  = chan_count;
      casez (ce)
        1'h1:
          casez (\$11 )
            1'h1:
              (* full_case = 32'd1 *)
              casez (\$15 )
                1'h1:
                  \chan_count$next  = 11'h000;
                default:
                  \chan_count$next  = \$18 [10:0];
              endcase
          endcase
      endcase
      casez (rst)
        1'h1:
          \chan_count$next  = 11'h000;
      endcase
    end
  always @*
    begin
      if (\$auto$verilog_backend.cc:2083:dump_module$6 )
        begin
        end
      addr = 11'h000;
      casez (ce)
        1'h1:
          casez (\$20 )
            1'h1:
              addr = chan_count;
          endcase
      endcase
    end
  always @*
    begin
      if (\$auto$verilog_backend.cc:2083:dump_module$6 )
        begin
        end
      cm_input = 24'h000000;
      casez (ce)
        1'h1:
          casez (\$22 )
            1'h1:
              cm_input = \input ;
          endcase
      endcase
    end
  always @*
    begin
      if (\$auto$verilog_backend.cc:2083:dump_module$6 )
        begin
        end
      cm_gain = 5'h00;
      casez (ce)
        1'h1:
          casez (\$24 )
            1'h1:
              cm_gain = gain;
          endcase
      endcase
    end
  always @*
    begin
      if (\$auto$verilog_backend.cc:2083:dump_module$6 )
        begin
        end
      inter_re = 12'h000;
      casez (ce)
        1'h1:
          casez (\$26 )
            1'h1:
              inter_re = cm_re;
          endcase
      endcase
    end
  always @*
    begin
      if (\$auto$verilog_backend.cc:2083:dump_module$6 )
        begin
        end
      inter_im = 12'h000;
      casez (ce)
        1'h1:
          casez (\$28 )
            1'h1:
              inter_im = cm_im;
          endcase
      endcase
    end
  always @*
    begin
      if (\$auto$verilog_backend.cc:2083:dump_module$6 )
        begin
        end
      \output$next  = \output ;
      casez (ce)
        1'h1:
          casez (\$30 )
            1'h1:
              \output$next  = { inter_re[11:4], inter_im[11:4] };
          endcase
      endcase
      casez (rst)
        1'h1:
          \output$next  = 16'h0000;
      endcase
    end
  always @*
    begin
      if (\$auto$verilog_backend.cc:2083:dump_module$6 )
        begin
        end
      \overflow$next  = overflow;
      casez (ce)
        1'h1:
          casez (\$32 )
            1'h1:
              \overflow$next  = \$34 ;
          endcase
      endcase
      casez (rst)
        1'h1:
          \overflow$next  = 1'h0;
      endcase
    end
  assign \$17  = \$18 ;
  assign \$13  = 13'h07ff;
endmodule

module requant_b(sync_in, gain, arm, ce, overflow, \output , rst, clk, \input );
reg \$auto$verilog_backend.cc:
    2083:
      dump_module$7  = 0;
  wire \$1 ;
  wire \$11 ;
  wire [12:0] \$13 ;
  wire \$15 ;
  wire [11:0] \$17 ;
  wire [11:0] \$18 ;
  wire \$20 ;
  wire \$22 ;
  wire \$24 ;
  wire \$26 ;
  wire \$28 ;
  wire \$3 ;
  wire \$30 ;
  wire \$32 ;
  wire \$34 ;
  wire \$5 ;
  wire \$7 ;
  wire \$9 ;
  reg [10:0] addr;
  input arm;
  wire arm;
  input ce;
  wire ce;
  reg [10:0] chan_count = 11'h000;
  reg [10:0] \chan_count$next ;
  input clk;
  wire clk;
  reg [4:0] cm_gain;
  wire [11:0] cm_im;
  wire cm_im_overflow;
  reg [23:0] cm_input;
  wire [11:0] cm_re;
  wire cm_re_overflow;
  input [4:0] gain;
  wire [4:0] gain;
  input [23:0] \input ;
  wire [23:0] \input ;
  reg [11:0] inter_im;
  reg [11:0] inter_re;
  output [15:0] \output ;
  reg [15:0] \output  = 16'h0000;
  reg [15:0] \output$next ;
  output overflow;
  reg overflow = 1'h0;
  reg \overflow$next ;
  input rst;
  wire rst;
  (* enum_base_type = "RequantState" *)
  (* enum_value_00 = "WaitArm" *)
  (* enum_value_01 = "WaitSync" *)
  (* enum_value_10 = "Running" *)
  reg [1:0] state = 2'h0;
  reg [1:0] \state$next ;
  input sync_in;
  wire sync_in;
  reg sync_out = 1'h0;
  reg \sync_out$next ;
  assign \$9  = state == 2'h2;
  assign \$11  = state == 2'h2;
  assign \$15  = chan_count == 13'h07ff;
  assign \$18  = chan_count + 1'h1;
  assign \$1  = ! state;
  assign \$20  = state == 2'h2;
  assign \$22  = state == 2'h2;
  assign \$24  = state == 2'h2;
  assign \$26  = state == 2'h2;
  assign \$28  = state == 2'h2;
  assign \$30  = state == 2'h2;
  assign \$32  = state == 2'h2;
  assign \$34  = cm_im_overflow | cm_re_overflow;
  always @(posedge clk)
    state <= \state$next ;
  always @(posedge clk)
    sync_out <= \sync_out$next ;
  always @(posedge clk)
    chan_count <= \chan_count$next ;
  always @(posedge clk)
    \output  <= \output$next ;
  assign \$3  = state == 2'h2;
  always @(posedge clk)
    overflow <= \overflow$next ;
  assign \$5  = state == 2'h1;
  assign \$7  = state == 2'h1;
  \cm$1  cm (
    .gain(cm_gain),
    .im(cm_im),
    .im_overflow(cm_im_overflow),
    .\input (cm_input),
    .re(cm_re),
    .re_overflow(cm_re_overflow)
  );
  always @*
    begin
      if (\$auto$verilog_backend.cc:2083:dump_module$7 )
        begin
        end
      \state$next  = state;
      casez (ce)
        1'h1:
          begin
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
          end
      endcase
      casez (rst)
        1'h1:
          \state$next  = 2'h0;
      endcase
    end
  always @*
    begin
      if (\$auto$verilog_backend.cc:2083:dump_module$7 )
        begin
        end
      \sync_out$next  = sync_out;
      casez (ce)
        1'h1:
          begin
            casez (sync_in)
              1'h1:
                casez (\$7 )
                  1'h1:
                    \sync_out$next  = 1'h1;
                endcase
            endcase
            casez (\$9 )
              1'h1:
                \sync_out$next  = 1'h0;
            endcase
          end
      endcase
      casez (rst)
        1'h1:
          \sync_out$next  = 1'h0;
      endcase
    end
  always @*
    begin
      if (\$auto$verilog_backend.cc:2083:dump_module$7 )
        begin
        end
      \chan_count$next  = chan_count;
      casez (ce)
        1'h1:
          casez (\$11 )
            1'h1:
              (* full_case = 32'd1 *)
              casez (\$15 )
                1'h1:
                  \chan_count$next  = 11'h000;
                default:
                  \chan_count$next  = \$18 [10:0];
              endcase
          endcase
      endcase
      casez (rst)
        1'h1:
          \chan_count$next  = 11'h000;
      endcase
    end
  always @*
    begin
      if (\$auto$verilog_backend.cc:2083:dump_module$7 )
        begin
        end
      addr = 11'h000;
      casez (ce)
        1'h1:
          casez (\$20 )
            1'h1:
              addr = chan_count;
          endcase
      endcase
    end
  always @*
    begin
      if (\$auto$verilog_backend.cc:2083:dump_module$7 )
        begin
        end
      cm_input = 24'h000000;
      casez (ce)
        1'h1:
          casez (\$22 )
            1'h1:
              cm_input = \input ;
          endcase
      endcase
    end
  always @*
    begin
      if (\$auto$verilog_backend.cc:2083:dump_module$7 )
        begin
        end
      cm_gain = 5'h00;
      casez (ce)
        1'h1:
          casez (\$24 )
            1'h1:
              cm_gain = gain;
          endcase
      endcase
    end
  always @*
    begin
      if (\$auto$verilog_backend.cc:2083:dump_module$7 )
        begin
        end
      inter_re = 12'h000;
      casez (ce)
        1'h1:
          casez (\$26 )
            1'h1:
              inter_re = cm_re;
          endcase
      endcase
    end
  always @*
    begin
      if (\$auto$verilog_backend.cc:2083:dump_module$7 )
        begin
        end
      inter_im = 12'h000;
      casez (ce)
        1'h1:
          casez (\$28 )
            1'h1:
              inter_im = cm_im;
          endcase
      endcase
    end
  always @*
    begin
      if (\$auto$verilog_backend.cc:2083:dump_module$7 )
        begin
        end
      \output$next  = \output ;
      casez (ce)
        1'h1:
          casez (\$30 )
            1'h1:
              \output$next  = { inter_re[11:4], inter_im[11:4] };
          endcase
      endcase
      casez (rst)
        1'h1:
          \output$next  = 16'h0000;
      endcase
    end
  always @*
    begin
      if (\$auto$verilog_backend.cc:2083:dump_module$7 )
        begin
        end
      \overflow$next  = overflow;
      casez (ce)
        1'h1:
          casez (\$32 )
            1'h1:
              \overflow$next  = \$34 ;
          endcase
      endcase
      casez (rst)
        1'h1:
          \overflow$next  = 1'h0;
      endcase
    end
  assign \$17  = \$18 ;
  assign \$13  = 13'h07ff;
endmodule

module unbuffered(clk, w_data, w_en, w_rdy, r_data, r_en, r_rdy, level, rst);
reg \$auto$verilog_backend.cc:
    2083:
      dump_module$8  = 0;
  wire [11:0] \$10 ;
  wire [11:0] \$11 ;
  wire [11:0] \$13 ;
  wire \$14 ;
  wire \$17 ;
  wire [11:0] \$19 ;
  wire \$2 ;
  wire [11:0] \$20 ;
  wire [11:0] \$22 ;
  wire \$23 ;
  wire \$26 ;
  wire \$28 ;
  wire \$29 ;
  wire \$32 ;
  wire [11:0] \$34 ;
  wire [11:0] \$35 ;
  wire \$37 ;
  wire \$39 ;
  wire \$4 ;
  wire \$40 ;
  wire \$43 ;
  wire [11:0] \$45 ;
  wire [11:0] \$46 ;
  wire \$6 ;
  wire \$8 ;
  input clk;
  wire clk;
  reg [10:0] consume = 11'h000;
  reg [10:0] \consume$next ;
  output [10:0] level;
  reg [10:0] level = 11'h000;
  reg [10:0] \level$next ;
  reg [10:0] produce = 11'h000;
  reg [10:0] \produce$next ;
  output [63:0] r_data;
  wire [63:0] r_data;
  input r_en;
  wire r_en;
  wire [10:0] r_level;
  output r_rdy;
  wire r_rdy;
  input rst;
  wire rst;
  wire [10:0] storage_r_addr;
  wire [63:0] storage_r_data;
  wire storage_r_en;
  wire [10:0] storage_w_addr;
  wire [63:0] storage_w_data;
  wire storage_w_en;
  input [63:0] w_data;
  wire [63:0] w_data;
  input w_en;
  wire w_en;
  wire [10:0] w_level;
  output w_rdy;
  wire w_rdy;
  reg [63:0] storage [1033:0];
  initialbegin
    storage[0] = 64'h0000000000000000;
  storage[1] = 64'h0000000000000000;
  storage[2] = 64'h0000000000000000;
  storage[3] = 64'h0000000000000000;
  storage[4] = 64'h0000000000000000;
  storage[5] = 64'h0000000000000000;
  storage[6] = 64'h0000000000000000;
  storage[7] = 64'h0000000000000000;
  storage[8] = 64'h0000000000000000;
  storage[9] = 64'h0000000000000000;
  storage[10] = 64'h0000000000000000;
  storage[11] = 64'h0000000000000000;
  storage[12] = 64'h0000000000000000;
  storage[13] = 64'h0000000000000000;
  storage[14] = 64'h0000000000000000;
  storage[15] = 64'h0000000000000000;
  storage[16] = 64'h0000000000000000;
  storage[17] = 64'h0000000000000000;
  storage[18] = 64'h0000000000000000;
  storage[19] = 64'h0000000000000000;
  storage[20] = 64'h0000000000000000;
  storage[21] = 64'h0000000000000000;
  storage[22] = 64'h0000000000000000;
  storage[23] = 64'h0000000000000000;
  storage[24] = 64'h0000000000000000;
  storage[25] = 64'h0000000000000000;
  storage[26] = 64'h0000000000000000;
  storage[27] = 64'h0000000000000000;
  storage[28] = 64'h0000000000000000;
  storage[29] = 64'h0000000000000000;
  storage[30] = 64'h0000000000000000;
  storage[31] = 64'h0000000000000000;
  storage[32] = 64'h0000000000000000;
  storage[33] = 64'h0000000000000000;
  storage[34] = 64'h0000000000000000;
  storage[35] = 64'h0000000000000000;
  storage[36] = 64'h0000000000000000;
  storage[37] = 64'h0000000000000000;
  storage[38] = 64'h0000000000000000;
  storage[39] = 64'h0000000000000000;
  storage[40] = 64'h0000000000000000;
  storage[41] = 64'h0000000000000000;
  storage[42] = 64'h0000000000000000;
  storage[43] = 64'h0000000000000000;
  storage[44] = 64'h0000000000000000;
  storage[45] = 64'h0000000000000000;
  storage[46] = 64'h0000000000000000;
  storage[47] = 64'h0000000000000000;
  storage[48] = 64'h0000000000000000;
  storage[49] = 64'h0000000000000000;
  storage[50] = 64'h0000000000000000;
  storage[51] = 64'h0000000000000000;
  storage[52] = 64'h0000000000000000;
  storage[53] = 64'h0000000000000000;
  storage[54] = 64'h0000000000000000;
  storage[55] = 64'h0000000000000000;
  storage[56] = 64'h0000000000000000;
  storage[57] = 64'h0000000000000000;
  storage[58] = 64'h0000000000000000;
  storage[59] = 64'h0000000000000000;
  storage[60] = 64'h0000000000000000;
  storage[61] = 64'h0000000000000000;
  storage[62] = 64'h0000000000000000;
  storage[63] = 64'h0000000000000000;
  storage[64] = 64'h0000000000000000;
  storage[65] = 64'h0000000000000000;
  storage[66] = 64'h0000000000000000;
  storage[67] = 64'h0000000000000000;
  storage[68] = 64'h0000000000000000;
  storage[69] = 64'h0000000000000000;
  storage[70] = 64'h0000000000000000;
  storage[71] = 64'h0000000000000000;
  storage[72] = 64'h0000000000000000;
  storage[73] = 64'h0000000000000000;
  storage[74] = 64'h0000000000000000;
  storage[75] = 64'h0000000000000000;
  storage[76] = 64'h0000000000000000;
  storage[77] = 64'h0000000000000000;
  storage[78] = 64'h0000000000000000;
  storage[79] = 64'h0000000000000000;
  storage[80] = 64'h0000000000000000;
  storage[81] = 64'h0000000000000000;
  storage[82] = 64'h0000000000000000;
  storage[83] = 64'h0000000000000000;
  storage[84] = 64'h0000000000000000;
  storage[85] = 64'h0000000000000000;
  storage[86] = 64'h0000000000000000;
  storage[87] = 64'h0000000000000000;
  storage[88] = 64'h0000000000000000;
  storage[89] = 64'h0000000000000000;
  storage[90] = 64'h0000000000000000;
  storage[91] = 64'h0000000000000000;
  storage[92] = 64'h0000000000000000;
  storage[93] = 64'h0000000000000000;
  storage[94] = 64'h0000000000000000;
  storage[95] = 64'h0000000000000000;
  storage[96] = 64'h0000000000000000;
  storage[97] = 64'h0000000000000000;
  storage[98] = 64'h0000000000000000;
  storage[99] = 64'h0000000000000000;
  storage[100] = 64'h0000000000000000;
  storage[101] = 64'h0000000000000000;
  storage[102] = 64'h0000000000000000;
  storage[103] = 64'h0000000000000000;
  storage[104] = 64'h0000000000000000;
  storage[105] = 64'h0000000000000000;
  storage[106] = 64'h0000000000000000;
  storage[107] = 64'h0000000000000000;
  storage[108] = 64'h0000000000000000;
  storage[109] = 64'h0000000000000000;
  storage[110] = 64'h0000000000000000;
  storage[111] = 64'h0000000000000000;
  storage[112] = 64'h0000000000000000;
  storage[113] = 64'h0000000000000000;
  storage[114] = 64'h0000000000000000;
  storage[115] = 64'h0000000000000000;
  storage[116] = 64'h0000000000000000;
  storage[117] = 64'h0000000000000000;
  storage[118] = 64'h0000000000000000;
  storage[119] = 64'h0000000000000000;
  storage[120] = 64'h0000000000000000;
  storage[121] = 64'h0000000000000000;
  storage[122] = 64'h0000000000000000;
  storage[123] = 64'h0000000000000000;
  storage[124] = 64'h0000000000000000;
  storage[125] = 64'h0000000000000000;
  storage[126] = 64'h0000000000000000;
  storage[127] = 64'h0000000000000000;
  storage[128] = 64'h0000000000000000;
  storage[129] = 64'h0000000000000000;
  storage[130] = 64'h0000000000000000;
  storage[131] = 64'h0000000000000000;
  storage[132] = 64'h0000000000000000;
  storage[133] = 64'h0000000000000000;
  storage[134] = 64'h0000000000000000;
  storage[135] = 64'h0000000000000000;
  storage[136] = 64'h0000000000000000;
  storage[137] = 64'h0000000000000000;
  storage[138] = 64'h0000000000000000;
  storage[139] = 64'h0000000000000000;
  storage[140] = 64'h0000000000000000;
  storage[141] = 64'h0000000000000000;
  storage[142] = 64'h0000000000000000;
  storage[143] = 64'h0000000000000000;
  storage[144] = 64'h0000000000000000;
  storage[145] = 64'h0000000000000000;
  storage[146] = 64'h0000000000000000;
  storage[147] = 64'h0000000000000000;
  storage[148] = 64'h0000000000000000;
  storage[149] = 64'h0000000000000000;
  storage[150] = 64'h0000000000000000;
  storage[151] = 64'h0000000000000000;
  storage[152] = 64'h0000000000000000;
  storage[153] = 64'h0000000000000000;
  storage[154] = 64'h0000000000000000;
  storage[155] = 64'h0000000000000000;
  storage[156] = 64'h0000000000000000;
  storage[157] = 64'h0000000000000000;
  storage[158] = 64'h0000000000000000;
  storage[159] = 64'h0000000000000000;
  storage[160] = 64'h0000000000000000;
  storage[161] = 64'h0000000000000000;
  storage[162] = 64'h0000000000000000;
  storage[163] = 64'h0000000000000000;
  storage[164] = 64'h0000000000000000;
  storage[165] = 64'h0000000000000000;
  storage[166] = 64'h0000000000000000;
  storage[167] = 64'h0000000000000000;
  storage[168] = 64'h0000000000000000;
  storage[169] = 64'h0000000000000000;
  storage[170] = 64'h0000000000000000;
  storage[171] = 64'h0000000000000000;
  storage[172] = 64'h0000000000000000;
  storage[173] = 64'h0000000000000000;
  storage[174] = 64'h0000000000000000;
  storage[175] = 64'h0000000000000000;
  storage[176] = 64'h0000000000000000;
  storage[177] = 64'h0000000000000000;
  storage[178] = 64'h0000000000000000;
  storage[179] = 64'h0000000000000000;
  storage[180] = 64'h0000000000000000;
  storage[181] = 64'h0000000000000000;
  storage[182] = 64'h0000000000000000;
  storage[183] = 64'h0000000000000000;
  storage[184] = 64'h0000000000000000;
  storage[185] = 64'h0000000000000000;
  storage[186] = 64'h0000000000000000;
  storage[187] = 64'h0000000000000000;
  storage[188] = 64'h0000000000000000;
  storage[189] = 64'h0000000000000000;
  storage[190] = 64'h0000000000000000;
  storage[191] = 64'h0000000000000000;
  storage[192] = 64'h0000000000000000;
  storage[193] = 64'h0000000000000000;
  storage[194] = 64'h0000000000000000;
  storage[195] = 64'h0000000000000000;
  storage[196] = 64'h0000000000000000;
  storage[197] = 64'h0000000000000000;
  storage[198] = 64'h0000000000000000;
  storage[199] = 64'h0000000000000000;
  storage[200] = 64'h0000000000000000;
  storage[201] = 64'h0000000000000000;
  storage[202] = 64'h0000000000000000;
  storage[203] = 64'h0000000000000000;
  storage[204] = 64'h0000000000000000;
  storage[205] = 64'h0000000000000000;
  storage[206] = 64'h0000000000000000;
  storage[207] = 64'h0000000000000000;
  storage[208] = 64'h0000000000000000;
  storage[209] = 64'h0000000000000000;
  storage[210] = 64'h0000000000000000;
  storage[211] = 64'h0000000000000000;
  storage[212] = 64'h0000000000000000;
  storage[213] = 64'h0000000000000000;
  storage[214] = 64'h0000000000000000;
  storage[215] = 64'h0000000000000000;
  storage[216] = 64'h0000000000000000;
  storage[217] = 64'h0000000000000000;
  storage[218] = 64'h0000000000000000;
  storage[219] = 64'h0000000000000000;
  storage[220] = 64'h0000000000000000;
  storage[221] = 64'h0000000000000000;
  storage[222] = 64'h0000000000000000;
  storage[223] = 64'h0000000000000000;
  storage[224] = 64'h0000000000000000;
  storage[225] = 64'h0000000000000000;
  storage[226] = 64'h0000000000000000;
  storage[227] = 64'h0000000000000000;
  storage[228] = 64'h0000000000000000;
  storage[229] = 64'h0000000000000000;
  storage[230] = 64'h0000000000000000;
  storage[231] = 64'h0000000000000000;
  storage[232] = 64'h0000000000000000;
  storage[233] = 64'h0000000000000000;
  storage[234] = 64'h0000000000000000;
  storage[235] = 64'h0000000000000000;
  storage[236] = 64'h0000000000000000;
  storage[237] = 64'h0000000000000000;
  storage[238] = 64'h0000000000000000;
  storage[239] = 64'h0000000000000000;
  storage[240] = 64'h0000000000000000;
  storage[241] = 64'h0000000000000000;
  storage[242] = 64'h0000000000000000;
  storage[243] = 64'h0000000000000000;
  storage[244] = 64'h0000000000000000;
  storage[245] = 64'h0000000000000000;
  storage[246] = 64'h0000000000000000;
  storage[247] = 64'h0000000000000000;
  storage[248] = 64'h0000000000000000;
  storage[249] = 64'h0000000000000000;
  storage[250] = 64'h0000000000000000;
  storage[251] = 64'h0000000000000000;
  storage[252] = 64'h0000000000000000;
  storage[253] = 64'h0000000000000000;
  storage[254] = 64'h0000000000000000;
  storage[255] = 64'h0000000000000000;
  storage[256] = 64'h0000000000000000;
  storage[257] = 64'h0000000000000000;
  storage[258] = 64'h0000000000000000;
  storage[259] = 64'h0000000000000000;
  storage[260] = 64'h0000000000000000;
  storage[261] = 64'h0000000000000000;
  storage[262] = 64'h0000000000000000;
  storage[263] = 64'h0000000000000000;
  storage[264] = 64'h0000000000000000;
  storage[265] = 64'h0000000000000000;
  storage[266] = 64'h0000000000000000;
  storage[267] = 64'h0000000000000000;
  storage[268] = 64'h0000000000000000;
  storage[269] = 64'h0000000000000000;
  storage[270] = 64'h0000000000000000;
  storage[271] = 64'h0000000000000000;
  storage[272] = 64'h0000000000000000;
  storage[273] = 64'h0000000000000000;
  storage[274] = 64'h0000000000000000;
  storage[275] = 64'h0000000000000000;
  storage[276] = 64'h0000000000000000;
  storage[277] = 64'h0000000000000000;
  storage[278] = 64'h0000000000000000;
  storage[279] = 64'h0000000000000000;
  storage[280] = 64'h0000000000000000;
  storage[281] = 64'h0000000000000000;
  storage[282] = 64'h0000000000000000;
  storage[283] = 64'h0000000000000000;
  storage[284] = 64'h0000000000000000;
  storage[285] = 64'h0000000000000000;
  storage[286] = 64'h0000000000000000;
  storage[287] = 64'h0000000000000000;
  storage[288] = 64'h0000000000000000;
  storage[289] = 64'h0000000000000000;
  storage[290] = 64'h0000000000000000;
  storage[291] = 64'h0000000000000000;
  storage[292] = 64'h0000000000000000;
  storage[293] = 64'h0000000000000000;
  storage[294] = 64'h0000000000000000;
  storage[295] = 64'h0000000000000000;
  storage[296] = 64'h0000000000000000;
  storage[297] = 64'h0000000000000000;
  storage[298] = 64'h0000000000000000;
  storage[299] = 64'h0000000000000000;
  storage[300] = 64'h0000000000000000;
  storage[301] = 64'h0000000000000000;
  storage[302] = 64'h0000000000000000;
  storage[303] = 64'h0000000000000000;
  storage[304] = 64'h0000000000000000;
  storage[305] = 64'h0000000000000000;
  storage[306] = 64'h0000000000000000;
  storage[307] = 64'h0000000000000000;
  storage[308] = 64'h0000000000000000;
  storage[309] = 64'h0000000000000000;
  storage[310] = 64'h0000000000000000;
  storage[311] = 64'h0000000000000000;
  storage[312] = 64'h0000000000000000;
  storage[313] = 64'h0000000000000000;
  storage[314] = 64'h0000000000000000;
  storage[315] = 64'h0000000000000000;
  storage[316] = 64'h0000000000000000;
  storage[317] = 64'h0000000000000000;
  storage[318] = 64'h0000000000000000;
  storage[319] = 64'h0000000000000000;
  storage[320] = 64'h0000000000000000;
  storage[321] = 64'h0000000000000000;
  storage[322] = 64'h0000000000000000;
  storage[323] = 64'h0000000000000000;
  storage[324] = 64'h0000000000000000;
  storage[325] = 64'h0000000000000000;
  storage[326] = 64'h0000000000000000;
  storage[327] = 64'h0000000000000000;
  storage[328] = 64'h0000000000000000;
  storage[329] = 64'h0000000000000000;
  storage[330] = 64'h0000000000000000;
  storage[331] = 64'h0000000000000000;
  storage[332] = 64'h0000000000000000;
  storage[333] = 64'h0000000000000000;
  storage[334] = 64'h0000000000000000;
  storage[335] = 64'h0000000000000000;
  storage[336] = 64'h0000000000000000;
  storage[337] = 64'h0000000000000000;
  storage[338] = 64'h0000000000000000;
  storage[339] = 64'h0000000000000000;
  storage[340] = 64'h0000000000000000;
  storage[341] = 64'h0000000000000000;
  storage[342] = 64'h0000000000000000;
  storage[343] = 64'h0000000000000000;
  storage[344] = 64'h0000000000000000;
  storage[345] = 64'h0000000000000000;
  storage[346] = 64'h0000000000000000;
  storage[347] = 64'h0000000000000000;
  storage[348] = 64'h0000000000000000;
  storage[349] = 64'h0000000000000000;
  storage[350] = 64'h0000000000000000;
  storage[351] = 64'h0000000000000000;
  storage[352] = 64'h0000000000000000;
  storage[353] = 64'h0000000000000000;
  storage[354] = 64'h0000000000000000;
  storage[355] = 64'h0000000000000000;
  storage[356] = 64'h0000000000000000;
  storage[357] = 64'h0000000000000000;
  storage[358] = 64'h0000000000000000;
  storage[359] = 64'h0000000000000000;
  storage[360] = 64'h0000000000000000;
  storage[361] = 64'h0000000000000000;
  storage[362] = 64'h0000000000000000;
  storage[363] = 64'h0000000000000000;
  storage[364] = 64'h0000000000000000;
  storage[365] = 64'h0000000000000000;
  storage[366] = 64'h0000000000000000;
  storage[367] = 64'h0000000000000000;
  storage[368] = 64'h0000000000000000;
  storage[369] = 64'h0000000000000000;
  storage[370] = 64'h0000000000000000;
  storage[371] = 64'h0000000000000000;
  storage[372] = 64'h0000000000000000;
  storage[373] = 64'h0000000000000000;
  storage[374] = 64'h0000000000000000;
  storage[375] = 64'h0000000000000000;
  storage[376] = 64'h0000000000000000;
  storage[377] = 64'h0000000000000000;
  storage[378] = 64'h0000000000000000;
  storage[379] = 64'h0000000000000000;
  storage[380] = 64'h0000000000000000;
  storage[381] = 64'h0000000000000000;
  storage[382] = 64'h0000000000000000;
  storage[383] = 64'h0000000000000000;
  storage[384] = 64'h0000000000000000;
  storage[385] = 64'h0000000000000000;
  storage[386] = 64'h0000000000000000;
  storage[387] = 64'h0000000000000000;
  storage[388] = 64'h0000000000000000;
  storage[389] = 64'h0000000000000000;
  storage[390] = 64'h0000000000000000;
  storage[391] = 64'h0000000000000000;
  storage[392] = 64'h0000000000000000;
  storage[393] = 64'h0000000000000000;
  storage[394] = 64'h0000000000000000;
  storage[395] = 64'h0000000000000000;
  storage[396] = 64'h0000000000000000;
  storage[397] = 64'h0000000000000000;
  storage[398] = 64'h0000000000000000;
  storage[399] = 64'h0000000000000000;
  storage[400] = 64'h0000000000000000;
  storage[401] = 64'h0000000000000000;
  storage[402] = 64'h0000000000000000;
  storage[403] = 64'h0000000000000000;
  storage[404] = 64'h0000000000000000;
  storage[405] = 64'h0000000000000000;
  storage[406] = 64'h0000000000000000;
  storage[407] = 64'h0000000000000000;
  storage[408] = 64'h0000000000000000;
  storage[409] = 64'h0000000000000000;
  storage[410] = 64'h0000000000000000;
  storage[411] = 64'h0000000000000000;
  storage[412] = 64'h0000000000000000;
  storage[413] = 64'h0000000000000000;
  storage[414] = 64'h0000000000000000;
  storage[415] = 64'h0000000000000000;
  storage[416] = 64'h0000000000000000;
  storage[417] = 64'h0000000000000000;
  storage[418] = 64'h0000000000000000;
  storage[419] = 64'h0000000000000000;
  storage[420] = 64'h0000000000000000;
  storage[421] = 64'h0000000000000000;
  storage[422] = 64'h0000000000000000;
  storage[423] = 64'h0000000000000000;
  storage[424] = 64'h0000000000000000;
  storage[425] = 64'h0000000000000000;
  storage[426] = 64'h0000000000000000;
  storage[427] = 64'h0000000000000000;
  storage[428] = 64'h0000000000000000;
  storage[429] = 64'h0000000000000000;
  storage[430] = 64'h0000000000000000;
  storage[431] = 64'h0000000000000000;
  storage[432] = 64'h0000000000000000;
  storage[433] = 64'h0000000000000000;
  storage[434] = 64'h0000000000000000;
  storage[435] = 64'h0000000000000000;
  storage[436] = 64'h0000000000000000;
  storage[437] = 64'h0000000000000000;
  storage[438] = 64'h0000000000000000;
  storage[439] = 64'h0000000000000000;
  storage[440] = 64'h0000000000000000;
  storage[441] = 64'h0000000000000000;
  storage[442] = 64'h0000000000000000;
  storage[443] = 64'h0000000000000000;
  storage[444] = 64'h0000000000000000;
  storage[445] = 64'h0000000000000000;
  storage[446] = 64'h0000000000000000;
  storage[447] = 64'h0000000000000000;
  storage[448] = 64'h0000000000000000;
  storage[449] = 64'h0000000000000000;
  storage[450] = 64'h0000000000000000;
  storage[451] = 64'h0000000000000000;
  storage[452] = 64'h0000000000000000;
  storage[453] = 64'h0000000000000000;
  storage[454] = 64'h0000000000000000;
  storage[455] = 64'h0000000000000000;
  storage[456] = 64'h0000000000000000;
  storage[457] = 64'h0000000000000000;
  storage[458] = 64'h0000000000000000;
  storage[459] = 64'h0000000000000000;
  storage[460] = 64'h0000000000000000;
  storage[461] = 64'h0000000000000000;
  storage[462] = 64'h0000000000000000;
  storage[463] = 64'h0000000000000000;
  storage[464] = 64'h0000000000000000;
  storage[465] = 64'h0000000000000000;
  storage[466] = 64'h0000000000000000;
  storage[467] = 64'h0000000000000000;
  storage[468] = 64'h0000000000000000;
  storage[469] = 64'h0000000000000000;
  storage[470] = 64'h0000000000000000;
  storage[471] = 64'h0000000000000000;
  storage[472] = 64'h0000000000000000;
  storage[473] = 64'h0000000000000000;
  storage[474] = 64'h0000000000000000;
  storage[475] = 64'h0000000000000000;
  storage[476] = 64'h0000000000000000;
  storage[477] = 64'h0000000000000000;
  storage[478] = 64'h0000000000000000;
  storage[479] = 64'h0000000000000000;
  storage[480] = 64'h0000000000000000;
  storage[481] = 64'h0000000000000000;
  storage[482] = 64'h0000000000000000;
  storage[483] = 64'h0000000000000000;
  storage[484] = 64'h0000000000000000;
  storage[485] = 64'h0000000000000000;
  storage[486] = 64'h0000000000000000;
  storage[487] = 64'h0000000000000000;
  storage[488] = 64'h0000000000000000;
  storage[489] = 64'h0000000000000000;
  storage[490] = 64'h0000000000000000;
  storage[491] = 64'h0000000000000000;
  storage[492] = 64'h0000000000000000;
  storage[493] = 64'h0000000000000000;
  storage[494] = 64'h0000000000000000;
  storage[495] = 64'h0000000000000000;
  storage[496] = 64'h0000000000000000;
  storage[497] = 64'h0000000000000000;
  storage[498] = 64'h0000000000000000;
  storage[499] = 64'h0000000000000000;
  storage[500] = 64'h0000000000000000;
  storage[501] = 64'h0000000000000000;
  storage[502] = 64'h0000000000000000;
  storage[503] = 64'h0000000000000000;
  storage[504] = 64'h0000000000000000;
  storage[505] = 64'h0000000000000000;
  storage[506] = 64'h0000000000000000;
  storage[507] = 64'h0000000000000000;
  storage[508] = 64'h0000000000000000;
  storage[509] = 64'h0000000000000000;
  storage[510] = 64'h0000000000000000;
  storage[511] = 64'h0000000000000000;
  storage[512] = 64'h0000000000000000;
  storage[513] = 64'h0000000000000000;
  storage[514] = 64'h0000000000000000;
  storage[515] = 64'h0000000000000000;
  storage[516] = 64'h0000000000000000;
  storage[517] = 64'h0000000000000000;
  storage[518] = 64'h0000000000000000;
  storage[519] = 64'h0000000000000000;
  storage[520] = 64'h0000000000000000;
  storage[521] = 64'h0000000000000000;
  storage[522] = 64'h0000000000000000;
  storage[523] = 64'h0000000000000000;
  storage[524] = 64'h0000000000000000;
  storage[525] = 64'h0000000000000000;
  storage[526] = 64'h0000000000000000;
  storage[527] = 64'h0000000000000000;
  storage[528] = 64'h0000000000000000;
  storage[529] = 64'h0000000000000000;
  storage[530] = 64'h0000000000000000;
  storage[531] = 64'h0000000000000000;
  storage[532] = 64'h0000000000000000;
  storage[533] = 64'h0000000000000000;
  storage[534] = 64'h0000000000000000;
  storage[535] = 64'h0000000000000000;
  storage[536] = 64'h0000000000000000;
  storage[537] = 64'h0000000000000000;
  storage[538] = 64'h0000000000000000;
  storage[539] = 64'h0000000000000000;
  storage[540] = 64'h0000000000000000;
  storage[541] = 64'h0000000000000000;
  storage[542] = 64'h0000000000000000;
  storage[543] = 64'h0000000000000000;
  storage[544] = 64'h0000000000000000;
  storage[545] = 64'h0000000000000000;
  storage[546] = 64'h0000000000000000;
  storage[547] = 64'h0000000000000000;
  storage[548] = 64'h0000000000000000;
  storage[549] = 64'h0000000000000000;
  storage[550] = 64'h0000000000000000;
  storage[551] = 64'h0000000000000000;
  storage[552] = 64'h0000000000000000;
  storage[553] = 64'h0000000000000000;
  storage[554] = 64'h0000000000000000;
  storage[555] = 64'h0000000000000000;
  storage[556] = 64'h0000000000000000;
  storage[557] = 64'h0000000000000000;
  storage[558] = 64'h0000000000000000;
  storage[559] = 64'h0000000000000000;
  storage[560] = 64'h0000000000000000;
  storage[561] = 64'h0000000000000000;
  storage[562] = 64'h0000000000000000;
  storage[563] = 64'h0000000000000000;
  storage[564] = 64'h0000000000000000;
  storage[565] = 64'h0000000000000000;
  storage[566] = 64'h0000000000000000;
  storage[567] = 64'h0000000000000000;
  storage[568] = 64'h0000000000000000;
  storage[569] = 64'h0000000000000000;
  storage[570] = 64'h0000000000000000;
  storage[571] = 64'h0000000000000000;
  storage[572] = 64'h0000000000000000;
  storage[573] = 64'h0000000000000000;
  storage[574] = 64'h0000000000000000;
  storage[575] = 64'h0000000000000000;
  storage[576] = 64'h0000000000000000;
  storage[577] = 64'h0000000000000000;
  storage[578] = 64'h0000000000000000;
  storage[579] = 64'h0000000000000000;
  storage[580] = 64'h0000000000000000;
  storage[581] = 64'h0000000000000000;
  storage[582] = 64'h0000000000000000;
  storage[583] = 64'h0000000000000000;
  storage[584] = 64'h0000000000000000;
  storage[585] = 64'h0000000000000000;
  storage[586] = 64'h0000000000000000;
  storage[587] = 64'h0000000000000000;
  storage[588] = 64'h0000000000000000;
  storage[589] = 64'h0000000000000000;
  storage[590] = 64'h0000000000000000;
  storage[591] = 64'h0000000000000000;
  storage[592] = 64'h0000000000000000;
  storage[593] = 64'h0000000000000000;
  storage[594] = 64'h0000000000000000;
  storage[595] = 64'h0000000000000000;
  storage[596] = 64'h0000000000000000;
  storage[597] = 64'h0000000000000000;
  storage[598] = 64'h0000000000000000;
  storage[599] = 64'h0000000000000000;
  storage[600] = 64'h0000000000000000;
  storage[601] = 64'h0000000000000000;
  storage[602] = 64'h0000000000000000;
  storage[603] = 64'h0000000000000000;
  storage[604] = 64'h0000000000000000;
  storage[605] = 64'h0000000000000000;
  storage[606] = 64'h0000000000000000;
  storage[607] = 64'h0000000000000000;
  storage[608] = 64'h0000000000000000;
  storage[609] = 64'h0000000000000000;
  storage[610] = 64'h0000000000000000;
  storage[611] = 64'h0000000000000000;
  storage[612] = 64'h0000000000000000;
  storage[613] = 64'h0000000000000000;
  storage[614] = 64'h0000000000000000;
  storage[615] = 64'h0000000000000000;
  storage[616] = 64'h0000000000000000;
  storage[617] = 64'h0000000000000000;
  storage[618] = 64'h0000000000000000;
  storage[619] = 64'h0000000000000000;
  storage[620] = 64'h0000000000000000;
  storage[621] = 64'h0000000000000000;
  storage[622] = 64'h0000000000000000;
  storage[623] = 64'h0000000000000000;
  storage[624] = 64'h0000000000000000;
  storage[625] = 64'h0000000000000000;
  storage[626] = 64'h0000000000000000;
  storage[627] = 64'h0000000000000000;
  storage[628] = 64'h0000000000000000;
  storage[629] = 64'h0000000000000000;
  storage[630] = 64'h0000000000000000;
  storage[631] = 64'h0000000000000000;
  storage[632] = 64'h0000000000000000;
  storage[633] = 64'h0000000000000000;
  storage[634] = 64'h0000000000000000;
  storage[635] = 64'h0000000000000000;
  storage[636] = 64'h0000000000000000;
  storage[637] = 64'h0000000000000000;
  storage[638] = 64'h0000000000000000;
  storage[639] = 64'h0000000000000000;
  storage[640] = 64'h0000000000000000;
  storage[641] = 64'h0000000000000000;
  storage[642] = 64'h0000000000000000;
  storage[643] = 64'h0000000000000000;
  storage[644] = 64'h0000000000000000;
  storage[645] = 64'h0000000000000000;
  storage[646] = 64'h0000000000000000;
  storage[647] = 64'h0000000000000000;
  storage[648] = 64'h0000000000000000;
  storage[649] = 64'h0000000000000000;
  storage[650] = 64'h0000000000000000;
  storage[651] = 64'h0000000000000000;
  storage[652] = 64'h0000000000000000;
  storage[653] = 64'h0000000000000000;
  storage[654] = 64'h0000000000000000;
  storage[655] = 64'h0000000000000000;
  storage[656] = 64'h0000000000000000;
  storage[657] = 64'h0000000000000000;
  storage[658] = 64'h0000000000000000;
  storage[659] = 64'h0000000000000000;
  storage[660] = 64'h0000000000000000;
  storage[661] = 64'h0000000000000000;
  storage[662] = 64'h0000000000000000;
  storage[663] = 64'h0000000000000000;
  storage[664] = 64'h0000000000000000;
  storage[665] = 64'h0000000000000000;
  storage[666] = 64'h0000000000000000;
  storage[667] = 64'h0000000000000000;
  storage[668] = 64'h0000000000000000;
  storage[669] = 64'h0000000000000000;
  storage[670] = 64'h0000000000000000;
  storage[671] = 64'h0000000000000000;
  storage[672] = 64'h0000000000000000;
  storage[673] = 64'h0000000000000000;
  storage[674] = 64'h0000000000000000;
  storage[675] = 64'h0000000000000000;
  storage[676] = 64'h0000000000000000;
  storage[677] = 64'h0000000000000000;
  storage[678] = 64'h0000000000000000;
  storage[679] = 64'h0000000000000000;
  storage[680] = 64'h0000000000000000;
  storage[681] = 64'h0000000000000000;
  storage[682] = 64'h0000000000000000;
  storage[683] = 64'h0000000000000000;
  storage[684] = 64'h0000000000000000;
  storage[685] = 64'h0000000000000000;
  storage[686] = 64'h0000000000000000;
  storage[687] = 64'h0000000000000000;
  storage[688] = 64'h0000000000000000;
  storage[689] = 64'h0000000000000000;
  storage[690] = 64'h0000000000000000;
  storage[691] = 64'h0000000000000000;
  storage[692] = 64'h0000000000000000;
  storage[693] = 64'h0000000000000000;
  storage[694] = 64'h0000000000000000;
  storage[695] = 64'h0000000000000000;
  storage[696] = 64'h0000000000000000;
  storage[697] = 64'h0000000000000000;
  storage[698] = 64'h0000000000000000;
  storage[699] = 64'h0000000000000000;
  storage[700] = 64'h0000000000000000;
  storage[701] = 64'h0000000000000000;
  storage[702] = 64'h0000000000000000;
  storage[703] = 64'h0000000000000000;
  storage[704] = 64'h0000000000000000;
  storage[705] = 64'h0000000000000000;
  storage[706] = 64'h0000000000000000;
  storage[707] = 64'h0000000000000000;
  storage[708] = 64'h0000000000000000;
  storage[709] = 64'h0000000000000000;
  storage[710] = 64'h0000000000000000;
  storage[711] = 64'h0000000000000000;
  storage[712] = 64'h0000000000000000;
  storage[713] = 64'h0000000000000000;
  storage[714] = 64'h0000000000000000;
  storage[715] = 64'h0000000000000000;
  storage[716] = 64'h0000000000000000;
  storage[717] = 64'h0000000000000000;
  storage[718] = 64'h0000000000000000;
  storage[719] = 64'h0000000000000000;
  storage[720] = 64'h0000000000000000;
  storage[721] = 64'h0000000000000000;
  storage[722] = 64'h0000000000000000;
  storage[723] = 64'h0000000000000000;
  storage[724] = 64'h0000000000000000;
  storage[725] = 64'h0000000000000000;
  storage[726] = 64'h0000000000000000;
  storage[727] = 64'h0000000000000000;
  storage[728] = 64'h0000000000000000;
  storage[729] = 64'h0000000000000000;
  storage[730] = 64'h0000000000000000;
  storage[731] = 64'h0000000000000000;
  storage[732] = 64'h0000000000000000;
  storage[733] = 64'h0000000000000000;
  storage[734] = 64'h0000000000000000;
  storage[735] = 64'h0000000000000000;
  storage[736] = 64'h0000000000000000;
  storage[737] = 64'h0000000000000000;
  storage[738] = 64'h0000000000000000;
  storage[739] = 64'h0000000000000000;
  storage[740] = 64'h0000000000000000;
  storage[741] = 64'h0000000000000000;
  storage[742] = 64'h0000000000000000;
  storage[743] = 64'h0000000000000000;
  storage[744] = 64'h0000000000000000;
  storage[745] = 64'h0000000000000000;
  storage[746] = 64'h0000000000000000;
  storage[747] = 64'h0000000000000000;
  storage[748] = 64'h0000000000000000;
  storage[749] = 64'h0000000000000000;
  storage[750] = 64'h0000000000000000;
  storage[751] = 64'h0000000000000000;
  storage[752] = 64'h0000000000000000;
  storage[753] = 64'h0000000000000000;
  storage[754] = 64'h0000000000000000;
  storage[755] = 64'h0000000000000000;
  storage[756] = 64'h0000000000000000;
  storage[757] = 64'h0000000000000000;
  storage[758] = 64'h0000000000000000;
  storage[759] = 64'h0000000000000000;
  storage[760] = 64'h0000000000000000;
  storage[761] = 64'h0000000000000000;
  storage[762] = 64'h0000000000000000;
  storage[763] = 64'h0000000000000000;
  storage[764] = 64'h0000000000000000;
  storage[765] = 64'h0000000000000000;
  storage[766] = 64'h0000000000000000;
  storage[767] = 64'h0000000000000000;
  storage[768] = 64'h0000000000000000;
  storage[769] = 64'h0000000000000000;
  storage[770] = 64'h0000000000000000;
  storage[771] = 64'h0000000000000000;
  storage[772] = 64'h0000000000000000;
  storage[773] = 64'h0000000000000000;
  storage[774] = 64'h0000000000000000;
  storage[775] = 64'h0000000000000000;
  storage[776] = 64'h0000000000000000;
  storage[777] = 64'h0000000000000000;
  storage[778] = 64'h0000000000000000;
  storage[779] = 64'h0000000000000000;
  storage[780] = 64'h0000000000000000;
  storage[781] = 64'h0000000000000000;
  storage[782] = 64'h0000000000000000;
  storage[783] = 64'h0000000000000000;
  storage[784] = 64'h0000000000000000;
  storage[785] = 64'h0000000000000000;
  storage[786] = 64'h0000000000000000;
  storage[787] = 64'h0000000000000000;
  storage[788] = 64'h0000000000000000;
  storage[789] = 64'h0000000000000000;
  storage[790] = 64'h0000000000000000;
  storage[791] = 64'h0000000000000000;
  storage[792] = 64'h0000000000000000;
  storage[793] = 64'h0000000000000000;
  storage[794] = 64'h0000000000000000;
  storage[795] = 64'h0000000000000000;
  storage[796] = 64'h0000000000000000;
  storage[797] = 64'h0000000000000000;
  storage[798] = 64'h0000000000000000;
  storage[799] = 64'h0000000000000000;
  storage[800] = 64'h0000000000000000;
  storage[801] = 64'h0000000000000000;
  storage[802] = 64'h0000000000000000;
  storage[803] = 64'h0000000000000000;
  storage[804] = 64'h0000000000000000;
  storage[805] = 64'h0000000000000000;
  storage[806] = 64'h0000000000000000;
  storage[807] = 64'h0000000000000000;
  storage[808] = 64'h0000000000000000;
  storage[809] = 64'h0000000000000000;
  storage[810] = 64'h0000000000000000;
  storage[811] = 64'h0000000000000000;
  storage[812] = 64'h0000000000000000;
  storage[813] = 64'h0000000000000000;
  storage[814] = 64'h0000000000000000;
  storage[815] = 64'h0000000000000000;
  storage[816] = 64'h0000000000000000;
  storage[817] = 64'h0000000000000000;
  storage[818] = 64'h0000000000000000;
  storage[819] = 64'h0000000000000000;
  storage[820] = 64'h0000000000000000;
  storage[821] = 64'h0000000000000000;
  storage[822] = 64'h0000000000000000;
  storage[823] = 64'h0000000000000000;
  storage[824] = 64'h0000000000000000;
  storage[825] = 64'h0000000000000000;
  storage[826] = 64'h0000000000000000;
  storage[827] = 64'h0000000000000000;
  storage[828] = 64'h0000000000000000;
  storage[829] = 64'h0000000000000000;
  storage[830] = 64'h0000000000000000;
  storage[831] = 64'h0000000000000000;
  storage[832] = 64'h0000000000000000;
  storage[833] = 64'h0000000000000000;
  storage[834] = 64'h0000000000000000;
  storage[835] = 64'h0000000000000000;
  storage[836] = 64'h0000000000000000;
  storage[837] = 64'h0000000000000000;
  storage[838] = 64'h0000000000000000;
  storage[839] = 64'h0000000000000000;
  storage[840] = 64'h0000000000000000;
  storage[841] = 64'h0000000000000000;
  storage[842] = 64'h0000000000000000;
  storage[843] = 64'h0000000000000000;
  storage[844] = 64'h0000000000000000;
  storage[845] = 64'h0000000000000000;
  storage[846] = 64'h0000000000000000;
  storage[847] = 64'h0000000000000000;
  storage[848] = 64'h0000000000000000;
  storage[849] = 64'h0000000000000000;
  storage[850] = 64'h0000000000000000;
  storage[851] = 64'h0000000000000000;
  storage[852] = 64'h0000000000000000;
  storage[853] = 64'h0000000000000000;
  storage[854] = 64'h0000000000000000;
  storage[855] = 64'h0000000000000000;
  storage[856] = 64'h0000000000000000;
  storage[857] = 64'h0000000000000000;
  storage[858] = 64'h0000000000000000;
  storage[859] = 64'h0000000000000000;
  storage[860] = 64'h0000000000000000;
  storage[861] = 64'h0000000000000000;
  storage[862] = 64'h0000000000000000;
  storage[863] = 64'h0000000000000000;
  storage[864] = 64'h0000000000000000;
  storage[865] = 64'h0000000000000000;
  storage[866] = 64'h0000000000000000;
  storage[867] = 64'h0000000000000000;
  storage[868] = 64'h0000000000000000;
  storage[869] = 64'h0000000000000000;
  storage[870] = 64'h0000000000000000;
  storage[871] = 64'h0000000000000000;
  storage[872] = 64'h0000000000000000;
  storage[873] = 64'h0000000000000000;
  storage[874] = 64'h0000000000000000;
  storage[875] = 64'h0000000000000000;
  storage[876] = 64'h0000000000000000;
  storage[877] = 64'h0000000000000000;
  storage[878] = 64'h0000000000000000;
  storage[879] = 64'h0000000000000000;
  storage[880] = 64'h0000000000000000;
  storage[881] = 64'h0000000000000000;
  storage[882] = 64'h0000000000000000;
  storage[883] = 64'h0000000000000000;
  storage[884] = 64'h0000000000000000;
  storage[885] = 64'h0000000000000000;
  storage[886] = 64'h0000000000000000;
  storage[887] = 64'h0000000000000000;
  storage[888] = 64'h0000000000000000;
  storage[889] = 64'h0000000000000000;
  storage[890] = 64'h0000000000000000;
  storage[891] = 64'h0000000000000000;
  storage[892] = 64'h0000000000000000;
  storage[893] = 64'h0000000000000000;
  storage[894] = 64'h0000000000000000;
  storage[895] = 64'h0000000000000000;
  storage[896] = 64'h0000000000000000;
  storage[897] = 64'h0000000000000000;
  storage[898] = 64'h0000000000000000;
  storage[899] = 64'h0000000000000000;
  storage[900] = 64'h0000000000000000;
  storage[901] = 64'h0000000000000000;
  storage[902] = 64'h0000000000000000;
  storage[903] = 64'h0000000000000000;
  storage[904] = 64'h0000000000000000;
  storage[905] = 64'h0000000000000000;
  storage[906] = 64'h0000000000000000;
  storage[907] = 64'h0000000000000000;
  storage[908] = 64'h0000000000000000;
  storage[909] = 64'h0000000000000000;
  storage[910] = 64'h0000000000000000;
  storage[911] = 64'h0000000000000000;
  storage[912] = 64'h0000000000000000;
  storage[913] = 64'h0000000000000000;
  storage[914] = 64'h0000000000000000;
  storage[915] = 64'h0000000000000000;
  storage[916] = 64'h0000000000000000;
  storage[917] = 64'h0000000000000000;
  storage[918] = 64'h0000000000000000;
  storage[919] = 64'h0000000000000000;
  storage[920] = 64'h0000000000000000;
  storage[921] = 64'h0000000000000000;
  storage[922] = 64'h0000000000000000;
  storage[923] = 64'h0000000000000000;
  storage[924] = 64'h0000000000000000;
  storage[925] = 64'h0000000000000000;
  storage[926] = 64'h0000000000000000;
  storage[927] = 64'h0000000000000000;
  storage[928] = 64'h0000000000000000;
  storage[929] = 64'h0000000000000000;
  storage[930] = 64'h0000000000000000;
  storage[931] = 64'h0000000000000000;
  storage[932] = 64'h0000000000000000;
  storage[933] = 64'h0000000000000000;
  storage[934] = 64'h0000000000000000;
  storage[935] = 64'h0000000000000000;
  storage[936] = 64'h0000000000000000;
  storage[937] = 64'h0000000000000000;
  storage[938] = 64'h0000000000000000;
  storage[939] = 64'h0000000000000000;
  storage[940] = 64'h0000000000000000;
  storage[941] = 64'h0000000000000000;
  storage[942] = 64'h0000000000000000;
  storage[943] = 64'h0000000000000000;
  storage[944] = 64'h0000000000000000;
  storage[945] = 64'h0000000000000000;
  storage[946] = 64'h0000000000000000;
  storage[947] = 64'h0000000000000000;
  storage[948] = 64'h0000000000000000;
  storage[949] = 64'h0000000000000000;
  storage[950] = 64'h0000000000000000;
  storage[951] = 64'h0000000000000000;
  storage[952] = 64'h0000000000000000;
  storage[953] = 64'h0000000000000000;
  storage[954] = 64'h0000000000000000;
  storage[955] = 64'h0000000000000000;
  storage[956] = 64'h0000000000000000;
  storage[957] = 64'h0000000000000000;
  storage[958] = 64'h0000000000000000;
  storage[959] = 64'h0000000000000000;
  storage[960] = 64'h0000000000000000;
  storage[961] = 64'h0000000000000000;
  storage[962] = 64'h0000000000000000;
  storage[963] = 64'h0000000000000000;
  storage[964] = 64'h0000000000000000;
  storage[965] = 64'h0000000000000000;
  storage[966] = 64'h0000000000000000;
  storage[967] = 64'h0000000000000000;
  storage[968] = 64'h0000000000000000;
  storage[969] = 64'h0000000000000000;
  storage[970] = 64'h0000000000000000;
  storage[971] = 64'h0000000000000000;
  storage[972] = 64'h0000000000000000;
  storage[973] = 64'h0000000000000000;
  storage[974] = 64'h0000000000000000;
  storage[975] = 64'h0000000000000000;
  storage[976] = 64'h0000000000000000;
  storage[977] = 64'h0000000000000000;
  storage[978] = 64'h0000000000000000;
  storage[979] = 64'h0000000000000000;
  storage[980] = 64'h0000000000000000;
  storage[981] = 64'h0000000000000000;
  storage[982] = 64'h0000000000000000;
  storage[983] = 64'h0000000000000000;
  storage[984] = 64'h0000000000000000;
  storage[985] = 64'h0000000000000000;
  storage[986] = 64'h0000000000000000;
  storage[987] = 64'h0000000000000000;
  storage[988] = 64'h0000000000000000;
  storage[989] = 64'h0000000000000000;
  storage[990] = 64'h0000000000000000;
  storage[991] = 64'h0000000000000000;
  storage[992] = 64'h0000000000000000;
  storage[993] = 64'h0000000000000000;
  storage[994] = 64'h0000000000000000;
  storage[995] = 64'h0000000000000000;
  storage[996] = 64'h0000000000000000;
  storage[997] = 64'h0000000000000000;
  storage[998] = 64'h0000000000000000;
  storage[999] = 64'h0000000000000000;
  storage[1000] = 64'h0000000000000000;
  storage[1001] = 64'h0000000000000000;
  storage[1002] = 64'h0000000000000000;
  storage[1003] = 64'h0000000000000000;
  storage[1004] = 64'h0000000000000000;
  storage[1005] = 64'h0000000000000000;
  storage[1006] = 64'h0000000000000000;
  storage[1007] = 64'h0000000000000000;
  storage[1008] = 64'h0000000000000000;
  storage[1009] = 64'h0000000000000000;
  storage[1010] = 64'h0000000000000000;
  storage[1011] = 64'h0000000000000000;
  storage[1012] = 64'h0000000000000000;
  storage[1013] = 64'h0000000000000000;
  storage[1014] = 64'h0000000000000000;
  storage[1015] = 64'h0000000000000000;
  storage[1016] = 64'h0000000000000000;
  storage[1017] = 64'h0000000000000000;
  storage[1018] = 64'h0000000000000000;
  storage[1019] = 64'h0000000000000000;
  storage[1020] = 64'h0000000000000000;
  storage[1021] = 64'h0000000000000000;
  storage[1022] = 64'h0000000000000000;
  storage[1023] = 64'h0000000000000000;
  storage[1024] = 64'h0000000000000000;
  storage[1025] = 64'h0000000000000000;
  storage[1026] = 64'h0000000000000000;
  storage[1027] = 64'h0000000000000000;
  storage[1028] = 64'h0000000000000000;
  storage[1029] = 64'h0000000000000000;
  storage[1030] = 64'h0000000000000000;
  storage[1031] = 64'h0000000000000000;
  storage[1032] = 64'h0000000000000000;
  storage[1033] = 64'h0000000000000000;
end
always @(posedge clk)
  begin
    if (storage_w_en)
      storage[storage_w_addr] <= storage_w_data;
  end
reg [63:0] _0_;
always @(posedge clk)
  begin
    if (storage_r_en)
      begin
        _0_ <= storage[storage_r_addr];
      end
  end
assign storage_r_data = _0_;
assign \$11  = produce + 1'h1;
assign \$14  = produce == 11'h409;
assign \$13  = \$14  ? 12'h000 : \$11 ;
assign \$17  = r_rdy & r_en;
assign \$20  = consume + 1'h1;
assign \$23  = consume == 11'h409;
assign \$22  = \$23  ? 12'h000 : \$20 ;
assign \$26  = w_rdy & w_en;
assign \$2  = level != 11'h40a;
assign \$29  = r_rdy & r_en;
assign \$28  = ~ \$29 ;
assign \$32  = \$26  & \$28 ;
assign \$35  = level + 1'h1;
assign \$37  = r_rdy & r_en;
assign \$40  = w_rdy & w_en;
assign \$39  = ~ \$40 ;
assign \$43  = \$37  & \$39 ;
assign \$46  = level - 1'h1;
always @(posedge clk)
  produce <= \produce$next ;
always @(posedge clk)
  consume <= \consume$next ;
assign \$4  = | level;
always @(posedge clk)
  level <= \level$next ;
assign \$6  = w_en & w_rdy;
assign \$8  = w_rdy & w_en;
always @*
  begin
    if (\$auto$verilog_backend.cc:2083:dump_module$8 )
      begin
      end
    \consume$next  = consume;
    casez (\$17 )
      1'h1:
        \consume$next  = \$22 [10:0];
    endcase
    casez (rst)
      1'h1:
        \consume$next  = 11'h000;
    endcase
  end
always @*
  begin
    if (\$auto$verilog_backend.cc:2083:dump_module$8 )
      begin
      end
    \level$next  = level;
    casez (\$32 )
      1'h1:
        \level$next  = \$35 [10:0];
    endcase
    casez (\$43 )
      1'h1:
        \level$next  = \$46 [10:0];
    endcase
    casez (rst)
      1'h1:
        \level$next  = 11'h000;
    endcase
  end
always @*
  begin
    if (\$auto$verilog_backend.cc:2083:dump_module$8 )
      begin
      end
    \produce$next  = produce;
    casez (\$8 )
      1'h1:
        \produce$next  = \$13 [10:0];
    endcase
    casez (rst)
      1'h1:
        \produce$next  = 11'h000;
    endcase
  end
assign \$10  = \$13 ;
assign \$19  = \$22 ;
assign \$34  = \$35 ;
assign \$45  = \$46 ;
assign storage_r_en = r_en;
assign r_data = storage_r_data;
assign storage_r_addr = consume;
assign storage_w_en = \$6 ;
assign storage_w_data = w_data;
assign storage_w_addr = produce;
assign r_level = level;
assign w_level = level;
assign r_rdy = \$4 ;
assign w_rdy = \$2 ;
endmodule

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

module \unpack$2 (im, re, \input );
  output [11:0] im;
  wire [11:0] im;
  input [23:0] \input ;
  wire [23:0] \input ;
  output [11:0] re;
  wire [11:0] re;
  assign re = \input [23:12];
  assign im = \input [11:0];
endmodule

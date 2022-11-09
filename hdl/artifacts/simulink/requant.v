// Created by Verilog::EditFiles from requant.v

module requant(sync_in, gain, arm, ce, requant_out, sync_out, overflow, addr, clk, rst, requant_in);
  reg \$auto$verilog_backend.cc:2083:dump_module$2  = 0;
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
  reg [35:0] cm_cm_in;
  reg [10:0] cm_gain;
  wire [17:0] cm_im;
  wire cm_im_overflow;
  wire [17:0] cm_re;
  wire cm_re_overflow;
  input [10:0] gain;
  wire [10:0] gain;
  reg [17:0] inter_im;
  reg [17:0] inter_re;
  output overflow;
  reg overflow = 1'h0;
  reg \overflow$next ;
  input [35:0] requant_in;
  wire [35:0] requant_in;
  output [15:0] requant_out;
  reg [15:0] requant_out = 16'h0000;
  reg [15:0] \requant_out$next ;
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
    requant_out <= \requant_out$next ;
  assign \$3  = state == 2'h2;
  always @(posedge clk)
    overflow <= \overflow$next ;
  assign \$5  = state == 2'h1;
  assign \$7  = state == 2'h1;
  cm cm (
    .cm_in(cm_cm_in),
    .gain(cm_gain),
    .im(cm_im),
    .im_overflow(cm_im_overflow),
    .re(cm_re),
    .re_overflow(cm_re_overflow)
  );
  always @* begin
    if (\$auto$verilog_backend.cc:2083:dump_module$2 ) begin end
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
  always @* begin
    if (\$auto$verilog_backend.cc:2083:dump_module$2 ) begin end
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
  always @* begin
    if (\$auto$verilog_backend.cc:2083:dump_module$2 ) begin end
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
  always @* begin
    if (\$auto$verilog_backend.cc:2083:dump_module$2 ) begin end
    addr = 11'h000;
    casez (ce)
      1'h1:
          casez (\$20 )
            1'h1:
                addr = chan_count;
          endcase
    endcase
  end
  always @* begin
    if (\$auto$verilog_backend.cc:2083:dump_module$2 ) begin end
    cm_cm_in = 36'h000000000;
    casez (ce)
      1'h1:
          casez (\$22 )
            1'h1:
                cm_cm_in = requant_in;
          endcase
    endcase
  end
  always @* begin
    if (\$auto$verilog_backend.cc:2083:dump_module$2 ) begin end
    cm_gain = 11'h000;
    casez (ce)
      1'h1:
          casez (\$24 )
            1'h1:
                cm_gain = gain;
          endcase
    endcase
  end
  always @* begin
    if (\$auto$verilog_backend.cc:2083:dump_module$2 ) begin end
    inter_re = 18'h00000;
    casez (ce)
      1'h1:
          casez (\$26 )
            1'h1:
                inter_re = cm_re;
          endcase
    endcase
  end
  always @* begin
    if (\$auto$verilog_backend.cc:2083:dump_module$2 ) begin end
    inter_im = 18'h00000;
    casez (ce)
      1'h1:
          casez (\$28 )
            1'h1:
                inter_im = cm_im;
          endcase
    endcase
  end
  always @* begin
    if (\$auto$verilog_backend.cc:2083:dump_module$2 ) begin end
    \requant_out$next  = requant_out;
    casez (ce)
      1'h1:
          casez (\$30 )
            1'h1:
                \requant_out$next  = { inter_re[17:10], inter_im[17:10] };
          endcase
    endcase
    casez (rst)
      1'h1:
          \requant_out$next  = 16'h0000;
    endcase
  end
  always @* begin
    if (\$auto$verilog_backend.cc:2083:dump_module$2 ) begin end
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


module requant #(
    parameter integer INPUT_WIDTH = 18,
    parameter integer OUTPUT_WIDTH = 8,
    parameter integer GAIN_WIDTH = INPUT_WIDTH - OUTPUT_WIDTH + 1,
    parameter integer CHANNELS = 2048
) (
    // Standard preamble
    input logic clk,    // Clock
    input logic ce,     // Clock enable
    input logic rst,    // Sync reset
    // Input side
    input logic [2*INPUT_WIDTH-1:0] data_in,
    input logic sync_in,
    input logic [INPUT_WIDTH - OUTPUT_WIDTH:0] gain,
    // Output side
    output logic [2*OUTPUT_WIDTH-1:0] data_out,
    output logic sync_out,
    output logic [$clog2(CHANNELS)-1:0] addr,
    output logic ovfl
);

  // Internal signals to help delay routing
  logic signed [INPUT_WIDTH-1:0] in_re = 0;
  logic signed [INPUT_WIDTH-1:0] in_im = 0;
  logic signed [OUTPUT_WIDTH-1:0] out_re = 0;
  logic signed [OUTPUT_WIDTH-1:0] out_im = 0;

  // Overflow states
  logic re_ovfl = 0;
  logic im_ovfl = 0;

  // Buffer for gain (as unpack is a delay of 1, 1 extra bit for sign extension)
  logic signed [GAIN_WIDTH:0] gain_buf;

  // Constant signals for clamping
  localparam signed [MULT_WIDTH-1:0] ClampHigh = (2 ** (INPUT_WIDTH - 1)) - 1;
  localparam signed [MULT_WIDTH-1:0] ClampLow = -(2 ** (INPUT_WIDTH - 1));

  // Multiplication result (which we will select the LSB of for mult truncation, then MSB for requant)
  parameter integer MULT_WIDTH = GAIN_WIDTH + INPUT_WIDTH;
  logic signed [  MULT_WIDTH-1:0] mult_re;
  logic signed [  MULT_WIDTH-1:0] mult_im;
  logic signed [OUTPUT_WIDTH-1:0] mult_re_trunc;
  logic signed [OUTPUT_WIDTH-1:0] mult_im_trunc;

  // Truncate multiplication result (careful with sign bit)
  always_comb begin
    mult_re_trunc = mult_re[INPUT_WIDTH-1-:OUTPUT_WIDTH];
    mult_im_trunc = mult_im[INPUT_WIDTH-1-:OUTPUT_WIDTH];
  end

  // Addr counter (assuming a power of 2)
  // We will always miss the gain of the first time we hit the sync
  always_ff @(posedge clk) begin
    if (rst) addr <= 0;
    else if (ce && sync_in) addr <= 1;
    else if (ce) addr <= addr + 1;
    else addr <= addr;
  end

  // Sync shifter (determine delay experimentally)
  parameter integer DELAY = 4;
  logic [DELAY-1:0] sync_fifo;
  always_ff @(posedge clk) sync_fifo[DELAY-1] <= sync_in;
  for (genvar i = 0; i < DELAY - 1; i++) always @(posedge clk) sync_fifo[i] <= sync_fifo[i+1];
  always_comb begin
    sync_out = sync_fifo[0];
  end

  // Unpack input
  always_ff @(posedge clk) begin
    if (rst) begin
      in_re <= 0;
      in_im <= 0;
    end else if (ce) begin
      in_re <= data_in[INPUT_WIDTH+:INPUT_WIDTH];
      in_im <= data_in[0+:INPUT_WIDTH];
    end else begin
      in_re <= in_re;
      in_im <= in_im;
    end
  end

  // Buffer gain into the signed, correctly sized container
  always_ff @(posedge clk) begin
    if (rst) gain_buf <= 0;
    else if (ce) gain_buf <= $signed({1'b0, gain});
    else gain_buf <= gain_buf;
  end

  // Perform multiplication
  always_ff @(posedge clk) begin
    if (rst) begin
      mult_re <= 0;
      mult_im <= 0;
    end else if (ce) begin
      mult_re <= gain_buf * in_re;
      mult_im <= gain_buf * in_im;
    end else begin
      mult_re <= mult_re;
      mult_im <= mult_im;
    end
  end

  // Truncate and clamp
  always_ff @(posedge clk) begin
    if (rst) begin
      out_re <= 0;
      out_im <= 0;
    end else if (ce) begin
      // Clamp and assign, fixing truncation effects on signed
      if (mult_re > ClampHigh) out_re <= ClampHigh[(INPUT_WIDTH-1)-:OUTPUT_WIDTH];
      else if (mult_re < ClampLow) out_re <= ClampLow[(INPUT_WIDTH-1)-:OUTPUT_WIDTH];
      else if (mult_re < 0) out_re <= mult_re_trunc + 1;
      else out_re <= mult_re_trunc;

      if (mult_im > ClampHigh) out_im <= ClampHigh[(INPUT_WIDTH-1)-:OUTPUT_WIDTH];
      else if (mult_im < ClampLow) out_im <= ClampLow[(INPUT_WIDTH-1)-:OUTPUT_WIDTH];
      else if (mult_im < 0) out_im <= mult_im_trunc + 1;
      else out_im <= mult_im_trunc;
    end else begin
      out_re <= out_re;
      out_im <= out_im;
    end
  end

  // Pack output
  always_ff @(posedge clk) begin
    if (rst) begin
      data_out <= 0;
    end else if (ce) begin
      data_out <= {out_re, out_im};
    end else begin
      data_out <= data_out;
    end
  end

  // Overflow signaling
  always_ff @(posedge clk) begin
    if (rst) begin
      re_ovfl <= 0;
      im_ovfl <= 0;
      ovfl <= 0;
    end else if (ce) begin
      if ((mult_re > ClampHigh) || (mult_re < ClampLow)) re_ovfl <= 1;
      else re_ovfl <= 0;

      if ((mult_im > ClampHigh) || (mult_im < ClampLow)) im_ovfl <= 1;
      else im_ovfl <= 0;

      ovfl <= im_ovfl | re_ovfl;
    end else begin
      re_ovfl <= re_ovfl;
      im_ovfl <= im_ovfl;
      ovfl <= ovfl;
    end
  end

endmodule

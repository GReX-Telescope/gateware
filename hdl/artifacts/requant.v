module requant (
	clk,
	ce,
	rst,
	data_in,
	sync_in,
	gain,
	data_out,
	sync_out,
	addr,
	ovfl
);
	parameter integer INPUT_WIDTH = 18;
	parameter integer OUTPUT_WIDTH = 8;
	parameter integer GAIN_WIDTH = (INPUT_WIDTH - OUTPUT_WIDTH) + 1;
	parameter integer CHANNELS = 2048;
	input wire clk;
	input wire ce;
	input wire rst;
	input wire [(2 * INPUT_WIDTH) - 1:0] data_in;
	input wire sync_in;
	input wire [INPUT_WIDTH - OUTPUT_WIDTH:0] gain;
	output reg [(2 * OUTPUT_WIDTH) - 1:0] data_out;
	output reg sync_out;
	output reg [$clog2(CHANNELS) - 1:0] addr;
	output reg ovfl;
	reg signed [INPUT_WIDTH - 1:0] in_re = 0;
	reg signed [INPUT_WIDTH - 1:0] in_im = 0;
	reg signed [OUTPUT_WIDTH - 1:0] out_re = 0;
	reg signed [OUTPUT_WIDTH - 1:0] out_im = 0;
	reg re_ovfl = 0;
	reg im_ovfl = 0;
	reg signed [GAIN_WIDTH:0] gain_buf;
	parameter integer MULT_WIDTH = GAIN_WIDTH + INPUT_WIDTH;
	localparam signed [MULT_WIDTH - 1:0] ClampHigh = (2 ** (INPUT_WIDTH - 1)) - 1;
	localparam signed [MULT_WIDTH - 1:0] ClampLow = -(2 ** (INPUT_WIDTH - 1));
	reg signed [MULT_WIDTH - 1:0] mult_re;
	reg signed [MULT_WIDTH - 1:0] mult_im;
	reg signed [OUTPUT_WIDTH - 1:0] mult_re_trunc;
	reg signed [OUTPUT_WIDTH - 1:0] mult_im_trunc;
	always @(*) begin
		mult_re_trunc = mult_re[INPUT_WIDTH - 1-:OUTPUT_WIDTH];
		mult_im_trunc = mult_im[INPUT_WIDTH - 1-:OUTPUT_WIDTH];
	end
	always @(posedge clk)
		if (rst)
			addr <= 0;
		else if (ce && sync_in)
			addr <= 1;
		else if (ce)
			addr <= addr + 1;
		else
			addr <= addr;
	parameter integer DELAY = 4;
	reg [DELAY - 1:0] sync_fifo;
	always @(posedge clk) sync_fifo[DELAY - 1] <= sync_in;
	genvar i;
	generate
		for (i = 0; i < (DELAY - 1); i = i + 1) begin : genblk1
			always @(posedge clk) sync_fifo[i] <= sync_fifo[i + 1];
		end
	endgenerate
	always @(*) sync_out = sync_fifo[0];
	always @(posedge clk)
		if (rst) begin
			in_re <= 0;
			in_im <= 0;
		end
		else if (ce) begin
			in_re <= data_in[INPUT_WIDTH+:INPUT_WIDTH];
			in_im <= data_in[0+:INPUT_WIDTH];
		end
		else begin
			in_re <= in_re;
			in_im <= in_im;
		end
	always @(posedge clk)
		if (rst)
			gain_buf <= 0;
		else if (ce)
			gain_buf <= $signed({1'b0, gain});
		else
			gain_buf <= gain_buf;
	always @(posedge clk)
		if (rst) begin
			mult_re <= 0;
			mult_im <= 0;
		end
		else if (ce) begin
			mult_re <= gain_buf * in_re;
			mult_im <= gain_buf * in_im;
		end
		else begin
			mult_re <= mult_re;
			mult_im <= mult_im;
		end
	always @(posedge clk)
		if (rst) begin
			out_re <= 0;
			out_im <= 0;
		end
		else if (ce) begin
			if (mult_re > ClampHigh)
				out_re <= ClampHigh[INPUT_WIDTH - 1-:OUTPUT_WIDTH];
			else if (mult_re < ClampLow)
				out_re <= ClampLow[INPUT_WIDTH - 1-:OUTPUT_WIDTH];
			else if (mult_re < 0)
				out_re <= mult_re_trunc + 1;
			else
				out_re <= mult_re_trunc;
			if (mult_im > ClampHigh)
				out_im <= ClampHigh[INPUT_WIDTH - 1-:OUTPUT_WIDTH];
			else if (mult_im < ClampLow)
				out_im <= ClampLow[INPUT_WIDTH - 1-:OUTPUT_WIDTH];
			else if (mult_im < 0)
				out_im <= mult_im_trunc + 1;
			else
				out_im <= mult_im_trunc;
		end
		else begin
			out_re <= out_re;
			out_im <= out_im;
		end
	always @(posedge clk)
		if (rst)
			data_out <= 0;
		else if (ce)
			data_out <= {out_re, out_im};
		else
			data_out <= data_out;
	always @(posedge clk)
		if (rst) begin
			re_ovfl <= 0;
			im_ovfl <= 0;
			ovfl <= 0;
		end
		else if (ce) begin
			if ((mult_re > ClampHigh) || (mult_re < ClampLow))
				re_ovfl <= 1;
			else
				re_ovfl <= 0;
			if ((mult_im > ClampHigh) || (mult_im < ClampLow))
				im_ovfl <= 1;
			else
				im_ovfl <= 0;
			ovfl <= im_ovfl | re_ovfl;
		end
		else begin
			re_ovfl <= re_ovfl;
			im_ovfl <= im_ovfl;
			ovfl <= ovfl;
		end
endmodule
module packetizer (
	clk,
	ce,
	rst,
	pol_a,
	pol_b,
	sync,
	tx_data,
	tx_valid,
	tx_eod
);
	input wire clk;
	input wire ce;
	input wire rst;
	input wire [15:0] pol_a;
	input wire [15:0] pol_b;
	input wire sync;
	output reg [63:0] tx_data;
	output reg tx_valid;
	output reg tx_eod;
	reg state = 1'd0;
	reg next_state;
	reg first_done = 0;
	reg [63:0] payload_id = 0;
	reg [63:0] packed_a = 0;
	reg [63:0] packed_b = 0;
	reg [1:0] subword = 0;
	reg fifo_we;
	reg [8:0] fifo_w_count = 0;
	reg [10:0] fifo_r_count = 0;
	reg fifo_a_re;
	reg fifo_b_re;
	wire [63:0] fifo_a_dout;
	wire [63:0] fifo_b_dout;
	reg [2:0] fifo_state = 3'd0;
	reg [2:0] next_fifo_state;
	fifo #(.DEPTH(1024)) fifo_a(
		.clk(clk),
		.rst(rst),
		.we(fifo_we),
		.din(packed_a),
		.re(fifo_a_re),
		.dout(fifo_a_dout),
		.empty(),
		.full()
	);
	fifo #(.DEPTH(1024)) fifo_b(
		.clk(clk),
		.rst(rst),
		.we(fifo_we),
		.din(packed_b),
		.re(fifo_b_re),
		.dout(fifo_b_dout),
		.empty(),
		.full()
	);
	always @(posedge clk)
		if (rst)
			state <= 1'd0;
		else if (ce)
			state <= next_state;
		else
			state <= state;
	always @(*)
		if ((state == 1'd0) && sync)
			next_state = 1'd1;
		else
			next_state = state;
	always @(posedge clk)
		if (rst)
			subword <= 0;
		else if ((ce && (state == 1'd0)) && sync)
			subword <= 'd3;
		else if (ce && (state == 1'd1))
			subword <= subword - 1;
		else
			subword <= subword;
	always @(posedge clk)
		if (rst)
			first_done <= 0;
		else if ((ce && (state == 1'd1)) && (subword == 0))
			first_done <= 1;
		else
			first_done <= first_done;
	always @(posedge clk)
		if (rst)
			packed_a <= 0;
		else if (ce && (state == 1'd1))
			packed_a[16 * subword+:16] <= pol_a;
		else
			packed_a <= packed_a;
	always @(posedge clk)
		if (rst)
			packed_b <= 0;
		else if (ce && (state == 1'd1))
			packed_b[16 * subword+:16] <= pol_b;
		else
			packed_b <= packed_b;
	always @(*)
		if ((subword == 3) && first_done)
			fifo_we = 1;
		else
			fifo_we = 0;
	always @(posedge clk)
		if (rst)
			fifo_w_count <= 0;
		else if ((ce && (state == 1'd1)) && (subword == 0))
			fifo_w_count <= fifo_w_count + 1;
		else
			fifo_w_count <= fifo_w_count;
	always @(posedge clk)
		if (rst)
			fifo_state <= 3'd0;
		else if (ce && (state == 1'd1))
			fifo_state <= next_fifo_state;
		else
			fifo_state <= fifo_state;
	always @(*)
		if ((fifo_w_count == 0) && first_done)
			next_fifo_state = 3'd1;
		else if ((fifo_state == 3'd1) && (fifo_r_count == 511))
			next_fifo_state = 3'd2;
		else if (fifo_state == 3'd2)
			next_fifo_state = 3'd3;
		else if ((fifo_state == 3'd3) && (fifo_r_count == 1023))
			next_fifo_state = 3'd4;
		else if (fifo_state == 3'd4)
			next_fifo_state = 3'd0;
		else
			next_fifo_state = fifo_state;
	always @(posedge clk)
		if (rst)
			fifo_r_count <= 0;
		else if (fifo_state != 3'd0)
			fifo_r_count <= fifo_r_count + 1;
		else
			fifo_r_count <= 0;
	always @(posedge clk)
		if (rst)
			fifo_a_re <= 0;
		else if (next_fifo_state == 3'd1)
			fifo_a_re <= 1;
		else
			fifo_a_re <= 0;
	always @(posedge clk)
		if (rst)
			fifo_b_re <= 0;
		else if ((next_fifo_state == 3'd2) || (next_fifo_state == 3'd3))
			fifo_b_re <= 1;
		else
			fifo_b_re <= 0;
	always @(posedge clk)
		if (rst)
			tx_data <= 0;
		else if ((fifo_state == 3'd1) && (fifo_r_count == 0))
			tx_data <= payload_id;
		else if ((fifo_state == 3'd1) || (fifo_state == 3'd2))
			tx_data <= fifo_a_dout;
		else if ((fifo_state == 3'd3) || (fifo_state == 3'd4))
			tx_data <= fifo_b_dout;
		else
			tx_data <= 0;
	always @(posedge clk)
		if (rst)
			tx_valid <= 0;
		else if (fifo_state != 3'd0)
			tx_valid <= 1;
		else
			tx_valid <= 0;
	always @(posedge clk)
		if (rst)
			tx_eod <= 0;
		else if (fifo_state == 3'd4)
			tx_eod <= 1;
		else
			tx_eod <= 0;
	always @(posedge clk)
		if (rst)
			payload_id <= 0;
		else if (tx_eod)
			payload_id <= payload_id + 1;
		else
			payload_id <= payload_id;
endmodule
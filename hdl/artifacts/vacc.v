module vacc (
	clk,
	ce,
	rst,
	acc_n,
	data_in,
	sync,
	trig,
	data_out,
	we,
	addr
);
	parameter integer VECTOR_WIDTH = 11;
	parameter integer INPUT_WIDTH = 36;
	parameter integer OUTPUT_WIDTH = 64;
	input wire clk;
	input wire ce;
	input wire rst;
	input wire [31:0] acc_n;
	input wire [INPUT_WIDTH - 1:0] data_in;
	input wire sync;
	input wire trig;
	output reg [OUTPUT_WIDTH - 1:0] data_out;
	output reg we;
	output reg [VECTOR_WIDTH - 1:0] addr;
	reg [2:0] state = 3'd0;
	reg [VECTOR_WIDTH - 1:0] data_addr;
	always @(posedge clk)
		if (rst)
			data_addr <= 0;
		else if (ce && (state != 3'd0))
			data_addr <= data_addr + 1;
		else
			data_addr <= data_addr;
	reg start;
	always @(*) start = data_addr == ((2 ** VECTOR_WIDTH) - 1);
	reg finish;
	always @(*) finish = addr == ((2 ** VECTOR_WIDTH) - 1);
	integer accumulations;
	always @(posedge clk)
		if (rst)
			state <= 3'd0;
		else if ((ce && (state == 3'd0)) && sync)
			state <= 3'd1;
		else if ((ce && (state == 3'd1)) && trig)
			state <= 3'd2;
		else if ((ce && (state == 3'd2)) && start)
			state <= 3'd3;
		else if ((ce && (state == 3'd3)) && (accumulations == acc_n))
			state <= 3'd4;
		else if ((ce && (state == 3'd4)) && finish)
			state <= 3'd1;
		else
			state <= state;
	reg [OUTPUT_WIDTH - 1:0] last_data_in;
	always @(posedge clk)
		if (rst)
			last_data_in <= 0;
		else if (ce && (state == 3'd3))
			last_data_in[INPUT_WIDTH - 1:0] <= data_in;
		else
			last_data_in <= 0;
	reg [VECTOR_WIDTH - 1:0] last_addr;
	always @(posedge clk)
		if (rst)
			last_addr <= 0;
		else if (ce && ((state == 3'd3) || (state == 3'd4)))
			last_addr <= data_addr;
		else
			last_addr <= last_addr;
	reg [OUTPUT_WIDTH - 1:0] in_a;
	reg [OUTPUT_WIDTH - 1:0] in_b;
	wire [OUTPUT_WIDTH - 1:0] out_a;
	wire [OUTPUT_WIDTH - 1:0] out_b;
	reg [VECTOR_WIDTH - 1:0] addr_a;
	reg [VECTOR_WIDTH - 1:0] addr_b;
	reg we_a;
	reg we_b;
	dpram #(
		.ADDR_WIDTH(VECTOR_WIDTH),
		.DATA_WIDTH(OUTPUT_WIDTH)
	) mem(
		.clk(clk),
		.en_a(ce),
		.en_b(ce),
		.we_a(we_a),
		.we_b(we_b),
		.addr_a(addr_a),
		.addr_b(addr_b),
		.in_a(in_a),
		.in_b(in_b),
		.out_a(out_a),
		.out_b(out_b)
	);
	reg [OUTPUT_WIDTH - 1:0] acc;
	always @(posedge clk)
		if (rst)
			acc <= 0;
		else if (ce && (state == 3'd3))
			acc <= out_a + last_data_in;
		else
			acc <= 0;
	reg [VECTOR_WIDTH - 1:0] acc_addr;
	always @(posedge clk)
		if (rst)
			acc_addr <= 0;
		else if (ce && ((state == 3'd3) || (state == 3'd4)))
			acc_addr <= last_addr;
		else
			acc_addr <= acc_addr;
	reg [VECTOR_WIDTH - 1:0] out_addr;
	always @(posedge clk)
		if (rst)
			out_addr <= 0;
		else if (ce && ((state == 3'd3) || (state == 3'd4)))
			out_addr <= acc_addr;
		else
			out_addr <= out_addr;
	always @(posedge clk)
		if (rst)
			accumulations <= 0;
		else if ((ce && (state == 3'd3)) && (acc_addr == ((2 ** VECTOR_WIDTH) - 1)))
			accumulations <= accumulations + 1;
		else if (ce && (state == 3'd4))
			accumulations <= 0;
		else
			accumulations <= accumulations;
	always @(*)
		if (ce && (state == 3'd3)) begin
			in_a = 0;
			we_a = 0;
			addr_a = data_addr;
		end
		else if (ce && (state == 3'd4)) begin
			in_a = 0;
			we_a = 1;
			addr_a = out_addr;
		end
		else begin
			in_a = 0;
			we_a = 0;
			addr_a = 0;
		end
	always @(*)
		if (ce && (state == 3'd3)) begin
			in_b = acc;
			we_b = 1;
			addr_b = acc_addr;
		end
		else if (ce && (state == 3'd4)) begin
			in_b = 0;
			we_b = 0;
			addr_b = out_addr;
		end
		else begin
			in_b = 0;
			we_b = 0;
			addr_b = 0;
		end
	always @(*)
		if ((ce && (state == 3'd4)) && we)
			data_out = out_b;
		else
			data_out = 0;
	always @(posedge clk)
		if (rst)
			addr <= 0;
		else if (ce && (state == 3'd4))
			addr <= out_addr;
		else
			addr <= 0;
	always @(posedge clk)
		if (rst)
			we <= 0;
		else if ((ce && (state == 3'd4)) && !finish)
			we <= 1;
		else
			we <= 0;
endmodule
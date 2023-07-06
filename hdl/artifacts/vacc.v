module vacc (
	clk,
	ce,
	rst,
	data_in,
	sync_in,
	trig,
	data_out,
	we,
	addr
);
	parameter integer ACCUMULATIONS = 1048576;
	parameter integer VECTOR_WIDTH = 11;
	parameter integer INPUT_WIDTH = 36;
	parameter integer OUTPUT_WIDTH = 128;
	input wire clk;
	input wire ce;
	input wire rst;
	input wire [INPUT_WIDTH - 1:0] data_in;
	input wire sync_in;
	input wire trig;
	output reg [OUTPUT_WIDTH - 1:0] data_out;
	output reg we;
	output reg [VECTOR_WIDTH - 1:0] addr;
	reg state = 1'd0;
	always @(posedge clk)
		if (rst)
			state <= 1'd0;
		else if ((ce && (state == 1'd0)) && sync_in)
			state <= 1'd1;
		else
			state <= state;
	reg enable;
	always @(*) enable = ce && (state == 1'd1);
	reg [1:0] vacc_state = 2'd0;
	integer accumulations;
	reg [VECTOR_WIDTH - 1:0] drain_addr;
	reg [VECTOR_WIDTH - 1:0] acc_addr;
	always @(posedge clk)
		if (rst)
			vacc_state <= 2'd0;
		else if ((enable && (vacc_state == 2'd0)) && trig)
			vacc_state <= 2'd1;
		else if ((enable && (vacc_state == 2'd1)) && (acc_addr == ((2 ** VECTOR_WIDTH) - 1)))
			vacc_state <= 2'd2;
		else if (((enable && (vacc_state == 2'd2)) && (accumulations == (ACCUMULATIONS - 1))) && (acc_addr == ((2 ** VECTOR_WIDTH) - 1)))
			vacc_state <= 2'd3;
		else if ((enable && (vacc_state == 2'd3)) && (drain_addr == ((2 ** VECTOR_WIDTH) - 1)))
			vacc_state <= 2'd0;
		else
			vacc_state <= vacc_state;
	reg [OUTPUT_WIDTH - 1:0] mem [0:(2 ** VECTOR_WIDTH) - 1];
	reg [VECTOR_WIDTH - 1:0] data_addr;
	always @(posedge clk)
		if (rst)
			data_addr <= 0;
		else if (enable)
			data_addr <= data_addr + 1;
		else
			data_addr <= data_addr;
	reg [OUTPUT_WIDTH - 1:0] last_data_in;
	always @(posedge clk)
		if (rst)
			last_data_in <= 0;
		else if (enable)
			last_data_in[INPUT_WIDTH - 1:0] <= data_in;
		else
			last_data_in <= last_data_in;
	reg [OUTPUT_WIDTH - 1:0] last_acc;
	always @(posedge clk)
		if (rst)
			last_acc <= 0;
		else if (enable)
			last_acc <= mem[data_addr];
		else
			last_acc <= last_acc;
	reg [VECTOR_WIDTH - 1:0] last_addr;
	always @(posedge clk)
		if (rst)
			last_addr <= 0;
		else if (enable)
			last_addr <= data_addr;
		else
			last_addr <= last_addr;
	reg [OUTPUT_WIDTH - 1:0] acc;
	always @(posedge clk)
		if (rst)
			acc <= 0;
		else if (enable)
			acc <= last_acc + last_data_in;
		else
			acc <= acc;
	always @(posedge clk)
		if (rst)
			acc_addr <= 0;
		else if (enable)
			acc_addr <= last_addr;
		else
			acc_addr <= acc_addr;
	always @(posedge clk)
		if (rst)
			mem[acc_addr] <= 0;
		else if (enable && (vacc_state == 2'd2))
			mem[acc_addr] <= acc;
		else if (enable && (vacc_state == 2'd3))
			mem[drain_addr] <= 0;
		else begin
			mem[drain_addr] <= mem[drain_addr];
			mem[acc_addr] <= mem[acc_addr];
		end
	always @(posedge clk)
		if (rst)
			accumulations <= 0;
		else if ((enable && (vacc_state == 2'd2)) && (acc_addr == ((2 ** VECTOR_WIDTH) - 1)))
			accumulations <= accumulations + 1;
		else if (((ce && (state == 1'd1)) && (vacc_state == 2'd3)) && (drain_addr == ((2 ** VECTOR_WIDTH) - 1)))
			accumulations <= 0;
		else
			accumulations <= accumulations;
	always @(posedge clk)
		if (rst)
			drain_addr <= 0;
		else if (enable && (vacc_state == 2'd3))
			drain_addr <= drain_addr + 1;
		else if ((enable && (vacc_state == 2'd3)) && (drain_addr == ((2 ** VECTOR_WIDTH) - 1)))
			drain_addr <= 0;
		else
			drain_addr <= drain_addr;
	always @(posedge clk)
		if (rst)
			data_out <= 0;
		else if (enable && (vacc_state == 2'd3))
			data_out <= mem[drain_addr];
		else
			data_out <= data_out;
	always @(posedge clk)
		if (rst)
			addr <= 0;
		else if (enable && (vacc_state == 2'd3))
			addr <= drain_addr;
		else
			addr <= addr;
	always @(posedge clk)
		if (rst)
			we <= 0;
		else if (enable && (vacc_state == 2'd3))
			we <= 1;
		else
			we <= 0;
endmodule
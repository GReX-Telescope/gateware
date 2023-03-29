module fifo (
	clk,
	rst,
	we,
	din,
	re,
	dout,
	empty,
	full
);
	parameter integer DATA_WIDTH = 64;
	parameter integer DEPTH = 1024;
	input wire clk;
	input wire rst;
	input wire we;
	input wire [DATA_WIDTH - 1:0] din;
	input wire re;
	output reg [DATA_WIDTH - 1:0] dout;
	output reg empty;
	output reg full;
	reg [DATA_WIDTH - 1:0] mem [0:DEPTH - 1];
	parameter integer WIDTH = $clog2(DEPTH);
	reg [WIDTH - 1:0] waddr;
	reg [WIDTH - 1:0] raddr;
	always @(*) begin
		full = (waddr + 1'b1) == raddr;
		empty = waddr == raddr;
	end
	always @(posedge clk) begin
		if (!empty && re)
			dout <= mem[raddr];
		else if (!rst)
			dout <= dout;
		else
			dout <= 0;
		if (!full && we)
			mem[waddr] <= din;
		else
			mem[waddr] <= mem[waddr];
	end
	always @(posedge clk) begin
		if (rst)
			waddr <= 0;
		else if (!full && we)
			waddr <= waddr + 1;
		else
			waddr <= waddr;
		if (rst)
			raddr <= 0;
		else if (!empty && re)
			raddr <= raddr + 1;
		else
			raddr <= raddr;
	end
endmodule
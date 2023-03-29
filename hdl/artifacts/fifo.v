`default_nettype none
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
	reg [(DEPTH * DATA_WIDTH) - 1:0] mem;
	parameter integer WIDTH = $clog2(DEPTH);
	reg [WIDTH - 1:0] waddr;
	reg [WIDTH - 1:0] raddr;
	integer counter = 0;
	always @(*) begin
		full = counter == DEPTH;
		empty = counter == 0;
	end
	always @(posedge clk or posedge rst)
		if (rst)
			counter <= 0;
		else if ((!full && we) && (!empty && re))
			counter <= counter;
		else if (!full && we)
			counter <= counter + 1;
		else if (!empty && re)
			counter <= counter - 1;
		else
			counter <= counter;
	function automatic [DATA_WIDTH - 1:0] sv2v_cast_F7251;
		input reg [DATA_WIDTH - 1:0] inp;
		sv2v_cast_F7251 = inp;
	endfunction
	always @(posedge clk or posedge rst)
		if (rst)
			mem <= {DEPTH {sv2v_cast_F7251(1'sb0)}};
		else begin
			if (!empty && re)
				dout <= mem[((DEPTH - 1) - raddr) * DATA_WIDTH+:DATA_WIDTH];
			else
				dout <= dout;
			if (!full && we)
				mem[((DEPTH - 1) - waddr) * DATA_WIDTH+:DATA_WIDTH] <= din;
			else
				mem[((DEPTH - 1) - waddr) * DATA_WIDTH+:DATA_WIDTH] <= mem[((DEPTH - 1) - waddr) * DATA_WIDTH+:DATA_WIDTH];
		end
	always @(posedge clk or posedge rst)
		if (rst) begin
			waddr <= 0;
			raddr <= 0;
		end
		else begin
			if (!full && we)
				waddr <= waddr + 1;
			else
				waddr <= waddr;
			if (!empty && re)
				raddr <= raddr + 1;
			else
				raddr <= raddr;
		end
endmodule
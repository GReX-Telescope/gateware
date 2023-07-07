module dpram (
	clk,
	in_a,
	addr_a,
	en_a,
	we_a,
	in_b,
	addr_b,
	en_b,
	we_b,
	out_a,
	out_b
);
	parameter integer ADDR_WIDTH = 11;
	parameter integer DATA_WIDTH = 16;
	input wire clk;
	input wire [DATA_WIDTH - 1:0] in_a;
	input wire [ADDR_WIDTH - 1:0] addr_a;
	input wire en_a;
	input wire we_a;
	input wire [DATA_WIDTH - 1:0] in_b;
	input wire [ADDR_WIDTH - 1:0] addr_b;
	input wire en_b;
	input wire we_b;
	output reg [DATA_WIDTH - 1:0] out_a;
	output reg [DATA_WIDTH - 1:0] out_b;
	reg [DATA_WIDTH - 1:0] RAM [0:(2 ** ADDR_WIDTH) - 1];
	always @(posedge clk) begin : portA
		if (en_a) begin
			if (we_a)
				RAM[addr_a] <= in_a;
			out_a <= RAM[addr_a];
		end
	end
	always @(posedge clk) begin : portB
		if (en_b) begin
			if (we_b)
				RAM[addr_b] <= in_b;
			out_b <= RAM[addr_b];
		end
	end
endmodule
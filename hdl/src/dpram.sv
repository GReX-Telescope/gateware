module dpram #(
    parameter integer ADDR_WIDTH = 11,
    parameter integer DATA_WIDTH = 16
) (
    input logic clk,
    // A input
    input logic [DATA_WIDTH-1:0] in_a,
    input logic [ADDR_WIDTH-1:0] addr_a,
    input logic en_a,
    input logic we_a,
    // B Input
    input logic [DATA_WIDTH-1:0] in_b,
    input logic [ADDR_WIDTH-1:0] addr_b,
    input logic en_b,
    input logic we_b,
    // Output
    output logic [DATA_WIDTH-1:0] out_a,
    output logic [DATA_WIDTH-1:0] out_b
);
  // Memory
  logic [DATA_WIDTH-1:0] RAM[2**ADDR_WIDTH];
  // Logic
  always_ff @(posedge clk) begin : portA
    if (en_a) begin
      if (we_a) RAM[addr_a] <= in_a;
      out_a <= RAM[addr_a];
    end
  end
  always_ff @(posedge clk) begin : portB
    if (en_b) begin
      if (we_b) RAM[addr_b] <= in_b;
      out_b <= RAM[addr_b];
    end
  end
endmodule

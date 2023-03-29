module fifo #(
    parameter integer DATA_WIDTH = 64,
    parameter integer DEPTH = 1024
) (
    // Standard preamble
    input logic clk,  // Clock
    input logic rst,  // Async reset
    // Input side
    input logic we,  // Write enable
    input logic [DATA_WIDTH-1:0] din,  // Input data
    // Output side
    input logic re,  // Read enable
    output logic [DATA_WIDTH-1:0] dout,  // Output data
    // Signals
    output logic empty,
    output logic full
);
  // FIFO storage
  logic [DATA_WIDTH-1:0] mem[DEPTH];
  // Addrs
  parameter integer WIDTH = $clog2(DEPTH);
  logic [WIDTH-1:0] waddr;
  logic [WIDTH-1:0] raddr;

  // Signals
  always_comb begin
    full  = (waddr + 1'b1 == raddr);
    empty = (waddr == raddr);
  end

  // Read and write
  always_ff @(posedge clk) begin
    // Read
    if (!empty && re) dout <= mem[raddr];
    else if (!rst) dout <= dout;
    else dout <= 0;
    // Write
    if (!full && we) mem[waddr] <= din;
    else mem[waddr] <= mem[waddr];
  end

  // Address movements
  always_ff @(posedge clk) begin
    // Write ptr
    if (rst) waddr <= 0;
    else if (!full && we) waddr <= waddr + 1;
    else waddr <= waddr;
    // Read ptr
    if (rst) raddr <= 0;
    else if (!empty && re) raddr <= raddr + 1;
    else raddr <= raddr;
  end
endmodule

`default_nettype none

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
  // State
  integer counter = 0;

  // Signals
  always_comb begin
    full  = (counter == DEPTH);
    empty = (counter == 0);
  end

  // Counter logic
  always_ff @(posedge clk, posedge rst) begin
    if (rst) counter <= 0;  // Initial condition
    else if ((!full && we) && (!empty && re)) counter <= counter;  // Reading and writing
    else if ((!full && we)) counter <= counter + 1;  // Writing
    else if ((!empty && re)) counter <= counter - 1;  // Reading
    else counter <= counter;  // Fallback
  end

  // Read and write
  always_ff @(posedge clk, posedge rst) begin
    if (rst) mem <= '{default: '0};
    else begin
      // Read
      if (!empty && re) dout <= mem[raddr];
      else dout <= dout;
      // Write
      if (!full && we) mem[waddr] <= din;
      else mem[waddr] <= mem[waddr];
    end
  end

  // Address movements
  always_ff @(posedge clk, posedge rst) begin
    if (rst) begin
      waddr <= 0;
      raddr <= 0;
    end else begin
      // Write ptr
      if (!full && we) waddr <= waddr + 1;
      else waddr <= waddr;
      // Read ptr
      if (!empty && re) raddr <= raddr + 1;
      else raddr <= raddr;
    end
  end
endmodule

// FSM States
typedef enum logic [2:0] {
  wait_for_sync,
  wait_for_trig,
  wait_for_start,
  accumulating,
  draining
} state_t;

module vacc #(
    parameter integer VECTOR_WIDTH = 11,  // 2048 channels
    parameter integer INPUT_WIDTH  = 36,  // 18 bits squared
    parameter integer OUTPUT_WIDTH = 64   // Handle the bit growth
) (
    // Standard preamble
    input logic clk,  // Clock
    input logic ce,  // Clock enable
    input logic rst,  // Sync reset
    // Input side
    input logic [31:0] acc_n,
    input logic [INPUT_WIDTH-1:0] data_in,
    input logic sync,
    input logic trig,
    // Output side
    output logic [OUTPUT_WIDTH-1:0] data_out,
    output logic we,
    output logic [VECTOR_WIDTH-1:0] addr
);
  // Internal state
  state_t state = wait_for_sync;

  // Input address counter. This is the address of the data we are reading from
  logic [VECTOR_WIDTH-1:0] data_addr;
  always_ff @(posedge clk) begin
    if (rst) data_addr <= 0;
    else if (ce && (state != wait_for_sync)) data_addr <= data_addr + 1;
    else data_addr <= data_addr;
  end

  // Bool that checks if we are about to start a new chunk of data
  logic start;
  always_comb begin
    start = data_addr == (2 ** VECTOR_WIDTH) - 1;
  end

  logic finish;
  always_comb begin
    finish = addr == (2 ** VECTOR_WIDTH) - 1;
  end

  // State updates
  always_ff @(posedge clk) begin
    if (rst) state <= wait_for_sync;
    else if (ce && (state == wait_for_sync) && sync) state <= wait_for_trig;
    else if (ce && (state == wait_for_trig) && trig) state <= wait_for_start;
    else if (ce && (state == wait_for_start) && start) state <= accumulating;
    else if (ce && (state == accumulating) && (accumulations == acc_n)) state <= draining;
    else if (ce && (state == draining) && finish) state <= wait_for_trig;
    else state <= state;
  end

  // Buffer the input data to match the latency of reading the previous accumulation from ram
  logic [OUTPUT_WIDTH-1:0] last_data_in;
  always_ff @(posedge clk) begin
    if (rst) last_data_in <= 0;
    else if (ce && (state == accumulating)) last_data_in[INPUT_WIDTH-1:0] <= data_in;
    else last_data_in <= 0;
  end

  // And buffer the adddr to match the data
  logic [VECTOR_WIDTH-1:0] last_addr;
  always_ff @(posedge clk) begin
    if (rst) last_addr <= 0;
    else if (ce && (state == accumulating || state == draining)) last_addr <= data_addr;
    else last_addr <= last_addr;
  end

  // Use port a to always read previous accumulation

  logic [OUTPUT_WIDTH-1:0] in_a;
  logic [OUTPUT_WIDTH-1:0] in_b;
  logic [OUTPUT_WIDTH-1:0] out_a;
  logic [OUTPUT_WIDTH-1:0] out_b;
  logic [VECTOR_WIDTH-1:0] addr_a;
  logic [VECTOR_WIDTH-1:0] addr_b;
  logic we_a;
  logic we_b;

  // Setup the dual-port RAM
  dpram #(
      .ADDR_WIDTH(VECTOR_WIDTH),
      .DATA_WIDTH(OUTPUT_WIDTH)
  ) mem (
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

  // Perform the sum into port b
  logic [OUTPUT_WIDTH-1:0] acc;
  always_ff @(posedge clk) begin
    if (rst) acc <= 0;
    else if (ce && (state == accumulating)) acc <= out_a + last_data_in;
    else acc <= 0;
  end

  // Shift the sum addr to align with the accumulation
  logic [VECTOR_WIDTH-1:0] acc_addr;
  always_ff @(posedge clk) begin
    if (rst) acc_addr <= 0;
    else if (ce && (state == accumulating || state == draining)) acc_addr <= last_addr;
    else acc_addr <= acc_addr;
  end

  // And one addr shift to match the output
  logic [VECTOR_WIDTH-1:0] out_addr;
  always_ff @(posedge clk) begin
    if (rst) out_addr <= 0;
    else if (ce && (state == accumulating || state == draining)) out_addr <= acc_addr;
    else out_addr <= out_addr;
  end

  // Keep tabs on the number of accumulations
  integer accumulations;
  always_ff @(posedge clk) begin
    if (rst) accumulations <= 0;
    else if (ce && (state == accumulating) && (acc_addr == (2 ** VECTOR_WIDTH) - 1))
      accumulations <= accumulations + 1;
    else if (ce && (state == draining)) accumulations <= 0;
    else accumulations <= accumulations;
  end

  // Port A Logic
  // Use port A to read the last accumulation and to clear the accumulation when draining
  always_comb begin
    if (ce && (state == accumulating)) begin
      in_a   = 0;
      we_a   = 0;
      addr_a = data_addr;
    end else if (ce && (state == draining)) begin
      in_a   = 0;
      we_a   = 1;
      addr_a = out_addr;
    end else begin
      in_a   = 0;
      we_a   = 0;
      addr_a = 0;
    end
  end

  // Port B Logic
  // Use port B to write the accumulation to memory and to read accumulations out
  always_comb begin
    if (ce && (state == accumulating)) begin
      in_b   = acc;
      we_b   = 1;
      addr_b = acc_addr;
    end else if (ce && (state == draining)) begin
      in_b   = 0;
      we_b   = 0;
      addr_b = out_addr;
    end else begin
      in_b   = 0;
      we_b   = 0;
      addr_b = 0;
    end
  end

  always_comb begin
    if (ce && (state == draining) && we) begin
      data_out = out_b;
    end else begin
      data_out = 0;
    end
  end

  // Handle output
  always_ff @(posedge clk) begin
    if (rst) begin
      addr <= 0;
    end else if (ce && (state == draining)) begin
      addr <= out_addr;
    end else begin
      addr <= 0;
    end
  end

  always_ff @(posedge clk) begin
    if (rst) begin
      we <= 0;
    end else if (ce && (state == draining) && !finish) begin
      we <= 1;
    end else begin
      we <= 0;
    end
  end

endmodule

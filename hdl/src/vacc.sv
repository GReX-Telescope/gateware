// FSM States
typedef enum logic {
  wait_sync,
  running
} sync_state_t;

typedef enum logic [1:0] {
  wait_for_trig,
  wait_for_start,
  accumulating,
  draining
} vacc_state_t;

module vacc #(
    parameter integer ACCUMULATIONS = 1048576,  // 2^20 accumulations
    parameter integer VECTOR_WIDTH  = 11,       // 2048 channels
    parameter integer INPUT_WIDTH   = 36,       // 18 bits squared
    parameter integer OUTPUT_WIDTH  = 128       // Lots of time
) (
    // Standard preamble
    input logic clk,    // Clock
    input logic ce,     // Clock enable
    input logic rst,    // Sync reset
    // Input side
    input logic [INPUT_WIDTH-1:0] data_in,
    input logic sync_in,
    input logic trig,
    // Output side
    output logic [OUTPUT_WIDTH-1:0] data_out,
    output logic we,
    output logic [VECTOR_WIDTH-1:0] addr
);

  // Internal state
  sync_state_t state = wait_sync;

  // State updates
  always_ff @(posedge clk) begin
    if (rst) state <= wait_sync;
    else if (ce && (state == wait_sync) && sync_in) state <= running;
    else state <= state;
  end

  // Simplified signal for enable
  logic enable;
  always_comb enable = ce && (state == running);

  // Accumulation state
  vacc_state_t vacc_state = wait_for_trig;
  integer accumulations;
  logic [VECTOR_WIDTH-1:0] drain_addr;
  always_ff @(posedge clk) begin
    if (rst) vacc_state <= wait_for_trig;
    else if (enable && (vacc_state == wait_for_trig) && trig) vacc_state <= wait_for_start;
    else if (enable && (vacc_state == wait_for_start) && (acc_addr == (2 ** VECTOR_WIDTH) - 1))
      vacc_state <= accumulating;
    else if (enable &&
    (vacc_state == accumulating) &&
     (accumulations == ACCUMULATIONS - 1) &&
     (acc_addr == (2 ** VECTOR_WIDTH) - 1))
      vacc_state <= draining;
    else if (enable && (vacc_state == draining) && (drain_addr == (2 ** VECTOR_WIDTH) - 1))
      vacc_state <= wait_for_trig;
    else vacc_state <= vacc_state;
  end

  // Setup our internal BRAM
  logic [OUTPUT_WIDTH-1:0] mem[2**VECTOR_WIDTH];

  // Input address counter. This is the address of the data we are reading from
  logic [VECTOR_WIDTH-1:0] data_addr;
  always_ff @(posedge clk) begin
    if (rst) data_addr <= 0;
    else if (enable) data_addr <= data_addr + 1;
    else data_addr <= data_addr;
  end

  // Reading from the mem has a delay of 1, so we need to keep around the last data and pad with zeros
  logic [OUTPUT_WIDTH-1:0] last_data_in;
  always_ff @(posedge clk) begin
    if (rst) last_data_in <= 0;
    else if (enable) last_data_in[INPUT_WIDTH-1:0] <= data_in;
    else last_data_in <= last_data_in;
  end

  // Read previous data of this address, and shift the address
  logic [OUTPUT_WIDTH-1:0] last_acc;
  always_ff @(posedge clk) begin
    if (rst) last_acc <= 0;
    else if (enable) last_acc <= mem[data_addr];
    else last_acc <= last_acc;
  end

  logic [VECTOR_WIDTH-1:0] last_addr;
  always_ff @(posedge clk) begin
    if (rst) last_addr <= 0;
    else if (enable) last_addr <= data_addr;
    else last_addr <= last_addr;
  end

  // Perform the sum
  logic [OUTPUT_WIDTH-1:0] acc;
  always_ff @(posedge clk) begin
    if (rst) acc <= 0;
    else if (enable) acc <= last_acc + last_data_in;
    else acc <= acc;
  end

  // Shift the sum addr
  logic [VECTOR_WIDTH-1:0] acc_addr;
  always_ff @(posedge clk) begin
    if (rst) acc_addr <= 0;
    else if (enable) acc_addr <= last_addr;
    else acc_addr <= acc_addr;
  end

  // Write the sum to memory and clear while draining
  always_ff @(posedge clk) begin
    if (rst) mem[acc_addr] <= 0;
    else if (enable && (vacc_state == accumulating)) mem[acc_addr] <= acc;
    else if (enable && (vacc_state == draining)) mem[drain_addr] <= 0;
    else begin
      mem[drain_addr] <= mem[drain_addr];
      mem[acc_addr]   <= mem[acc_addr];
    end
  end

  // Increment the accumulation counter
  always_ff @(posedge clk) begin
    if (rst) accumulations <= 0;
    else if (enable && (vacc_state == accumulating) && (acc_addr == (2 ** VECTOR_WIDTH) - 1))
      accumulations <= accumulations + 1;
    else if (ce                    &&
      (state == running)           &&
      (vacc_state == draining) &&
      drain_addr == (2**VECTOR_WIDTH)-1)
      accumulations <= 0;
    else accumulations <= accumulations;
  end

  // Drain the accumulator
  always_ff @(posedge clk) begin
    if (rst) drain_addr <= 0;
    else if (enable && (vacc_state == draining)) drain_addr <= drain_addr + 1;
    else if (enable && (vacc_state == draining) && (drain_addr == (2 ** VECTOR_WIDTH) - 1))
      drain_addr <= 0;
    else drain_addr <= drain_addr;
  end

  // Output the data
  always_ff @(posedge clk) begin
    if (rst) data_out <= 0;
    else if (enable && (vacc_state == draining)) data_out <= mem[drain_addr];
    else data_out <= data_out;
  end

  always_ff @(posedge clk) begin
    if (rst) addr <= 0;
    else if (enable && (vacc_state == draining)) addr <= drain_addr;
    else addr <= addr;
  end

  always_ff @(posedge clk) begin
    if (rst) we <= 0;
    else if (enable && (vacc_state == draining)) we <= 1;
    else we <= 0;
  end

endmodule

`default_nettype none

// FSM States
typedef enum logic {
  wait_sync,
  running
} state_t;

typedef enum logic [2:0] {
  loading,
  dump_a,
  last_a,
  dump_b,
  last_b
} fifo_state_t;

typedef logic [15:0] data_word_t;  // 8 + 8 Bit complex, but that doesn't matter here
typedef logic [63:0] packet_word_t;  // 64 bits, as set by the CASPER 10GbE block

// ---------Ethernet Payload Layout ---------
// +------+---------------------------------+
// | Word |            Data                 |
// +------+---------------------------------+
// | 0000 |          Packet Count           |
// | 0001 | [A0000] [A0001] [A0002] [A0003] |
// | 0002 | [A0004] [A0005] [A0006] [A0007] |
// | .... | ............................... |
// | 0512 | [A2044] [A2045] [A2046] [A2047] |
// | 0513 | [B0000] [B0001] [B0002] [B0003] |
// | 0514 | [B0004] [B0005] [B0006] [B0007] |
// | .... | ............................... |
// | 1023 | [B2044] [B2045] [B2046] [B2047] |
// +------+---------------------------------+

module packetizer (
    // Standard cell inputs
    input logic clk,  // Clock
    input logic ce,   // Clock enable
    input logic rst,  // Asynchronous reset

    // Packetizer Inputs
    input data_word_t pol_a,
    input data_word_t pol_b,
    input logic       sync,   // Sync pulse input

    // Ethernet outputs
    output packet_word_t tx_data,
    output logic         tx_valid,
    output logic         tx_eod
);

  // Locals and initial conditions
  state_t state = wait_sync;
  state_t next_state;

  // Marker bool to fix first edge case
  logic first_done = 0;

  // Counter for payload id
  packet_word_t payload_id = 0;

  // In progress packed words
  packet_word_t packed_a = '0;
  packet_word_t packed_b = '0;
  logic [1:0] subword = '0;

  // FIFOs will write together
  logic fifo_we;
  // Counters for infill and exfill progress
  logic [8:0] fifo_w_count = '0;
  logic [10:0] fifo_r_count = '0;

  // Two FIFOs, one for each polarization
  logic fifo_a_re;
  logic fifo_b_re;
  packet_word_t fifo_a_dout;
  packet_word_t fifo_b_dout;

  fifo_state_t fifo_state = loading;
  fifo_state_t next_fifo_state;

  // FIFO sizes figured out experimentally
  fifo #(
      .DEPTH(513)
  ) fifo_a (
      .clk(clk),
      .rst(rst),
      .we(fifo_we),
      .din(packed_a),
      .re(fifo_a_re),
      .dout(fifo_a_dout),
      .empty(),
      .full()
  );
  fifo #(
      .DEPTH(641)
  ) fifo_b (
      .clk(clk),
      .rst(rst),
      .we(fifo_we),
      .din(packed_b),
      .re(fifo_b_re),
      .dout(fifo_b_dout),
      .empty(),
      .full()
  );

  // ---- FIFO Infill

  // State updates
  always_ff @(posedge clk, posedge rst) begin
    if (rst) state <= wait_sync;
    else if (ce) state <= next_state;
    else state <= state;
  end

  // State transition
  always_comb begin
    if ((state == wait_sync) && sync) next_state = running;
    else next_state = state;
  end

  // Subword counter
  always_ff @(posedge clk, posedge rst) begin
    if (rst) subword <= '0;
    // Initial transition after reset
    else if (ce && (state == wait_sync) && sync) subword <= 'd3;
    else if (ce && (state == running)) subword <= subword - 1;
    else subword <= subword;
  end

  // First word detect
  always_ff @(posedge clk, posedge rst) begin
    if (rst) first_done <= 0;
    else if (ce && (state == running) && (subword == 0)) first_done <= 1;
    else first_done <= first_done;
  end

  // Fill packed left to right
  always_ff @(posedge clk, posedge rst) begin
    if (rst) packed_a <= '0;
    else if (ce && (state == running)) packed_a[16*subword+:16] <= pol_a;
    else packed_a <= packed_a;
  end

  always_ff @(posedge clk, posedge rst) begin
    if (rst) packed_b <= '0;
    else if (ce && (state == running)) packed_b[16*subword+:16] <= pol_b;
    else packed_b <= packed_b;
  end

  // Write to FIFO
  always_comb begin
    if ((subword == 3) && first_done) fifo_we = 1;
    else fifo_we = 0;
  end

  always_ff @(posedge clk, posedge rst) begin
    if (rst) fifo_w_count <= '0;
    else if (ce && (state == running) && (subword == 0)) fifo_w_count <= fifo_w_count + 1;
    else fifo_w_count <= fifo_w_count;
  end

  // ----- FIFO Exfil

  // State updates
  always_ff @(posedge clk, posedge rst) begin
    if (rst) fifo_state <= loading;
    else if (ce && (state == running)) fifo_state <= next_fifo_state;
    else fifo_state <= fifo_state;
  end

  // State transitions
  always_comb begin
    if ((fifo_w_count == 0) && first_done) next_fifo_state = dump_a;
    else if ((fifo_state == dump_a) && (fifo_r_count == 511)) next_fifo_state = last_a;
    else if (fifo_state == last_a) next_fifo_state = dump_b;
    else if ((fifo_state == dump_b) && (fifo_r_count == 1023)) next_fifo_state = last_b;
    else if (fifo_state == last_b) next_fifo_state = loading;
    else next_fifo_state = fifo_state;
  end

  // FIFO Read Counter
  always_ff @(posedge clk, posedge rst) begin
    if (rst) fifo_r_count <= 0;
    else if (fifo_state != loading) fifo_r_count <= fifo_r_count + 1;
    else fifo_r_count <= 0;
  end

  // Signal to read from a on transition
  always_ff @(posedge clk, posedge rst) begin
    if (rst) fifo_a_re <= 0;
    else if (next_fifo_state == dump_a) fifo_a_re <= 1;
    else fifo_a_re <= 0;
  end

  // Signal to read from b on transition
  always_ff @(posedge clk, posedge rst) begin
    if (rst) fifo_b_re <= 0;
    else if ((next_fifo_state == last_a) || (next_fifo_state == dump_b)) fifo_b_re <= 1;
    else fifo_b_re <= 0;
  end

  // Dump FIFO outputs (tricky)
  always_ff @(posedge clk, posedge rst) begin
    if (rst) tx_data <= 0;
    else if ((fifo_state == dump_a) && (fifo_r_count == 0)) tx_data <= payload_id;
    else if ((fifo_state == dump_a) || (fifo_state == last_a)) tx_data <= fifo_a_dout;
    else if ((fifo_state == dump_b) || (fifo_state == last_b)) tx_data <= fifo_b_dout;
    else tx_data <= '0;
  end

  // TX Valid
  always_ff @(posedge clk, posedge rst) begin
    if (rst) tx_valid <= 0;
    else if (fifo_state != loading) tx_valid <= 1;
    else tx_valid <= 0;
  end

  // TX EOD
  always_ff @(posedge clk, posedge rst) begin
    if (rst) tx_eod <= 0;
    else if (fifo_state == last_b) tx_eod <= 1;
    else tx_eod <= 0;
  end

  // Payload counter
  always_ff @(posedge clk, posedge rst) begin
    if (rst) payload_id <= 0;
    else if (tx_eod) payload_id <= payload_id + 1;
    else payload_id <= payload_id;
  end

endmodule

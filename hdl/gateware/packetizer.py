from enum import Enum
from amaranth import Signal, Module, Elaboratable, Cat, Const, ClockDomain
from amaranth.lib.fifo import SyncFIFOBuffered
from amaranth.sim import Simulator
from amaranth.back import verilog


class PacketizerState(Enum):
    WaitArm = 0
    WaitSync = 1
    Running = 2


class FIFOState(Enum):
    Loading = 0
    Draining = 1
    EOF = 2


class Packetizer(Elaboratable):
    """The UDP packetizer for GReX Gateware."""

    def __init__(self, n_words: int):
        # Input Ports
        # Clock enable (unused, to make MATLAB happy)
        self.ce = Signal()
        self.arm = Signal()
        self.sync_in = Signal()
        # Packed 8+8 bit Fix8_7 complex numbers
        self.ch_a_in = Signal(16)
        self.ch_b_in = Signal(16)

        # Output Ports
        # Packed words for 10 GbE Core
        self.tx_data = Signal(64)
        # True when tx_data should be read into the 10 Gbe Core
        self.tx_valid = Signal()
        # True when tx_data contains the last word
        self.tx_eof = Signal()

        # State
        # A counter for how many total payloads we've sent
        self.payload_count = Signal(64)
        # A counter for words
        self.word_count = Signal(11)
        # A counter for draining the FIFO
        self.fifo_drain_count = Signal(11)
        # A flag to indicate if we're on the low word or high word
        self.low_word = Signal(reset=1)
        # A buffer to hold the previous cycles channelized data
        self.last_data = Signal(32)
        # FSM States with initial values
        self.state = Signal(PacketizerState, reset=PacketizerState.WaitArm)
        self.fifo_state = Signal(FIFOState, reset=FIFOState.Loading)

        # Constants
        self.n_words = Const(n_words)

    def ports(self):
        return [
            # Inputs
            self.ce,
            self.sync_in,
            self.ch_a_in,
            self.ch_b_in,
            # Outputs
            self.tx_data,
            self.tx_valid,
            self.tx_eof,
        ]

    def elaborate(self, _):
        # Instatiate the module
        m = Module()

        # Setup the FIFO submodule
        # Depth is the number of words we will send
        #  + 1 for the header + 10 for overhead
        fifo = SyncFIFOBuffered(width=64, depth=self.n_words.value + 11)
        m.submodules.fifo = fifo

        # State Transitions
        with m.If(self.arm):
            with m.If(self.state == PacketizerState.WaitArm):
                m.d.sync += self.state.eq(PacketizerState.WaitSync)
            with m.Elif(self.state == PacketizerState.Running):
                m.d.sync += self.state.eq(PacketizerState.WaitSync)
        with m.If(self.sync_in):
            with m.If(self.state == PacketizerState.WaitSync):
                m.d.sync += self.state.eq(PacketizerState.Running)
                # The next clock will contain valid data
                # Implying *this* clock cycle needs to push the first header
                # Which is easy, because it's zero
                m.d.comb += fifo.w_data.eq(self.payload_count)
                m.d.comb += fifo.w_en.eq(1)

        # We don't care about anything, until we're in the running state
        with m.If(self.state == PacketizerState.Running):
            # We have to collect every two words from both channels to form
            # the 64 bit word to push to the FIFO
            with m.If(self.low_word):
                m.d.sync += self.last_data.eq(Cat(self.ch_b_in, self.ch_a_in))
                m.d.sync += self.low_word.eq(~self.low_word)
                # When we're writing the low word (0-indexed), we need to check
                # if the last cycle was the last word for this chunk.
                # If it was, we need to:
                with m.If(self.word_count == self.n_words):
                    # - increment the payload counter
                    new_payload_count = self.payload_count + 1
                    m.d.sync += self.payload_count.eq(new_payload_count)
                    # - Write the next header
                    m.d.comb += fifo.w_data.eq(new_payload_count)
                    m.d.comb += fifo.w_en.eq(1)
                    # - reset the word counter
                    m.d.sync += self.word_count.eq(0)
                    # - start draining the FIFO
                    m.d.sync += self.fifo_state.eq(FIFOState.Draining)
                    m.d.sync += fifo.r_en.eq(1)
            with m.Else():
                # Form the word and push to the FIFO
                m.d.comb += fifo.w_data.eq(
                    Cat(
                        Cat(self.ch_b_in, self.ch_a_in),
                        self.last_data,
                    )
                )
                m.d.comb += fifo.w_en.eq(1)
                # Increment our word counter
                m.d.sync += self.word_count.eq(self.word_count + 1)
                # Toggle the low word bit
                m.d.sync += self.low_word.eq(~self.low_word)

            # While we are running, we simultaneously need to manage
            # the FIFO state for the output
            with m.If(self.fifo_state == FIFOState.Draining):
                # Connect the outputs
                m.d.sync += fifo.r_en.eq(1)
                m.d.sync += self.tx_valid.eq(1)
                m.d.sync += self.tx_data.eq(fifo.r_data)
                # Start counting how many words we've drained
                m.d.sync += self.fifo_drain_count.eq(self.fifo_drain_count + 1)
                # We need to drain exactly n_words + 1 (for the header)
                with m.If(self.fifo_drain_count == self.n_words - 1):
                    m.d.sync += self.fifo_state.eq(FIFOState.EOF)
            with m.Elif(self.fifo_state == FIFOState.EOF):
                # Last words
                m.d.sync += fifo.r_en.eq(0)
                m.d.sync += self.tx_valid.eq(1)
                m.d.sync += self.tx_eof.eq(1)
                m.d.sync += self.tx_data.eq(fifo.r_data)
                # Reset the counter
                m.d.sync += self.fifo_drain_count.eq(0)
                # Back to just loading
                m.d.sync += self.fifo_state.eq(FIFOState.Loading)
            with m.Else():
                m.d.sync += self.tx_eof.eq(0)
                m.d.sync += self.tx_valid.eq(0)
                m.d.sync += self.tx_data.eq(0)

        # Default output values
        with m.Else():
            m.d.sync += self.tx_data.eq(0)
            m.d.sync += self.tx_valid.eq(0)
            m.d.sync += self.tx_eof.eq(0)

        # Return the module to elaborate
        return m

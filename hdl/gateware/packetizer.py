from enum import Enum
from typing import List
from amaranth import *
from amaranth.lib.fifo import SyncFIFOBuffered


class PacketizerState(Enum):
    WaitArm = 0
    WaitSync = 1
    Running = 2


class FIFOState(Enum):
    Loading = 0
    Draining = 1
    EOF = 2


INPUT_SIZE = 16
WORD_SIZE = 64


class PacketizerState(Enum):
    WaitArm = 0
    WaitSync = 1
    Running = 2


class FIFOState(Enum):
    Loading = 0
    Draining = 1
    EOF = 2


class Packetizer(Elaboratable):
    def __init__(self, n_words: int):
        ### Inputs
        self.ce = Signal()
        self.arm = Signal()
        self.sync_in = Signal()
        self.ch_a = Signal(INPUT_SIZE)
        self.ch_b = Signal(INPUT_SIZE)

        ### Observable Internal State
        self.state = Signal(PacketizerState, reset=PacketizerState.WaitArm)
        self.high_bit = Signal()
        self.last_inputs = Signal(2 * INPUT_SIZE)
        self.words = Signal(range(n_words + 1))
        self.payloads = Signal(WORD_SIZE)
        self.n_words = n_words
        self.fifo_state = Signal(FIFOState, reset=FIFOState.Loading)
        self.drain_count = Signal(range(n_words + 1))

        ### Outputs
        self.tx_data = Signal(WORD_SIZE)
        self.tx_valid = Signal()
        self.tx_eof = Signal()

    def ports(self) -> List[Signal]:
        return [
            self.ch_a,
            self.ch_b,
            self.sync_in,
            self.arm,
            self.ce,
            self.tx_data,
            self.tx_valid,
            self.tx_eof,
        ]

    def elaborate(self, _) -> Module:
        m = Module()
        # Add the FIFO as a submodule
        m.submodules.fifo = fifo = SyncFIFOBuffered(
            width=WORD_SIZE, depth=self.n_words + 3
        )
        # Only do anything if the clock is enabled
        with m.If(self.ce):
            # State transitions
            with m.If(self.arm):
                m.d.sync += self.state.eq(PacketizerState.WaitSync)
            with m.If(self.sync_in):
                with m.If(self.state == PacketizerState.WaitSync):
                    m.d.sync += self.state.eq(PacketizerState.Running)
                    m.d.comb += fifo.w_data.eq(self.payloads)
                    m.d.comb += fifo.w_en.eq(1)
            # Perform actual functionality when we're running
            with m.If(self.state == PacketizerState.Running):
                # Every cycle needs the concated inputs
                packed_inputs = Cat(self.ch_b, self.ch_a)
                # On LSB word, save the concat result for the next cycle
                with m.If(~self.high_bit):
                    m.d.sync += self.last_inputs.eq(packed_inputs)
                    m.d.sync += self.high_bit.eq(~self.high_bit)
                    # If the last cycle finished a payload..
                    with m.If(self.words == self.n_words):
                        # Reset the counters
                        m.d.sync += self.words.eq(0)
                        # Increment the payload counter
                        new_payload = self.payloads + 1
                        m.d.sync += self.payloads.eq(new_payload)
                        # Push the new header
                        m.d.comb += fifo.w_data.eq(new_payload)
                        m.d.comb += fifo.w_en.eq(1)
                        # Start draining the FIFO
                        m.d.sync += self.fifo_state.eq(FIFOState.Draining)
                        m.d.sync += fifo.r_en.eq(1)
                # On the MSB word..
                with m.Else():
                    # Push the word
                    m.d.comb += fifo.w_data.eq(Cat(self.last_inputs, packed_inputs))
                    m.d.comb += fifo.w_en.eq(1)
                    # Increment the word counter
                    m.d.sync += self.words.eq(self.words + 1)
                    # Update the state
                    m.d.sync += self.high_bit.eq(~self.high_bit)
                # FIFO State transitions
                with m.If(self.fifo_state == FIFOState.Draining):
                    # Connect the outputs
                    m.d.sync += fifo.r_en.eq(1)
                    m.d.sync += self.tx_valid.eq(1)
                    m.d.sync += self.tx_data.eq(fifo.r_data)
                    # Start counting how many words we've drained
                    m.d.sync += self.drain_count.eq(self.drain_count + 1)
                    # We need to drain exactly n_words + 1 (for the header)
                    with m.If(self.drain_count == self.n_words - 1):
                        m.d.sync += self.fifo_state.eq(FIFOState.EOF)
                with m.Elif(self.fifo_state == FIFOState.EOF):
                    # Last words
                    m.d.sync += fifo.r_en.eq(0)
                    m.d.sync += self.tx_valid.eq(1)
                    m.d.sync += self.tx_eof.eq(1)
                    m.d.sync += self.tx_data.eq(fifo.r_data)
                    # Reset the counter
                    m.d.sync += self.drain_count.eq(0)
                    # Back to just loading
                    m.d.sync += self.fifo_state.eq(FIFOState.Loading)
                # Zero the output otherwise
                with m.Else():
                    m.d.sync += self.tx_eof.eq(0)
                    m.d.sync += self.tx_valid.eq(0)
                    m.d.sync += self.tx_data.eq(0)
        # Return the total module
        return m

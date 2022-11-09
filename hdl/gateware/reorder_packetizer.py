"""A reordering packetizer for GReX with error checking.

This design creates UDP payloads that have un-shuffled, sequential channel data.
The benefit of this design is that the channels are in canonical order for preprocessing
on the server, eliminating the need for separate reordering steps. To accomplish this, we
will use two FIFOs, one for each polarization. Once they are full, we will drain one,
concatinating subsequent channel pairs, then drain the other.
"""

from enum import Enum
from typing import List
from amaranth import *
from amaranth.lib.fifo import SyncFIFOBuffered


class State(Enum):
    WaitArm = 0
    WaitSync = 1
    Running = 2


class FIFOState(Enum):
    Loading = 0
    Draining = 1
    EOF = 2


INPUT_SIZE = 16
WORD_SIZE = 64
INPUTS_PER_WORD = WORD_SIZE // INPUT_SIZE


# Make a module that takes n samples of 16-bit data and outputs 64 bit packed words
class PackPol(Elaboratable):
    def __init__(self, n_channels: int):
        assert (
            n_channels % INPUTS_PER_WORD == 0
        ), f"The number of channels must be a multiple of {INPUTS_PER_WORD}"
        self.pol_in = Signal(INPUT_SIZE)
        self.packed = Signal(WORD_SIZE)
        self.valid = Signal()
        self.sync_in = Signal()
        self.sync_out = Signal()
        self.ce = Signal()
        self.arm = Signal()
        self.state = Signal(State)
        self.n_words = n_words = n_channels // INPUTS_PER_WORD
        self.word_buffer = Signal(WORD_SIZE)
        self.current_input = Signal(range(n_words))
        self.sync_done = Signal()
        self.not_first = Signal()

    def ports(self) -> List[Signal]:
        return [
            self.pol_in,
            self.packed,
            self.sync_in,
            self.sync_out,
            self.ce,
            self.arm,
        ]

    def elaborate(self, _):
        m = Module()
        with m.If(self.ce):
            with m.If(self.arm):
                m.d.sync += self.state.eq(State.WaitSync)
            with m.If(self.sync_in):
                with m.If(self.state == State.WaitSync):
                    m.d.sync += self.state.eq(State.Running)
            with m.If(self.state == State.Running):
                with m.If(~self.not_first):
                    m.d.sync += self.not_first.eq(1)

                with m.If(self.not_first):
                    with m.If(self.current_input % INPUTS_PER_WORD == 0):
                        m.d.sync += self.packed.eq(self.word_buffer)
                        m.d.sync += self.valid.eq(1)
                        with m.If(~self.sync_done):
                            m.d.comb += self.sync_out.eq(1)
                            m.d.sync += self.sync_done.eq(1)
                    with m.Else():
                        m.d.sync += self.packed.eq(0)
                        m.d.sync += self.valid.eq(0)


                m.d.sync += self.word_buffer.eq(
                    self.word_buffer | (self.pol_in << (self.current_input * INPUT_SIZE))
                )
                m.d.sync += self.current_input.eq(
                    (self.current_input + 1) % INPUTS_PER_WORD
                )
        return m

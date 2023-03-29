cmake_minimum_required(VERSION 3.26)
project(GReXHDL)
find_package(verilator)
set(VERILATOR_ARGS -O3 -j 0 --x-assign fast --x-initial fast --noassert -Wall -Wno-PINCONNECTEMPTY)

add_executable(Vpacketizer tests/sim_packetizer.cpp)
verilate(Vpacketizer 
    SOURCES src/packetizer.sv src/fifo.sv
    PREFIX Vpacketizer
    TRACE THREADS)

add_executable(Vfifo tests/sim_fifo.cpp)
verilate(Vfifo 
    SOURCES src/fifo.sv
    TRACE THREADS)
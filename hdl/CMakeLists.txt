cmake_minimum_required(VERSION 3.25)
project(GReXHDL)
find_package(verilator)
set(VERILATOR_ARGS -O3 -j 4 --x-assign fast --x-initial fast --noassert -Wno-PINCONNECTEMPTY)

add_executable(Vpacketizer tests/sim_packetizer.cpp)
verilate(Vpacketizer 
    SOURCES src/packetizer.sv src/fifo.sv
    PREFIX Vpacketizer
    TRACE THREADS)

add_executable(Vfifo tests/sim_fifo.cpp)
verilate(Vfifo 
    SOURCES src/fifo.sv
    TRACE THREADS)

add_executable(Vrequant tests/sim_requant.cpp)
verilate(Vrequant 
    SOURCES src/requant.sv
    TRACE THREADS)

add_executable(Vvacc tests/sim_vacc.cpp)
verilate(Vvacc 
    SOURCES src/vacc.sv src/dpram.sv
    PREFIX Vvacc
    TRACE THREADS)
# RISCV Single Cycle Core Implementation

This project showcases the design and implementation of RISC-V Single Cycle Core processor using Verilog HDL.The schematic has been designed using Vivado 2025.1 as well as QUestasim 10.7c while the simulation has performed using Siemens Questasim 10.7c

It is based on the RV32I Base Integer Instruction Set Architecture. In a Single-cycle Microarchitecure, the processor executes an complete instruction in one clock cycle.The time period of this clock cycle is determined by the slowest instruction and this limits the maximum clock frequency.

## Architecture & Features

- ISA Supported: RV32I (Base 32-bit Integer)
- Word Size: 32 bits
- Memory Architecture: Harvard Architecture (Separate Instruction and Data memories)
- Register File: 32 x 32-bit general-purpose registers (Register x0 is hardwired to zero).

## Instructions Supported 

The single-cycle core processor supports 4 types of RISCV Instruction formats: 
- R-Type (Register-Register): add, sub, and, or
- I-Type (Register-Immediate): lw(Load Word), it does not support any I-type ALU instructions like addi, andi, ori as of now.
- S-Type (Store): sw(Store Word)
- B-Type (Branch) : beq 

## Datapath Components:


  
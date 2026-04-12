`include "PC.v"
`include "Instruction_Memory.v"
`include "Register_File.v"
`include "Control_Unit.v"
`include "Sign_Extend.v"
`include "ALU.v"
`include "Data_Memory.v"
`include "PC_Adder.v"
`include "Mux_2to1.v"

module Single_Cycle_Top(
    input clk, rst
);

    wire [31:0]PC_wire, PCNext_wire, PCPlus4_wire, PCTarget_wire, Instr_wire, RD1_wire, RD2_wire, Imm_Ext_wire, SrcB_wire, ALUResult_wire, ReadData_wire, Result_wire;
    wire Zero_wire, Carry_wire, Overflow_wire, Negative_wire, RegWrite_wire, MemWrite_wire, ALUSrc_wire, ResultSrc_wire, PCSrc_wire; 
    wire [1:0] ImmSrc_wire;
    wire [2:0] ALUControl_wire;


    Mux_2to1 Mux_PCPlus4_to_PC(
        .a(PCPlus4_wire), 
        .b(PCTarget_wire),
        .sel(PCSrc_wire),
        .y(PCNext_wire)
    );

    PC PC(
        .clk(clk), 
        .rst(rst),
        .PC_Next(PCNext_wire),
        .PC(PC_wire)
    );

    Instruction_Memory Instruction_Memory(
        .rst(rst),
        .A(PC_wire),
        .RD(Instr_wire) 
    );

    PC_Adder PCPlus4(
        .a(PC_wire), 
        .b(32'h0000_0004),
        .c(PCPlus4_wire)
    );

    Control_Unit Control_Unit(
        .Op(Instr_wire[6:0]), 
        .funct7(Instr_wire[31:25]),
        .funct3(Instr_wire[14:12]),
        .Zero(Zero_wire), 
        .RegWrite(RegWrite_wire), 
        .MemWrite(MemWrite_wire), 
        .ALUSrc(ALUSrc_wire), 
        .ResultSrc(ResultSrc_wire), 
        .PCSrc(PCSrc_wire),
        .ImmSrc(ImmSrc_wire),
        .ALUControl(ALUControl_wire)
    );

    Register_File Register_File(
        .clk(clk), 
        .rst(rst), 
        .WE3(RegWrite_wire),  
        .A1(Instr_wire[19:15]), 
        .A2(Instr_wire[24:20]), 
        .A3(Instr_wire[11:7]),
        .WD3(Result_wire),
        .RD1(RD1_wire), 
        .RD2(RD2_wire)
    );

    Sign_Extend Sign_Extend(
        .Instr(Instr_wire),
        .ImmSrc(ImmSrc_wire[0]), //we use only the 0th bit
        .Imm_Ext(Imm_Ext_wire)
    );

    Mux_2to1 Mux_RegFile_to_ALU(
        .a(RD2_wire), 
        .b(Imm_Ext_wire),
        .sel(ALUSrc_wire),
        .y(SrcB_wire)
    );

    ALU ALU(
        .SrcA(RD1_wire), 
        .SrcB(SrcB_wire),
        .ALUControl(ALUControl_wire),
	    .Carry(Carry_wire), 
        .Overflow(Overflow_wire), 
        .Zero(Zero_wire), 
        .Negative(Negative_wire), 
	    .result(ALUResult_wire)
    );

    PC_Adder PCTarget(
        .a(PC_wire), 
        .b(Imm_Ext_wire),
        .c(PCTarget_wire)
    );

    Data_Memory Data_Memory(
        .clk(clk), 
        .rst(rst), 
        .WE(MemWrite_wire),
        .A(ALUResult_wire), 
        .WD(RD2_wire), 
        .RD(ReadData_wire)
    );

    Mux_2to1 Mux_Data_Mem_to_RegFile(
        .a(ALUResult_wire), 
        .b(ReadData_wire),
        .sel(ResultSrc_wire),
        .y(Result_wire)
    );
   
endmodule
`include "Main_Decoder.v"
`include "ALU_Decoder.v"

module Control_Unit(
    input [6:0] Op, funct7,
    input [2:0] funct3,
    input Zero, 

    output RegWrite, MemWrite, ALUSrc, ResultSrc, PCSrc,
    output [1:0] ImmSrc,
    output [2:0] ALUControl
);

    wire [1:0] ALUOp;

    Main_Decoder Main_Decoder(
        .op(Op),
        .zero(Zero),
        .RegWrite(RegWrite),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc), 
        .ResultSrc(ResultSrc), 
        .PCSrc(PCSrc),
        .ImmSrc(ImmSrc), 
        .ALUOp(ALUOp) 
    );

    ALU_Decoder ALU_Decoder(
        .ALUOp(ALUOp),
        .funct3(funct3),
        .funct7(funct7), 
        .op(Op),
        .ALUControl(ALUControl)
    );
    
endmodule
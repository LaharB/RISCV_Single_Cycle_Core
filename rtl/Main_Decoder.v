module Main_Decoder(
    input [6:0] op,
    input zero,
    output RegWrite, MemWrite, ALUSrc, ResultSrc, PCSrc,
    output [1:0] ImmSrc, ALUOp    
    );
    
    wire Branch;

    /*
    -- Main decoder has been designed for 4 types of instructions : lw , sw , R-type and beq
    i.e one of each I-type, S-type, R-type and B-type is demonstrated

    -- Note: We have assumed "dont care" values as 0 for simplicity
    // =============================================================================================
    // Main Control Unit Truth Table
    // =============================================================================================
    // Instruction |    Op     | RegWrite | ImmSrc | ALUSrc | MemWrite | ResultSrc | Branch | ALUOp
    // ------------|-----------|----------|--------|--------|----------|-----------|--------|-------
    // lw          | 0000011   |    1     |   00   |   1    |    0     |     1     |   0    |  00
    // sw          | 0100011   |    0     |   01   |   1    |    1     |     x     |   0    |  00
    // R-type      | 0110011   |    1     |   xx   |   0    |    0     |     0     |   0    |  10
    // beq         | 1100011   |    0     |   10   |   0    |    0     |     x     |   1    |  01
    // =============================================================================================
    */
    assign RegWrite = ((op == 7'b0000011) || (op == 7'b0110011)) ? 1'b1 : 1'b0;
    assign ImmSrc = (op == 7'b0100011) ? 2'b01 : (op == 7'b1100011) ? 2'b10 : 2'b00;
    assign ALUSrc = ((op == 7'b0000011) || (op == 7'b0100011)) ? 1'b1 : 1'b0;
    assign MemWrite = (op == 7'b0100011) ? 1'b1 : 1'b0;
    assign ResultSrc = (op == 7'b0000011) ? 1'b1 : 1'b0;
    assign Branch = (op == 7'b1100011) ? 1'b1 : 1'b0;
    assign ALUOp = (op == 7'b0110011) ? 2'b10 : (op == 7'b1100011) ? 2'b01 : 2'b00;

    assign PCSrc = zero & Branch;
  
endmodule
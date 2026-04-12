module ALU_Decoder(
    input [1:0] ALUOp,
    input [2:0] funct3,
    input [6:0] funct7, op, //we will use only op[5] and funct7[5]
    output reg [2:0] ALUControl
    );  
    // =============================================================================================
    // ALU Control Unit Truth Table
    // =============================================================================================
    // ALUOp | funct3 | {op5, funct7_5} | ALUControl          | Instruction
    // ------|--------|-----------------|---------------------|------------
    //   00  |   x    |        x        | 000 (add)           | lw, sw
    //   01  |   x    |        x        | 001 (subtract)      | beq
    //   10  |  000   |   00, 01, 10    | 000 (add)           | add
    //   10  |  000   |       11        | 001 (subtract)      | sub
    //   10  |  010   |        x        | 101 (set less than) | slt
    //   10  |  110   |        x        | 011 (or)            | or
    //   10  |  111   |        x        | 010 (and)           | and
    // =============================================================================================

always@(*)
    begin
        case(ALUOp) 
            2'b00 : ALUControl = 3'b000; //lw, sw
            2'b01 : ALUControl = 3'b001; //beq 
            2'b10 : begin
                case(funct3)
                    3'b000: begin
                        case({op[5], funct7[5]})
                            2'b00, 2'b01, 2'b10 : ALUControl = 3'b000; //add
                            //2'b01 : ALUControl = 3'b000; //add
                            //2'b10 : ALUControl = 3'b000; //add
                            2'b11 : ALUControl = 3'b001; //subtract
                        endcase
                    end
                    3'b010 : ALUControl = 3'b101; //slt
                    3'b110 : ALUControl = 3'b011; //or
                    3'b111 : ALUControl = 3'b010; //and
                endcase 
            end
            default : ALUControl = 3'b000;

        endcase
    end
    
endmodule
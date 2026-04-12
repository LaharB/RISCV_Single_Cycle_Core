module Sign_Extend(
    input [31:0] Instr,
    input ImmSrc,
    output [31:0] Imm_Ext
);
    
    //ImmSrc = 1, extension for S-type else I-type
    assign Imm_Ext = (ImmSrc == 1'b1)? ({{20{Instr[31]}},Instr[31:25],Instr[11:7]}) : {{20{Instr[31]}},Instr[31:20]} ;


endmodule
module Register_File(
    input clk, rst, WE3,  

    //A1 and A2 to read from register file and A3 to write into it
    input [4:0] A1, A2, A3,

    //write port for data coming from write-back
    input [31:0] WD3,

    //read ports
    output [31:0] RD1, RD2
);

    //making the 32-bit 32 Registers
    reg [31:0] Registers [0:31];

    //read 
    assign RD1 = (!rst) ? 32'h0000_0000 : Registers[A1];
    assign RD2 = (!rst) ? 32'h0000_0000 : Registers[A2];

    //write
    always@(posedge clk)
        begin
            if(WE3)
                 Registers[A3] <= WD3;
        end

    //manually putting random values inside registers for A1 and A2 location since we have not implemeted ADDI functionality
    initial begin
        Registers[5] = 32'h0000_0015; //A1 = 5 , put 5 in it
        Registers[9] = 32'h0000_0040;  //A2 = 6, put 4 in it
    end

    
    
endmodule
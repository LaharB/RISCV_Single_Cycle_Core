module Data_Memory(
    input clk, rst, WE,
    input [31:0] A, WD, //32-bit address and data
    output [31:0] RD
);

    //data memory
    reg [31:0] mem [0:1023];

    always@(posedge clk)
        begin
            mem[A] <= WD;
        end
    
    //async READ as we dont want value in location to get overwritten by WRITE before getting READ
    assign RD = (!rst) ? 32'h0000_0000:mem[A];

    //putting values inside memory locations manually as we dont have ADDI functionality
    // initial begin
    //     mem[28] = 32'h0000_0020;     
    //     //mem[40] = 32'h0000_0002;
    // end
    
endmodule
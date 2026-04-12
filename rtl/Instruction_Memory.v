module Instruction_Memory(
    input rst,
    input [31:0] A, //input address port
    output [31:0] RD //31-bit read port 
);
    //instrcution memory of 1024 cells of 32-bits word size
    reg [31:0]mem[0:1023]; 

    /*
    While the RISC-V Instruction Set Architecture (ISA) mandates a byte-addressable memory space, 
    hardware designers frequently model the instruction memory as 
    an array of 32-bit words for simplicity (e.g., reg [31:0] instr_mem [0:1023];).

    To bridge the gap between the byte-addressable PC 
    and the word-addressable hardware array, 
    the lower two bits of the PC (PC[1:0]) are typically ignored or truncated.
    Because instructions are 32-bit aligned, those bottom two bits will always be 00. 
    We simply use PC[31:2] as the index to access the 32-bit wide memory array.
    */

    //active low reset
    assign RD = (!rst) ? {32{1'b0}} : mem[A[31:2]]; //instruction memory is byte addressable hence PC value is always increment by 4 i.e 3'b100 so ignore bits of the address value A[1:0]

    /*
    initial begin
        $readmemh("memfile.hex", mem);
    end
    */

    //loading instructions at specific addresses manually
    initial begin
        //mem[0] = 32'hFFC4A303;
        //mem[1] = 32'h00832383;
        mem[0] = 32'hFE54AE23; // sw x5, -4(x9)
        mem[1] = 32'hFFC4A303; // sw x5, -4(x9)
        //mem[0] = 32'h0062E233;
        //mem[1] = 32'h00B62423;


    end
    
endmodule
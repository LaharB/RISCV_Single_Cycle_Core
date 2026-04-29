`timescale 1ns/1ps

`include "../rtl/Single_Cycle_top.v"

module tb();

    reg clk, rst;

    Single_Cycle_Top DUT(
        .clk(clk),
        .rst(rst)
    );

    initial begin
        clk = 1'b0;
    end

    always #50 clk = ~clk;

    initial begin
        rst = 1'b0;
        #200;
        rst = 1'b1;
        #500;
        $finish;
    end

    // initial begin
    //     $dumpfile("dump.vcd");
    //     $dumpvars;
    // end
    
endmodule
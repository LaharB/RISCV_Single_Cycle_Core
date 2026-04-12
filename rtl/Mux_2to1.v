module Mux_2to1(
    input [31:0] a, b,
    input sel,
    output [31:0] y 
    
);

    assign y = (!sel) ? a : b; 
    
endmodule
module ALU(
	input [31:0] SrcA, SrcB,
	input [2:0] ALUControl, //control signal 
	output Carry, Overflow, Zero, Negative, //Flags
	output reg [31:0] result
	);

wire cout;
wire [31:0]sum;

//according to ALUControl[0] value , add if 0 and sub if 1
assign {cout, sum} = (ALUControl[0] == 1'b0) ? SrcA + SrcB : (SrcA + ((~SrcB) + 1)); // a - b = a + (-b) , -b = 2s comp of b  

//result 
always@(*)
    begin
        case(ALUControl)
	       3'b000 : result = sum; //addition
	       3'b001 : result = sum; //sub 
	       3'b010 : result = SrcA & SrcB; //AND
	       3'b011 : result = SrcA | SrcB; //OR
           3'b101 : result = { {31{1'b0}}, sum[31] }; //zero extension

	       default : result = 32'h0000; 
        endcase
    end

//overflow flag 
assign Overflow = ( (sum[31] ^ SrcA[31]) & (~(ALUControl[0] ^ SrcB[31] ^ SrcA[31])) & (~ALUControl[1]) );
//carry flag
assign Carry = ((~ALUControl[1]) & cout);
//zero flag
assign Zero = &(~result);
//negative
assign Negative = result[31]; //sign bit 

endmodule 
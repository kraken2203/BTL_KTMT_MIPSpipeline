/*
 *		Thiet ke MIPS pipeline
 *		author: Nguyen Van Cao
 */
module SignEx(input [15:0]X, 
					output [31:0]Y); 
//Sign Extend 
//Transform 16 bit signed number to 32 bit signed number 
assign Y = {{16{X[15]}},X}; 
endmodule 
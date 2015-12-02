/*
 *		Thiet ke MIPS pipeline
 *		author: Nguyen Van Cao
 */
module MUX4_1#(parameter N = 32)(M0, M1, M2, M3, S, Y); 
input [N-1:0] M0, M1, M2, M3; 
input [1:0] S; 
output [N-1:0] Y; 
//Multiplexer 4 to 1, used in ALU
// S = 0 => Y = M0; 
// S = 1 => Y = M1; 
// S = 2 => Y = M2; 
// S = 3 => Y = M3; 
wire [N-1:0] A0, A1; 
assign A0 = S[0]?M1:M0; 
assign A1 = S[0]?M3:M2; 
assign Y = S[1]?A1:A0; 
endmodule 
module ALU #(parameter N = 32) (A, B, F, Y, ZF);
//General ALU block 
//Using F[2:0] as control signal 
//Function: Add, Subtract, AND, OR, SLT 
//Ref: Digital design & Computer Architecture p.243
input 	[N-1:0] A,B ;
input [2:0]F; 
output [N-1:0] Y;
output ZF;
wire [N-1:0] BB; 
wire [N-1:0] M0, M1, M2, M3; 
wire C_in; 

assign C_in = F[2]; 
assign BB = F[2]? ~B:B;
assign M0 = A&BB; 
assign M1 = A | BB; 
assign M2 = A + BB + C_in; 
assign M3 = {30'b0, M2[31]}; 

assign ZF = (Y==0)? 1'b1 : 1'b0;
MUX4_1 mux(M0, M1, M2, M3, F[1:0], Y); 
endmodule 


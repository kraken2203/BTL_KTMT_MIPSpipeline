module shift2left(input [31:0]X, 
						output [31:0]Y); 
//Shift left 2 (multiply 4)
assign Y = {X[29:0],2'b0}; 
endmodule 
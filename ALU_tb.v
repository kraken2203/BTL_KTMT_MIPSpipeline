`timescale 10ns/1ns 
module ALU_tb(); 
  reg [2:0] F; 
  reg [31:0] A, B; 
  wire [31:0] Y; 
  wire ZF; 

ALU DUT(.F(F), .A(A), .B(B), .Y(Y), .ZF(ZF)); 
initial begin
A = 100; 
B = 200; 
F = 3'b0; 
#5 F = 3'b001; 
#5 F = 3'b010; 
#5 F = 3'b100; 
#5 F = 3'b101; 
#5 F = 3'b110; 
#5 F = 3'b111; 
end 
endmodule 
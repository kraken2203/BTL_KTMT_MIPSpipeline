`timescale 10ns/1ns 
module ALUDec_tb(); 
  reg [5:0] Funct; 
  reg [1:0] ALUOp; 
  wire [2:0] ALUCtrl;  

ALUDec ALUDecoder(.Funct(Funct), .ALUOp(ALUOp), .ALUCtrl(ALUCtrl)); 
initial begin
ALUOp = 0; 
Funct = 6'b101010; 
#5 Funct = 6'b100101; 
#5 ALUOp = 1;  
Funct = 6'b101010; 
#5 Funct = 6'b100101; 
#5ALUOp = 2; 
Funct = 6'b100000; 
#5 Funct = 6'b100010; 
#5 Funct = 6'b100100; 
#5 Funct = 6'b100101; 
#5 Funct = 6'b101010; 
#5ALUOp = 3; 
Funct = 6'b100000; 
#5 Funct = 6'b100010; 
#5 Funct = 6'b100100; 
#5 Funct = 6'b100101; 
#5 Funct = 6'b101010; 
end 
endmodule
//Pipeline Control Unit
module CU(	input [5:0] Opcode, Funct, 
				output MemtoReg, MemWrite, Branch, ALUSrc, RegDst, RegWrite, 
				output [2:0] ALUCtrl); 
wire [1:0] ALUOp; 
//Use MainDec.v & ALUDec.v
//Input Opcode, Funct 
//Output control signal to ALU, Register file, Memory, Multiplexers...
//Ref: Digital design & Computer Architecture p.374 
MainDec MainDecoder(.Op(Opcode), .MemtoReg(MemtoReg), .MemWrite(MemWrite),
						.Branch(Branch), .ALUSrc(ALUSrc), .RegDst(RegDst), .RegWrite(RegWrite), .ALUOp(ALUOp)); 
ALUDec ALUDecoder(.Funct(Funct), .ALUOp(ALUOp), .ALUCtrl(ALUCtrl));
endmodule 
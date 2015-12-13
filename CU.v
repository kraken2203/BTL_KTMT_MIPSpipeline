/*
 *		Thiet ke MIPS pipeline
 *		author: Nguyen Van Cao
 */
//Pipeline Control Unit
module CU(	input [5:0] Opcode, Funct, 
				output MemtoReg, MemWrite, Branch_beq, Branch_bne, ALUSrc, RegDst, RegWrite,Jump, BranchD, ALUSelectShilfD,
				output [3:0] ALUCtrl); 
wire [2:0] ALUOp; 
//Use MainDec.v & ALUDec.v
//Input Opcode, Funct 
//Output control signal to ALU, Register file, Memory, Multiplexers...
//Ref: Digital design & Computer Architecture p.374 
MainDec MainDecoder(.Op(Opcode), .MemtoReg(MemtoReg), .MemWrite(MemWrite),
						.Branch_beq(Branch_beq), .Branch_bne(Branch_bne), .ALUSrc(ALUSrc), .RegDst(RegDst), .RegWrite(RegWrite), .ALUOp(ALUOp), .Jump(Jump)); 
assign BranchD = Branch_beq | Branch_bne;
ALUDec ALUDecoder(.Funct(Funct), .ALUOp(ALUOp), .ALUCtrl(ALUCtrl), .ALUSelectShilfD(ALUSelectShilfD));
endmodule 
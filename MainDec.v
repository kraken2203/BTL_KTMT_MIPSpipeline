module MainDec(input [5:0]Op, 
					output reg MemtoReg, 
					output reg MemWrite, 
					output reg Branch, 
					output reg ALUSrc, 
					output reg RegDst, 
					output reg RegWrite, 
					output reg [1:0]ALUOp); 
always @(*) 
//Main Decoder in Control Unit 
//Generate control signal for Register file, Memory, Multiplexers
//Ref: Digital design & Computer Architecture, p. 376 
case(Op)
6'b00_0000: {RegWrite, RegDst, ALUSrc, Branch, MemWrite, MemtoReg, ALUOp[1:0]} = 8'b1100_0010; 	//R-type
6'b10_0011: {RegWrite, RegDst, ALUSrc, Branch, MemWrite, MemtoReg, ALUOp[1:0]} = 8'b1010_0100; 	//lw
6'b10_1011: {RegWrite, RegDst, ALUSrc, Branch, MemWrite, MemtoReg, ALUOp[1:0]} = 8'b0x10_1x00; 	//sw
6'b00_0100: {RegWrite, RegDst, ALUSrc, Branch, MemWrite, MemtoReg, ALUOp[1:0]} = 8'b0x01_0x01; 	//beq
6'b00_1000:	{RegWrite, RegDst, ALUSrc, Branch, MemWrite, MemtoReg, ALUOp[1:0]} = 8'b1010_0000; 	//addi
default: {RegWrite, RegDst, ALUSrc, Branch, MemWrite, MemtoReg, ALUOp[1:0]} = 8'b1100_0010;
endcase
endmodule 
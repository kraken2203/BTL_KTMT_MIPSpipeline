/*
 *		Thiet ke MIPS pipeline
 *		author: Nguyen Van Cao
 */
module MainDec(input [5:0]Op, 
					output MemtoReg, 
					output MemWrite, 
					output Branch_beq, 
					output Branch_bne,
					output ALUSrc, 
					output RegDst, 
					output RegWrite, 
					output [2:0]ALUOp,
					output Jump); 
//Main Decoder in Control Unit 
//Generate control signal for Register file, Memory, Multiplexers
//Ref: Digital design & Computer Architecture, p. 376 
reg [10:0]control;
assign {RegWrite, RegDst, ALUSrc, Branch_beq, Branch_bne,MemWrite, MemtoReg, ALUOp[2:0],Jump} = control;
always @(*)
	case(Op)
		6'b00_0000: control = 11'b110_0000_0100; 	//R-type
		6'b10_0011: control = 11'b101_0001_0000; 	//lw
		6'b10_1011: control = 11'b001_0010_0000; 	//sw
		6'b00_0100: control = 11'b000_1000_0000; 	//beq
		6'b00_0101: control = 11'b000_0100_0000; 	//bne
		6'b00_1000:	control = 11'b101_0000_0000; 	//addi
		6'b00_1100:	control = 11'b101_0000_0110; 	//andi
		6'b00_1101:	control = 11'b101_0000_1000; 	//ori
		6'b00_0010:	control = 11'b000_0000_0001; 	//jump
		default: control = 11'bx;
	endcase
endmodule 
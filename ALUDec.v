/*
 *		Thiet ke MIPS pipeline
 *		author: Nguyen Van Cao
 */
module ALUDec(input [5:0] Funct, 
					input [2:0] ALUOp, 
					output reg [3:0] ALUCtrl); 
// ALU Decoder in Control Unit
// Generate control signal for ALU
always @(ALUOp, Funct) 
  begin
    case (ALUOp)
      //aluOp: out   aluSrc1_jr_aluControl
      3'b000 : ALUCtrl <= 4'b0010; // add
      3'b001 : ALUCtrl <= 4'b0110; // subtract
      3'b011 : ALUCtrl <= 4'b0000; // and
      3'b100 : ALUCtrl <= 4'b0001; // or
      3'b101 : ALUCtrl <= 4'b0011; // xor
      3'b110 : ALUCtrl <= 4'b0100; // nor
      3'b111 : ALUCtrl <= 4'b0111; // slt
      3'b010 : case (Funct)       // R-type instructions
                  6'b100000 : ALUCtrl <= 4'b0010;  // add
                  6'b100010 : ALUCtrl <= 4'b0110;  // subtract
                  6'b100100 : ALUCtrl <= 4'b0000;  // and
                  6'b100101 : ALUCtrl <= 4'b0001;  // or
                  6'b100110 : ALUCtrl <= 4'b0011;  // xor
                  6'b100111 : ALUCtrl <= 4'b0100;  // nor
                  6'b101010 : ALUCtrl <= 4'b0111;  // slt
                  6'b000000 : ALUCtrl <= 4'b1000;  // sll
                  6'b000010 : ALUCtrl <= 4'b1001;  // srl
                  6'b000011 : ALUCtrl <= 4'b1010;  // sra
                  //6'b001000 : ALUCtrl <= 4'b0010;  // jr
                  default   : ALUCtrl <= 4'bxxxx;
                endcase // end case(Funct)
    endcase // end case(ALUOp)
  end // end always
endmodule 
/*
 *		Thiet ke MIPS pipeline
 *		author: Nguyen Van Cao
 */
module ALUDec(input [5:0] Funct, 
					input [2:0] ALUOp, 
					output ALUSelectShilfD,
					output [3:0] ALUCtrl); 
// ALU Decoder in Control Unit
// Generate control signal for ALU
reg [4:0]out;
assign {ALUSelectShilfD, ALUCtrl} = out;
always @(ALUOp, Funct) 
  begin
    case (ALUOp)
      //aluOp: out   aluSrc1_jr_aluControl
      3'b000 : out <= 5'b00010; // add
      3'b001 : out <= 5'b00110; // subtract
      3'b011 : out <= 5'b00000; // and
      3'b100 : out <= 5'b00001; // or
      3'b101 : out <= 5'b00011; // xor
      3'b110 : out <= 5'b00100; // nor
      3'b111 : out <= 5'b00111; // slt
      3'b010 : case (Funct)       // R-type instructions
                  6'b100000 : out <= 5'b00010;  // add
                  6'b100010 : out <= 5'b00110;  // subtract
                  6'b100100 : out <= 5'b00000;  // and
                  6'b100101 : out <= 5'b00001;  // or
                  6'b100110 : out <= 5'b00011;  // xor
                  6'b100111 : out <= 5'b00100;  // nor
                  6'b101010 : out <= 5'b00111;  // slt
                  6'b000000 : out <= 5'b11000;  // sll
                  6'b000010 : out <= 5'b11001;  // srl
                  6'b000011 : out <= 5'b11010;  // sra
                  //6'b001000 : ALUCtrl <= 4'b0010;  // jr
                  default   : out <= 5'bxxxx;
                endcase // end case(Funct)
    endcase // end case(ALUOp)
  end // end always
endmodule 
module ALUDec(input [5:0] Funct, 
					input [1:0] ALUOp, 
					output reg [2:0] ALUCtrl); 
// ALU Decoder in Control Unit 
// Generate control signal for ALU
// Ref: Digital design & Computer Architecture p.376
always@(*) 
begin 
case(ALUOp) 
2'b00: ALUCtrl = 3'b010; 
2'b01: ALUCtrl = 3'b110; 
//2'b10: begin 
//	case(Funct)
//	6'b10_0000: ALUCtrl = 3'b010; 
//	6'b10_0010: ALUCtrl = 3'b110; 
//	6'b10_0100: ALUCtrl = 3'b000; 
//	6'b10_0101: ALUCtrl = 3'b001; 
//	6'b10_1010: ALUCtrl = 3'b111; 
//	default: ALUCtrl = 3'b010;
//	endcase
//end 
default:  begin 
	case(Funct)
	6'b10_0000: ALUCtrl = 3'b010; 
	6'b10_0010: ALUCtrl = 3'b110; 
	6'b10_0100: ALUCtrl = 3'b000; 
	6'b10_0101: ALUCtrl = 3'b001; 
	6'b10_1010: ALUCtrl = 3'b111; 
	default: ALUCtrl = 3'b010;
	endcase
	end
endcase
end 
endmodule 
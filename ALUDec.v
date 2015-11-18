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
	default:  
		begin 
			case(Funct)
			6'b10_0000: ALUCtrl = 3'b010; //signal for add
			6'b10_0010: ALUCtrl = 3'b110; //signal for sub
			6'b10_0100: ALUCtrl = 3'b000; //signal for and
			6'b10_0101: ALUCtrl = 3'b001; //signal for or
			6'b10_1010: ALUCtrl = 3'b111; //signal for set on less than
			default: ALUCtrl = 3'b010;
			endcase
		end
	endcase
end 
endmodule 
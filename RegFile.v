/*
 *		Thiet ke MIPS pipeline
 *		author: Nguyen Van Cao
 */
module RegFile(input [4:0]RA1, RA2, WA, 
					input WE, clk, rst,
					input [31:0]WD, 
					output [31:0] RD1, RD2
					); 
// Register File
// Contain 32 Register 32 bit 
// Ref: Digital design & Computer Architecture p.406 

reg [31:0]Registers[31:0];
integer i;
//	Write in posedge clk 
always @(negedge clk or negedge rst)
begin 
	if(!rst)
	begin
		for(i = 0; i < 32; i= i +1)
			Registers[i] <= 0; 
	end
	else if	((WA != 5'd0) && WE) 
	begin
	 Registers[WA] <= WD; 
			$display($time,"\tWrite Data: %d -> Register File address = %d",WD, WA);
		end
end
assign RD1 = (RA1!=0)? Registers[RA1]:0; //$0 = 0; 
assign RD2 = (RA2!=0)? Registers[RA2]:0; //$0 = 0;
endmodule 
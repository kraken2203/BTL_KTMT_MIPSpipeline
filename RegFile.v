module RegFile(input [4:0]RA1, RA2, WA, 
					input WE, clk, rst,
					input [31:0]WD, 
					output [31:0] RD1, RD2); 
// Register File
// Contain 32 Register 32 bit 
// Ref: Digital design & Computer Architecture p.406 

reg [31:0]Registers[31:0];
integer i;
// Read and write in posedge clk 
always@(posedge clk or negedge rst)
begin 
if(rst == 0)
	for(i = 0; i < 32; i= i +1)
		Registers[i] <= 0; 
else 
if(WE) Registers[WA] <= WD; 
	end
assign RD1 = (RA1!=0)? Registers[RA1]:0; //$0 = 0; 
assign RD2 = (RA2!=0)? Registers[RA2]:0; //$0 = 0;
endmodule 
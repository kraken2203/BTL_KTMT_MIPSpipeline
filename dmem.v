/*
 *		Thiet ke MIPS pipeline
 *		author: Luu Min Tung
 */
module dmem (	input 				clk, we,
					input 	[31:0] 	a, wd,
					output 	[31:0] 	rd);
reg [31:0] RAM[63:0];
assign rd = RAM[a[31:2]]; // word aligned
always @ (posedge clk)
	if (we) 
	begin
		RAM[a[31:2]] <= wd;
		$display($time,"\tWrite into address: %d 	data: %d", a, wd);
	end  
always @ (RAM)
	begin
	    $writememh("DataMem.dat",RAM);
	end   
endmodule
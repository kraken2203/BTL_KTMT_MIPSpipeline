/*
 *		Thiet ke MIPS pipeline
 *		author: Luu Minh Tung
 */
`timescale 1ps/1ps
module testbench;
	reg 			clk,reset_n;
	wire	[31:0]dataaddr,writedata;
	wire 			memwrite;
	wire [31:0]	pc, readdata, instr;
	//DUT
	top DUT(
		.clk(clk),
		.reset_n(reset_n),
		.dataaddr(dataaddr),
		.writedata(writedata),
		.memwrite(memwrite),
		.pc(pc),
		.instr(instr),
		.readdata(readdata)
		);
	//==========SIMULATION============	
	//initialize first
	initial begin
		reset_n = 1'b0; 
		clk = 1'b0;
		#7 reset_n = 1'b1;
	end
	
	//generate clock
	initial begin
		forever #5 clk = ~clk;
	end
	// check results
initial begin
	//$display("=======SIMULATION BEGIN=======");
	//$monitor($time, "\tpc = %d, instruction = %h\n \tdata address = %d, writedata = %h, memwrite = %b",pc, instr, dataaddr, writedata, memwrite);
end
	//End simulation
	initial begin
		#500 
		$finish;
	end
endmodule
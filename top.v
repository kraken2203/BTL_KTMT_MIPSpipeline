/*
 *		Thiet ke MIPS pipeline
 *		author: Luu Minh Tung
 */
module top(
input clk,reset_n,
output [31:0]	dataaddr,writedata,
output memwrite,	//enable signal allow write to data memory
output [31:0]	pc, readdata, instr
);
//wire [31:0]	pc, readdata, instr;
mips MIPS (
	.aluout(dataaddr),
	.clk(clk),
	.instr(instr),
	.memwrite(memwrite),
	.pc(pc),
	.readdata(readdata),
	.reset_n(reset_n),
	.writedata(writedata)
);
imem InstructionMemory(	
	.a(pc[7:2]),
	.rd(instr)
	);
dmem DataMemory(
	.clk(clk), 
	.we(memwrite),
	.a(dataaddr), 
	.wd(writedata),
	.rd(readdata)
	);
endmodule

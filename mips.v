/*
 *		Thiet ke MIPS pipeline
 *		author: Luu Minh Tung
 */
//Mips processor
module mips(
	input clk, reset_n,
	output [31:0] pc,
	input [31:0] instr,
	output memwrite,
	output [31:0] aluout, writedata,
	input [31:0] readdata
);
//Tin hieu trung gian cho khoi Control Unit
wire RegWriteD,MemtoRegD,MemWriteD,ALUSrcD,RegDstD,BranchD;
wire [2:0]ALUCtrlD;
wire [5:0]Opcode,Funct;
//Tin hieu trung gian cho Hazard Unit
wire FlushE, ForwardAD, ForwardBD;
wire [1:0] ForwardAE, ForwardBE;
wire MemtoRegE, MemtoRegM, RegWriteE, RegWriteM, RegWriteW;
wire [4:0] RsD, RtD, RsE, RtE;
wire StallD, StallF;
wire [4:0] WriteRegE, WriteRegM, WriteRegW;

CU ControlUnit (
	.RegWrite(RegWriteD),
	.MemtoReg(MemtoRegD),
	.MemWrite(MemWriteD),
	.ALUCtrl(ALUCtrlD),
	.ALUSrc(ALUSrcD),
	.RegDst(RegDstD),
	.Branch(BranchD),
	.Opcode(Opcode),
	.Funct(Funct)
);

datapath Datapath ( 
	.alucontrold(ALUCtrlD),
	.aluoutmtodm(aluout),
	.alusrcd(ALUSrcD),
	.branchd(BranchD),
	.clk(clk),
	.flushe(FlushE),
	.forwardad(ForwardAD),
	.forwardae(ForwardAE),
	.forwardbd(ForwardBD),
	.forwardbe(ForwardBE),
	.functinstr(Funct),
	.instr(instr),
	.memtoregd(MemtoRegD),
	.memtorege(MemtoRegE),
	.memtoregm(MemtoRegM),
	.memwrited(MemWriteD),
	.opinstr(Opcode),
	.pc(pc),
	.readdatam(readdata),
	.regdstd(RegDstD),
	.regwrited(RegWriteD),
	.regwritee(RegWriteE),
	.regwritem(RegWriteM),
	.regwritewtohz(RegWriteW),
	.reset_n(reset_n),
	.rsd(RsD),
	.rse(RsE),
	.rtd(RtD),
	.rte(RtE),
	.stalld(StallD),
	.stallf(StallF),
	.we_todm(memwrite),
	.writedatamtodm(writedata),
	.writerege(WriteRegE),
	.writeregmtohz(WriteRegM),
	.writeregwtohz(WriteRegW)
);

HazardUnit Hazard(
	.BranchD(BranchD),
	.FlushE(FlushE),
	.ForwardAD(ForwardAD),
	.ForwardAE(ForwardAE),
	.ForwardBD(ForwardBD),
	.ForwardBE(ForwardBE),
	.MemtoRegE(MemtoRegE),
	.MemtoRegM(MemtoRegM),
	.RegWriteE(RegWriteE),
	.RegWriteM(RegWriteM),
	.RegWriteW(RegWriteW),
	.RsD(RsD),
	.RsE(RsE),
	.RtD(RtD),
	.RtE(RtE),
	.StallD(StallD),
	.StallF(StallF),
	.WriteRegE(WriteRegE),
	.WriteRegM(WriteRegM),
	.WriteRegW(WriteRegW)
);
endmodule
/*
 *		Thiet ke MIPS pipeline
 *		author: Luu Minh Tung
 */
module HazardUnit(
ForwardBE,ForwardAE,RegWriteM,RegWriteW,WriteRegM,WriteRegW,RsE,RtE,	//solve RAW
StallF,StallD,FlushE,RsD,RtD,MemtoRegE,										//solve stall 
ForwardAD, ForwardBD,																//solve RAW
BranchD, RegWriteE, WriteRegE, MemtoRegM	//solve stall
);
	input RegWriteM,RegWriteW;
	input [4:0] WriteRegM,WriteRegW;
	input BranchD;
	input [4:0] RsD,RtD;
	input [4:0] RsE,RtE;
	input [4:0]WriteRegE;
	input RegWriteE;
	input MemtoRegE;
	input MemtoRegM;
	output StallF,StallD,FlushE; 
	output ForwardAD, ForwardBD;
	output  reg [1:0]ForwardBE,ForwardAE;
	
	wire lwstall;		//Tin hieu solve hazard (stall) cho lenh lw
	wire brachstall;	//Tin hieu solve hazard (stall) cho re nhanh
	
	//Forward for field Rs	(solve RAW hazard)
	always @(*)
	begin
		if			((RsE != 0) && (RsE == WriteRegM) && RegWriteM) ForwardAE = 2'b10; //Forward from memory stage to execute stage (ALU)
		else if 	((RsE != 0) && (RsE == WriteRegW) && RegWriteW) ForwardAE = 2'b01; //Forward from write back stage to execute stage (ALU)
			  else ForwardAE = 2'b00;
	end
	
	//Forward for field Rt	(solve RAW hazard)
	always @(*)
	begin
		if			((RtE != 0) && (RtE == WriteRegM) && RegWriteM) ForwardBE = 2'b10; //Forward from memory stage to execute stage (ALU)
		else if 	((RtE != 0) && (RtE == WriteRegW) && RegWriteW) ForwardBE = 2'b01; //Forward from write back stage to execute stage (ALU)
			  else ForwardBE = 2'b00;
	end
	
	//Stall detection for lw instruction
	assign lwstall = (((RtE == RsD) || (RtE == RtD)) && MemtoRegE) ;
	
	//Forward form memory stage to decode stage (control hazard - branch instruction)
	assign ForwardAD = ((RsD != 0) && (RsD == WriteRegM) && RegWriteM);
	assign ForwardBD = ((RtD != 0) && (RtD == WriteRegM) && RegWriteM);
	//Stall dectection for branch 
	assign brachstall = 	(BranchD && RegWriteE && ((WriteRegE == RsD) || (WriteRegE == RtD))) || 
								(BranchD && MemtoRegM && ((WriteRegM == RsD) || (WriteRegM == RtD))); 
	//Execute Stall function
	assign StallD = lwstall || brachstall;	
	assign StallF = lwstall || brachstall; 
	assign FlushE = lwstall || brachstall;
	
endmodule

/*
 *		Thiet ke MIPS pipeline
 *		author: Luu Minh Tung
 */
module HazardUnit(
ForwardBE,ForwardAE,RegWriteM,RegWriteW,WriteRegM,WriteRegW,RsE,RtE,	//solve RAW
StallF,StallD,FlushE,RsD,RtD,MemtoRegE,										//solve stall 
ForwardAD, ForwardBD,																//solve RAW
BranchD, RegWriteE, WriteRegE, MemtoRegM, JumpD	//solve stall
);
	input RegWriteM,RegWriteW;
	input [4:0] WriteRegM,WriteRegW;
	input BranchD;
	input JumpD;
	input [4:0] RsD,RtD;
	input [4:0] RsE,RtE;
	input [4:0]WriteRegE;
	input RegWriteE;
	input MemtoRegE;
	input MemtoRegM;
	output reg StallF,StallD,FlushE; 
	output reg ForwardAD, ForwardBD;
	output  reg [1:0]ForwardBE,ForwardAE;
	
	reg lwstall;		//Tin hieu solve hazard (stall) cho lenh lw
	reg branchstall;	//Tin hieu solve hazard (stall) cho re nhanh
	
	always @(*)
	begin
	//Forward for field Rs	(solve RAW hazard)
		if			((RsE != 0) && (RsE == WriteRegM) && RegWriteM) ForwardAE = 2'b10; //Forward from memory stage to execute stage (ALU)
		else if 	((RsE != 0) && (RsE == WriteRegW) && RegWriteW) ForwardAE = 2'b01; //Forward from write back stage to execute stage (ALU)
			  else ForwardAE = 2'b00;
	
	//Forward for field Rt	(solve RAW hazard)
		if			((RtE != 0) && (RtE == WriteRegM) && RegWriteM) ForwardBE = 2'b10; //Forward from memory stage to execute stage (ALU)
		else if 	((RtE != 0) && (RtE == WriteRegW) && RegWriteW) ForwardBE = 2'b01; //Forward from write back stage to execute stage (ALU)
			  else ForwardBE = 2'b00;
		lwstall = ((RtE == RsD) || (RtE == RtD)) && (MemtoRegE) ;
		ForwardAD = (RsD != 0) && (RsD == WriteRegM) && (RegWriteM);
		ForwardBD = ((RtD != 0) && (RtD == WriteRegM) && RegWriteM);
		branchstall = 	(BranchD && RegWriteE && ((WriteRegE == RsD) || (WriteRegE == RtD))) || 
								(BranchD && MemtoRegM && ((WriteRegM == RsD) || (WriteRegM == RtD))); 
		StallD = lwstall | branchstall;
		StallF = lwstall | branchstall;
		FlushE = (lwstall | branchstall) | JumpD;
	end
endmodule

/*
 *		Thiet ke MIPS pipeline
 *		author: Luu Minh Tung
 */
//Pipeline datapath
module datapath(
	input clk, reset_n,
	input regwrited, memtoregd, memwrited, alusrcd, regdstd, branchd_beq, branchd_bne, jumpd,aluselectshilfd,	//from Control unit
	input [3:0]alucontrold,															//from Control unit
	input 	[31:0]	instr, 			//from instruction memory
	input 	[31:0] 	readdatam,		//from data memory
	//input from hazard unit
	input stallf,
	input stalld,forwardad,forwardbd,
	input flushe,
	input [1:0]forwardae, forwardbe,
	//output to hazard unit
	//output branchd,
	output [4:0]	rsd,rtd,
	output [4:0]	rse,rte,writerege,
	output 			memtorege, regwritee,
	output [4:0]	writeregmtohz,
	output 			regwritem, memtoregm,
	output [4:0]	writeregwtohz,
	output 			regwritewtohz,
	
	output [31:0] 	pc,		//to instruction memory
	output [31:0]	aluoutmtodm, writedatamtodm,	//to data memory
	output [5:0]	opinstr, functinstr,				//to control unit
	output 			we_todm								//to data memory
);
//Registers stage
reg [31:0]regif;
reg [63:0]regd;
reg [125:0]regex;
reg [71:0]regmem;
reg [70:0]regwb;

reg [31:0]pcnext;
wire [31:0]pcplus4f;
wire [31:0]pcjump;

//Decode stage
wire [31:0]pcbranchd;
wire pcsrcdtmp;
wire [1:0]pcsrcd;
wire pcsrcd_clr;
wire [31:0]instrd;
wire [31:0]pcplus4d;
wire [31:0]rd1,rd2;
wire [31:0]signimmd;
reg equald;
wire [31:0]muxrd1,muxrd2;
wire x,y;
wire [4:0]shamtD;
//Execute stage
wire [3:0]alucontrole;
wire alusrce,regdste,aluselectshilfe;
wire [4:0]mux21towriterege;
wire [31:0]srcae,srcae1,srcbe, writedatae;
wire [31:0]outalue, extshamte;
wire [4:0]shamtE;
//Data memory stage
wire memwritem;
wire [31:0]aluoutm;
//Write back stage
wire [31:0]resultw;
wire [4:0]writeregw;
wire regwritew, memtoregw;

always @(*)
begin
	if (pcsrcd == 2'd0) pcnext = pcplus4f;
	else if (pcsrcd == 2'd1) pcnext = pcbranchd;
	else if (pcsrcd == 2'd2) pcnext = pcjump;
	else pcnext = 32'bx;
end

//Fetch stage
always @(posedge clk or negedge reset_n)
begin
	$display($time,"\tpcnext = %h, instruction next = %h",pcnext, instr);
	if(!reset_n) regif <= 32'd0;
	else 	if (!stallf)	regif <= pcnext;
			else regif <= regif;
end
assign pc = regif;
assign pcplus4f = regif + 32'd4;

//Decode stage
always @(posedge clk or negedge reset_n)
begin
	if ((!reset_n)) regd <= 64'd0;
	else if (pcsrcd_clr) regd <= 64'd0;
	else 	if (!stalld)
			begin
				regd <= {instr,pcplus4f};
			end
			else if (stalld)
			begin
				regd <= regd;
			end
	$display($time,"\tcurrent instruction = %h", instrd);
end
assign instrd = regd[63:32];
assign pcplus4d = regd[31:0];
RegFile	regfile_decode(
	.RA1(instrd[25:21]), 
	.RA2(instrd[20:16]),
	.WA(writeregw), 
	.WE(regwritew),
	.clk(clk), 
	.rst(reset_n),
	.WD(resultw), 
	.RD1(rd1), 
	.RD2(rd2)
	);
SignEx	signex_decode(
	.X(instrd[15:0]),
	.Y(signimmd)
	);
assign shamtD = instrd[10:6];
assign pcbranchd = (signimmd << 2) + pcplus4d;
assign opinstr = instrd[31:26];
assign pcjump = {pcplus4d[31:28],instrd[25:0],2'b00};
assign functinstr = instrd[5:0];
assign muxrd1 = forwardad ? aluoutm : rd1;
assign muxrd2 = forwardbd ? aluoutm : rd2;
always @(*)
begin
	if (muxrd1 == muxrd2) equald = 1'b1;
	else equald = 1'b0;
end
assign x = branchd_beq & equald;
assign y = branchd_bne & ~equald;
assign pcsrcdtmp = x | y;
assign pcsrcd = {jumpd,pcsrcdtmp};
assign pcsrcd_clr = pcsrcd[0] | pcsrcd[1];
assign rsd = instrd[25:21];
assign rtd = instrd[20:16];
//Execute stage
always @(posedge clk or negedge reset_n)
begin
	if ((!reset_n)) regex <= 126'd0;
	else 	if (flushe) regex <= 126'd0;
			else 
			begin
				regex <= {aluselectshilfd,regwrited,memtoregd,memwrited,alucontrold,alusrcd,regdstd,rd1,rd2,instrd[25:11],shamtD,signimmd};
			end
end
assign aluselectshilfe = regex[125];
assign alucontrole = regex[121:118];
assign alusrce = regex[117];
assign regdste = regex[116];
assign rse = regex[51:47];
assign rte = regex[46:42];
assign mux21towriterege = regdste ? regex[41:37] : rte;
assign shamtE = regex[36:32];
assign srcae1 = (forwardae == 2'b00) ? regex[115:84] : ((forwardae == 2'b01) ? resultw : aluoutm);
assign srcae = aluselectshilfe ? extshamte : srcae1;
assign writedatae = (forwardbe == 2'b00) ? regex[83:52]  : ((forwardbe == 2'b01) ? resultw : aluoutm);
assign srcbe = alusrce ? regex[31:0] : writedatae;
assign writerege = mux21towriterege;
ALU ALU_execute(
	.A(srcae), 
	.B(srcbe), 
	.F(alucontrole), 
	.Y(outalue), 
	.ZF()
	);
// extend shamt field for R-type instruction
signExt_shamt signExt1(.shamt(shamtE), .shamt_out(extshamte));
assign regwritee = regex[124];
assign memtorege = regex[123];

//Data memory stage
always @(posedge clk or negedge reset_n)
begin
	if (!reset_n) regmem <= 72'd0;
	else regmem <= {regex[124:122],outalue,writedatae,mux21towriterege};
end
assign regwritem = regmem[71];
assign memtoregm = regmem[70];
assign memwritem = regmem[69];
assign we_todm = memwritem;
assign aluoutm = regmem[68:37];
assign aluoutmtodm = aluoutm;
assign writedatamtodm = regmem[36:5];
assign writeregmtohz = regmem[4:0];

//Write back stage
always @(posedge clk or negedge reset_n)
begin
	if (!reset_n) regwb <= 71'd0;
	else regwb <= {regmem[71:70],readdatam,aluoutm,regmem[4:0]};
end
assign regwritew = regwb[70];
assign memtoregw = regwb[69];
assign regwritewtohz = regwritew;
assign writeregwtohz = writeregw;
assign resultw = memtoregw ? regwb[68:37] : regwb[36:5];		//memtoregw ? ReadataW : ALUOutW
assign writeregw = regwb[4:0];
assign writeregwtohz = writeregw;
endmodule
/*
 *		Thiet ke MIPS pipeline
 *		author: Luu Minh Tung
 */
//Pipeline datapath
module datapath(
	input clk, reset_n,
	input regwrited, memtoregd, memwrited, alusrcd, regdstd, branchd,	//from Control unit
	input [2:0]alucontrold,															//from Control unit
	input 	[31:0]	instr, 			//from instruction memory
	input 	[31:0] 	readdatam,		//from data memory
	//input from hazard unit
	input stallf,
	input stalld,forwardad,forwardbd,
	input flushe,
	input [1:0]forwardae, forwardbe,
	//output to hazard unit
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
reg [118:0]regex;
reg [71:0]regmem;
reg [70:0]regwb;

wire [31:0]pcnext;
wire [31:0]pcplus4f;

//Decode stage
wire [31:0]pcbranchd;
wire pcsrcd;
wire [31:0]instrd;
wire [31:0]pcplus4d;
wire [31:0]rd1,rd2;
wire [31:0]signimmd;
wire equald;
wire [31:0]muxrd1,muxrd2;
//Execute stage
wire [2:0]alucontrole;
wire alusrce,regdste;
wire [4:0]mux21towriterege;
wire [31:0]srcae,srcbe, writedatae;
wire [31:0]outalue;
//Data memory stage
wire memwritem;
wire [31:0]aluoutm;
//Write back stage
wire [31:0]resultw;
wire [4:0]writeregw;
wire regwritew, memtoregw;


assign pcnext = pcsrcd ? pcbranchd : pcplus4f;
assign equald = (muxrd1 ^ muxrd2) ? 1'b1 : 1'b0;
//Fetch stage
always @(posedge clk or negedge reset_n)
begin
	if(!reset_n) regif <= 32'd0;
	else 	if (!stallf)	regif <= pcnext;
			else regif <= regif;
end
assign pc = regif;
assign pcplus4f = regif + 32'd4;

//Decode stage
always @(posedge clk or negedge reset_n)
begin
	if ((!reset_n) || pcsrcd) regd <= 64'd0;
	else 	if (!stalld)
			begin
				regd <= {instr,pcplus4f};
			end
			else if (stalld)
			begin
				regd <= regd;
			end
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
assign pcbranchd = (signimmd << 2) + pcplus4d;
assign opinstr = instrd[31:26];
assign functinstr = instrd[5:0];
assign pcsrcd = branchd & equald;
assign muxrd1 = forwardad ? aluoutm : rd1;
assign muxrd2 = forwardbd ? aluoutm : rd2;

assign rsd = instrd[25:21];
assign rtd = instrd[20:16];
//Execute stage
always @(posedge clk or negedge reset_n)
begin
	if ((!reset_n) || flushe) regex <= 119'd0;
	else regex <= {regwrited,memtoregd,memwrited,alucontrold,alusrcd,regdstd,rd1,rd2,instrd[25:11],signimmd};
end
assign alucontrole = regex[115:113];
assign alusrce = regex[112];
assign regdste = regex[111];
assign rse = regex[46:42];
assign rte = regex[41:37];
assign mux21towriterege = regdste ? regex[36:32] : regex[41:37];
assign srcae = (forwardae == 2'b00) ? regex[110:79] : ((forwardae == 2'b01) ? resultw : aluoutm);
assign writedatae = (forwardbe == 2'b00) ? regex[78:47]  : ((forwardbe == 2'b01) ? resultw : aluoutm);
assign srcbe = alusrce ? regex[31:0] : writedatae;
assign writerege = mux21towriterege;
ALU ALU_execute(
	.A(srcae), 
	.B(srcbe), 
	.F(alucontrole), 
	.Y(outalue), 
	.ZF()
	);
assign regwritee = regex[118];
assign memtorege = regex[117];

//Data memory stage
always @(posedge clk or negedge reset_n)
begin
	if (!reset_n) regmem <= 72'd0;
	else regmem <= {regex[118:116],outalue,writedatae,mux21towriterege};
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
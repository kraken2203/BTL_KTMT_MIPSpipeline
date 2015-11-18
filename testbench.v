`timescale 1ps/1ps
module testbench;
	reg 			clk,reset_n;
	wire	[31:0]dataaddr,writedata;
	wire 			memwrite;
	//DUT
	top DUT(
		.clk(clk),
		.reset_n(reset_n),
		.dataaddr(dataaddr),
		.writedata(writedata),
		.memwrite(memwrite)
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
always @ (negedge clk)
begin
	if (memwrite) begin
		if (dataaddr === 8 & writedata === 3) begin
			$display ("Simulation succeeded");
			//$stop;
		end 
		else if (dataaddr !== 8) begin
			$display ("Simulation failed");
			//$stop;
		end
	end
end
	//End simulation
	initial begin
		#200 $finish;
	end
endmodule
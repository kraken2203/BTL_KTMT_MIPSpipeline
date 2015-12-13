/*
 * Sign Extension module for shamt field in R-type instructions
 *
 */
module signExt_shamt (input [4:0] shamt, output [31:0] shamt_out);
  assign shamt_out[31:5] = {27{1'b0}};
  assign shamt_out[4:0] = shamt[4:0];
endmodule 
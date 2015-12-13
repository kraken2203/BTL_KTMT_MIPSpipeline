/*
 *		Thiet ke MIPS pipeline
 *		author: Nguyen Van Cao
 */
module ALU #(parameter N = 32) (A, B, F, Y, ZF);
input signed [N-1:0] A,B ;
input [3:0]F; 
output reg [N-1:0] Y;
output ZF;

always @(A, B, F) begin
    case (F)
      4'b0000 : Y = A & B;  // and
      4'b0001 : Y = A | B;  // or
      4'b0010 : Y = A + B;  // add
      4'b0011 : Y = A ^ B;  // xor
      4'b0100 : Y = ~ (A | B);  // nor
      4'b0110 : Y = A - B;  // sub
      4'b0111 : Y = (A < B) ? 1:0;  // slt
      4'b1000 : Y = (B << A); // shift left logic
      4'b1001 : Y = (B >> A); // shift right logic
      4'b1010 : Y = (B >>> A);// shift right arithmetic
      default : Y = 32'bx;
    endcase
  end // end always
assign ZF = (Y==0);
endmodule 


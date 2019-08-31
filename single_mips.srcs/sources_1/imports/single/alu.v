`timescale 1ns/1ns
module alu(
	input [31:0] src1,
	input [31:0] src2,
	input [1:0] ALU_ctrl,
	output [31:0] data_out,
	output beq_out
);
	//reg [32:0] tmp_arith;
	// ctrl 00-> add
	// 01 -> lui
	// 10 sltu
	// 11 other
	assign beq_out = (src1-src2==0)?'b1:'b0;
	assign data_out = (ALU_ctrl=='b00)?(src1+src2):
	                   (ALU_ctrl=='b01)?{src2[15:0],16'b0}:
	                   (ALU_ctrl=='b10)?((src2>src1)?32'b1:32'b0):
	                   32'b0;
endmodule
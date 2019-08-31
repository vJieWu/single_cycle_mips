`timescale 1ns/1ns

module instMem(
	input [11:2] addr,
	output [31:0] data_out
);

	reg [31:0] inst_mem[1023:0];
	assign data_out = inst_mem[addr];
endmodule
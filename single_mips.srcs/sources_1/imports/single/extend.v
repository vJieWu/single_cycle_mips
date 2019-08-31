`timescale 1ns/1ns

module extend(
	input ex_op, // 0-> 0 extend 1-> sign extend
	input [15:0] data_in,
	output [31:0] data_out
);
	assign data_out = (ex_op=='b1)?{{16{data_in[15]}},data_in}:{16'b0,data_in};
endmodule
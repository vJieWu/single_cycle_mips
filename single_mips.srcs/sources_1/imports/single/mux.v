`timescale 1ns/1ns
//mux_sel='b0 for in1,mux_sel='b1 for in2
module mux(

	input [31:0] in1,
	input [31:0] in2,
	input mux_sel,
	output [31:0] out
);
	assign out=(mux_sel=='b1)?in2:in1;
endmodule
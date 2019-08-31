`timescale 1ns/1ns
module pc(
	input clk,
	input rst,
	input [31:0] npc,
	output reg [31:0] pc
);
	//reg [31:0] pc;
	
	always@(posedge clk)
		pc<=npc;
	
	always@(posedge rst)
		pc<='hb0000000;
	
endmodule

`timescale 1ns/1ns

module dataMem(
	input clk,
	input [11:2] addr, //4KB = 2^10
	input [31:0] data_in,
	input write_en,
	output [31:0] data_out
);
	reg [31:0] data_mem[1023:0];
	assign data_out = data_mem[addr];
	
	always@(posedge clk)
		if(write_en)
			begin
				data_mem[addr]<=data_in; //write to data memory
			end
endmodule
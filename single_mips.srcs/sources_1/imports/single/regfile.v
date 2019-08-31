`timescale 1ns/1ns

module regfile(
	input clk,
	input [4:0] rs,
	input [4:0] rt,
	input [4:0] rd,
	input [4:0] dst,
	input Reg_we,  // wirte_enable
	input Reg_dst, //0-> rt 1-> rd
	input [31:0] in_data,
	output [31:0] data_rs, // data of RS
	output [31:0] data_rt// data of RT
);

    
	reg [31:0] gpr [31:0];
	assign data_rs = (rs==0)?8'h00000000:gpr[rs];
	assign data_rt = (rt==0)?8'h00000000:gpr[rt];
	assign dst = (Reg_dst=='b0)?rt:rd;
	
	always@(posedge clk)
		if(Reg_we)
			begin
				gpr[dst] = in_data;
			end
endmodule
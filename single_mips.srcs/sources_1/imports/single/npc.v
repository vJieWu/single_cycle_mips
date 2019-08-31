`timescale 1ns/1ns

module npc(
	input [31:0] pc,
	input [15:0] imm_16,
	input [25:0] imm_26,
	input [1:0] npc_select,
	output [31:0] npc
);
	assign npc = (npc_select=='b01)?(pc+3'b100+{{14{imm_16[15]}},imm_16,2'b00}):
				 (npc_select=='b10)?({pc[31:28],imm_26,2'b00}):(pc+3'b100);
endmodule

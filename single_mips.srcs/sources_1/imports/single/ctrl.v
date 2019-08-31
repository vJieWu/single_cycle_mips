`timescale 1ns / 1ps

module ctrl(
	input [5:0] op_code,
	input [5:0] func_code,
	input beq_out,    //0/1 notequal equal
	output Reg_dst,   //0/1  rt, rd
	output Extend_op, //zero_extend, sign_extend
	output ALU_src,   //rt, imm
	output [1:0] ALU_ctr,   //add, or
	output Reg_we,    // 1 for write
	output DataMem_we,// 1 for write
	output GPR_src,   // 0 for dataMem, 1 for alu
	output [1:0] npc_select // 00 nop;01 beq;10 j
);

	wire add;
	wire sltu; //
	wire addiu; //
	wire lui; //
	wire lw;
	wire sw;
	wire j;
	wire beq;

	assign add=(op_code==6'b000000&&func_code==6'b100000)?'b1:'b0;
	assign sltu=(op_code==6'b000000&&func_code==6'b101011)?'b1:'b0;
	assign lui=(op_code==6'b001111)?'b1:'b0;
	assign addiu=(op_code==6'b001001)?'b1:'b0;
	assign lw=(op_code==6'b100011)?'b1:'b0;
	assign sw=(op_code==6'b101011)?'b1:'b0;
	assign j=(op_code==6'b000010)?'b1:'b0;
	assign beq=(op_code==6'b000100)?'b1:'b0;
	
	assign npc_select = (j=='b1)?'b10:(beq=='b1&&beq_out=='b1)?'b01:'b00;
	assign GPR_src = (lw=='b1)?'b0:'b1; // 选择写入regfile的数据控制信号，控制gprmux
	assign Reg_dst = (add=='b1)?'b1:(sltu=='b1)?'b1:'b0;
	assign Reg_we  = (add=='b1)?'b1:(sltu=='b1)?'b1:(lw=='b1)?'b1:(addiu=='b1)?'b1:(lui=='b1)?'b1:'b0;
	assign DataMem_we = (sw=='b1)?'b1:'b0;
	assign ALU_ctr = (lui=='b1)?'b01:(sltu=='b1)?'b10:'b00;
	assign ALU_src = (addiu=='b1||lw=='b1||sw=='b1||lui=='b1)?'b1:'b0;//选择寄存器读出或者符号扩展�?�入ALU
	assign Extend_op = (lui=='b1)?'b0:'b1;
	
endmodule
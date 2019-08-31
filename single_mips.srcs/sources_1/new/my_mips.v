`timescale 1ns / 1ns

module my_mips(
    input clk,
    input rst
    );
    wire [5:0] op;
    wire [5:0] funct;
    wire [4:0] rs;
    wire [4:0] rt;
    wire [4:0] rd;
    wire [15:0] imm_16;
    wire [25:0] imm_26;    
    wire [31:0] instr;
    
    // ctrl unit
    wire reg_dst;
    wire extend_op;
    wire alu_src;
    wire [1:0] alu_ctrl;
    wire reg_we;
    wire datamem_we;
    wire gpr_src;
    wire [1:0] npc_select;
    
    //gpr
    wire [4:0] dst;
    //wire [31:0] in_data;
    wire [31:0] rs_out;
    wire [31:0] rt_out;
    
    wire [31:0] pc_in;
    wire [31:0] pc_out;
    
    wire [31:0] mux_out_alu;
    wire [31:0] mux_out_gpr;
    
    wire [31:0] alu_out;
    wire beqout;
    
    wire [31:0] extend_out;
    wire [31:0] datamem_out;
    
    
    assign op=instr[31:26];
    assign rs=instr[25:21];
    assign rt=instr[20:16];
    assign rd=instr[15:11];
    assign funct=instr[5:0];
    assign imm_16=instr[15:0];
    assign imm_26=instr[25:0];
    
    pc pc0(clk,rst,pc_in,pc_out);
    npc npc0(pc_out,imm_16,imm_26,npc_select,pc_in);
    instMem instmem0(pc_out[11:2],instr);
    dataMem datamem0(clk,alu_out[9:0],rt_out,datamem_we,datamem_out);
    regfile regfile0(clk,rs,rt,rd,dst,reg_we,reg_dst,mux_out_gpr,rs_out,rt_out);
    ctrl ctrl0(op,funct,beqout,reg_dst,extend_op,alu_src,alu_ctrl,reg_we,datamem_we,gpr_src,npc_select);
    alu alu0(rs_out,mux_out_alu,alu_ctrl,alu_out,beqout);
    mux mux_alu(rt_out,extend_out,alu_src,mux_out_alu);
    mux mux_regwrite(datamem_out,alu_out,gpr_src,mux_out_gpr);
    extend extend0(extend_op,imm_16,extend_out);
    
    
endmodule

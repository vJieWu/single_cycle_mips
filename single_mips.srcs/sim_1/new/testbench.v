`timescale 1ns / 1ps

module testbench();
    reg clk;
    reg rst;
    reg[31:0] result;
    my_mips my_mips0(clk,rst);
    initial begin  
       $readmemh("C:\Users\vjiew\Desktop\single_mips\instr_mem.txt",my_mips0.instmem0.inst_mem);
       $readmemh("C:\Users\vjiew\Desktop\single_mips\reg.txt",my_mips0.regfile0.gpr);
       $readmemh("C:\Users\vjiew\Desktop\single_mips\data_mem.txt",my_mips0.datamem0.data_mem);
           rst= 1 ;
           clk = 0 ;
           #30 rst=0;      
         result = my_mips.U_im_4k.im[1000];
         $monitor("Time %t,R16= %h",$time, my_mips.U_gpr.gpr[16]);
    end
    
    always
        #20 clk=~clk;

    
endmodule

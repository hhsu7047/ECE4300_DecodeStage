`timescale 1ns/1ps

module testbench;
    reg clk;
    reg rst;
    reg [31:0] instr;
    reg regWrite;
    reg [31:0] npc;
    reg [4:0] writeReg;
    reg [31:0] writeData;
    
    wire [1:0] writeBack;
    wire [2:0] memory;
    wire [1:0] aluOp;
    wire aluSrc;
    wire regDst;
    wire [31:0] nextPc;
    wire [31:0] readdata1;
    wire [31:0] readdata2;
    wire [31:0] signExtend;
    wire [4:0] instruct2016;
    wire [4:0] instruct1511;
    
    instructiondecode id0(
        .clk(clk),
        .rst(rst),
        .instr(instr),
        .regWrite(regWrite),
        .npc(npc),
        .writeReg(writeReg),
        .writeData(writeData),
        .writeBack(writeBack),
        .memory(memory),
        .aluOp(aluOp),
        .aluSrc(aluSrc),
        .regDst(regDst),
        .nextPc(nextPc),
        .readdata1(readdata1),
        .readdata2(readdata2),
        .signExtend(signExtend),
        .instruct2016(instruct2016),
        .instruct1511(instruct1511)    
    );
    
    initial begin
        clk = 0;
        forever #5 clk =~clk;
    end
    
    initial begin
        rst = 1;
        instr = 32'b0;
        regWrite = 1'b0;
        npc = 32'b0;
        writeReg = 5'b0;
        writeData = 32'b0;
        
        #1 
        rst = 0;
        
        #1 
        rst = 1;
        
        // R-Type Instruction, Add contents in Reg 0 and Reg 1 and store in Reg 2
        instr = 32'b00000000000000010001000000100000;
        
        #10
        // regWrite = 1, so write content to Reg 0
        writeReg = 5'b00011;
        writeData = 32'hDEADBEEF;
        regWrite = 1'b1;
        
        #10
        regWrite = 1'b0;
        // R-Type Instruction, Add contents in Reg 1 and Reg 3 and store in Reg 1
        instr = 32'b00000000001000110000100000100000;
        
        #10
        // I-Type Instruction, Load word from memory address 2
        instr = 32'b10001100000000010000000000000010;
        
        #10 
        //I-Type Instruction, Store word 
        instr = 32'b10101100100001010000000000000100;
        
        #10
        //I-Type Instruction, Branch
        instr = 32'b00010000111001110000000000000010;
        
        #10 
        // No Op
        instr = 32'b10000000000000000000000000000000;
        
        
        #100 
        $finish;
        
    
    end
    
endmodule
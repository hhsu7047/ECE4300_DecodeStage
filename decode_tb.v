`timescale 1ns / 1ps

module decode_tb();
    reg clk, rst, wb_reg_write;
    reg [4:0] wb_write_reg_location;
    reg [31:0] mem_wb_write_data, if_id_instr, if_id_npc;

    wire [1:0] id_ex_wb;
    wire [2:0] id_ex_mem;
    wire [3:0] id_ex_execute;
    wire [31:0] id_ex_npc, id_ex_readdat1, id_ex_readdat2, id_ex_sign_ext;
    wire [4:0] id_ex_instr_bits_20_16, id_ex_instr_bits_15_11;

    // decode_stage
    decode_stage uut (
        .clk(clk), .rst(rst), .wb_reg_write(wb_reg_write),
        .wb_write_reg_location(wb_write_reg_location),
        .mem_wb_write_data(mem_wb_write_data),
        .if_id_instr(if_id_instr), .if_id_npc(if_id_npc),
        .id_ex_wb(id_ex_wb), .id_ex_mem(id_ex_mem), .id_ex_execute(id_ex_execute),
        .id_ex_npc(id_ex_npc), .id_ex_readdat1(id_ex_readdat1),
        .id_ex_readdat2(id_ex_readdat2), .id_ex_sign_ext(id_ex_sign_ext),
        .id_ex_instr_bits_20_16(id_ex_instr_bits_20_16),
        .id_ex_instr_bits_15_11(id_ex_instr_bits_15_11)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0; rst = 1; wb_reg_write = 0;
        wb_write_reg_location = 0; mem_wb_write_data = 0;
        if_id_instr = 0; if_id_npc = 32'h4;
        #15 rst = 0;

        //deadbeef as initialize like fetch
        @(negedge clk);
        wb_reg_write = 1;
        wb_write_reg_location = 5'd1;
        mem_wb_write_data = 32'hDEADBEEF;
        
        // ADD $3, $1, $2
        @(negedge clk);
        wb_reg_write = 0; 
        if_id_instr = 32'h00221820; 

        #50 $finish;
    end
endmodule
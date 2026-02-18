`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:06:07 02/12/2026 
// Design Name: 
// Module Name:    MEM_WB 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module MEM_WB(
    input clk,
    input reset,
    input  [63:0] alu_result_in,
    input  [63:0] mem_data_in,
    input  [1:0]  rd_in,
    input         WRegEn_in,
    input         MemToReg_in,
    output [63:0] alu_result_out,
    output [63:0] mem_data_out,
    output [1:0]  rd_out,
    output        WRegEn_out,
    output        MemToReg_out
    );

    stage_register_n #(64) alu_reg (.clk(clk), .reset(reset), .d(alu_result_in), .q(alu_result_out));
    stage_register_n #(64) mem_reg (.clk(clk), .reset(reset), .d(mem_data_in), .q(mem_data_out));
    stage_register_n #(2)  rd_reg  (.clk(clk), .reset(reset), .d(rd_in), .q(rd_out));
    stage_register_n #(1)  wreg_reg(.clk(clk), .reset(reset), .d(WRegEn_in), .q(WRegEn_out));
    stage_register_n #(1)  mtr_reg (.clk(clk), .reset(reset), .d(MemToReg_in), .q(MemToReg_out));

endmodule

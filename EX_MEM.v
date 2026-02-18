`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:04:39 02/12/2026 
// Design Name: 
// Module Name:    EX_MEM 
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
module EX_MEM(
    input clk,
    input reset,
    input  [63:0] alu_result_in,
    input  [63:0] rt_data_in,
    input  [1:0]  rd_in,
    input         WRegEn_in,
    input         WMemEn_in,
    input         MemToReg_in,
	 input  [7:0]  address_in,
	 input  [63:0] rs_data_in,
    output [63:0] rs_data_out,
    output [63:0] alu_result_out,
    output [63:0] rt_data_out,
    output [1:0]  rd_out,
    output        WRegEn_out,
    output        WMemEn_out,
    output        MemToReg_out,
	 output [7:0]  address_out
    );
	 
    stage_register_n #(64) rs_reg  (.clk(clk), .reset(reset), .d(rs_data_in), .q(rs_data_out));
    stage_register_n #(64) alu_reg (.clk(clk), .reset(reset), .d(alu_result_in), .q(alu_result_out));
    stage_register_n #(64) rt_reg  (.clk(clk), .reset(reset), .d(rt_data_in), .q(rt_data_out));
    stage_register_n #(2)  rd_reg  (.clk(clk), .reset(reset), .d(rd_in), .q(rd_out));
    stage_register_n #(8)  addr_reg(.clk(clk), .reset(reset), .d(address_in), .q(address_out));
    stage_register_n #(1)  wreg_reg(.clk(clk), .reset(reset), .d(WRegEn_in), .q(WRegEn_out));
    stage_register_n #(1)  wmem_reg(.clk(clk), .reset(reset), .d(WMemEn_in), .q(WMemEn_out));
    stage_register_n #(1)  mtr_reg (.clk(clk), .reset(reset), .d(MemToReg_in), .q(MemToReg_out));

endmodule

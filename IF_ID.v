`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:58:23 02/12/2026 
// Design Name: 
// Module Name:    IF_ID 
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
module IF_ID(
    input clk,
    input reset,
    input [31:0] instruction_in,
    output [31:0] instruction_out
    );

    stage_register_n #(32) inst_reg (.clk(clk), .reset(reset), .d(instruction_in), .q(instruction_out));

endmodule

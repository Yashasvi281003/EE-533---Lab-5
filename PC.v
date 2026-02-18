`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:15:55 02/12/2026 
// Design Name: 
// Module Name:    PC 
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
module PC(
    input clk,
    input reset,
    output [8:0] pc_out
    );

    wire [8:0] pc_current;
    wire [8:0] pc_next;

    assign pc_next = pc_current + 9'd1;

    stage_register_n #(9) pc_reg (.clk(clk), .reset(reset), .d(pc_next), .q(pc_current));

    assign pc_out = pc_current;

endmodule

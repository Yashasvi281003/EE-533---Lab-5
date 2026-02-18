`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:55:50 02/12/2026 
// Design Name: 
// Module Name:    stage_register_n 
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
module stage_register_n #(parameter WIDTH = 1)(
    input clk,
    input reset,
    input [WIDTH-1:0] d,
    output [WIDTH-1:0] q
    );

    genvar i;

    generate
        for (i = 0; i < WIDTH; i = i + 1) begin : dff_gen
            dff_reset dff_inst (
                .clk(clk),
                .reset(reset),
                .D(d[i]),
                .Q(q[i])
            );
        end
    endgenerate
	 
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:52:54 02/11/2026 
// Design Name: 
// Module Name:    mux4to1_64 
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
module mux4to1_64(
    input [63:0] in0,
    input [63:0] in1,
    input [63:0] in2,
    input [63:0] in3,
    input [1:0] sel,
    output reg [63:0] y
    );
	 
always @(*) begin
    case(sel)
        2'b00: y = in0;
        2'b01: y = in1;
        2'b10: y = in2;
        2'b11: y = in3;
        default: y = 64'b0;
    endcase
end

endmodule

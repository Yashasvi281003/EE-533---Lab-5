`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:58:48 02/11/2026 
// Design Name: 
// Module Name:    reg64_2 
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
module reg64_2(
    input clk,
    input we,
    input [63:0] D,
	 input reset,
    output reg [63:0] Q
    );

always @(posedge clk or posedge reset)
begin
	 if (reset)
		  Q <= 64'b0;
    else if (we)
        Q <= D;
end

endmodule

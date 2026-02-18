`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:50:13 02/11/2026 
// Design Name: 
// Module Name:    decoder2to4 
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
module decoder2to4(
    input [1:0] addr,
    input we,
    output [3:0] dec_out
    );

	assign dec_out[0] = we & (~addr[1]) & (~addr[0]); // 00
	assign dec_out[1] = we & (~addr[1]) & ( addr[0]); // 01
	assign dec_out[2] = we & ( addr[1]) & (~addr[0]); // 10
	assign dec_out[3] = we & ( addr[1]) & ( addr[0]); // 11

endmodule

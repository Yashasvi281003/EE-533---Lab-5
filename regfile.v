`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:56:03 02/11/2026 
// Design Name: 
// Module Name:    regfile 
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
module regfile(
    input clk,
    input we,
	 input reset,
    input [1:0] wr_addr,
    input [63:0] wr_data,
    input [1:0] rd_addr1,
    input [1:0] rd_addr2,
    output [63:0] rd_data1,
    output [63:0] rd_data2
    );

wire [3:0] dec_out;

wire [63:0] r0_out;
wire [63:0] r1_out;
wire [63:0] r2_out;
wire [63:0] r3_out;


decoder2to4 DEC (
    .addr(wr_addr),
    .we(we),
    .dec_out(dec_out)
);


reg64_2 R0 (
    .clk(clk),
    .we(dec_out[0]),
	 .reset(reset),
    .D(wr_data),
    .Q(r0_out)
);

reg64_2 R1 (
    .clk(clk),
    .we(dec_out[1]),
	 .reset(reset),
    .D(wr_data),
    .Q(r1_out)
);

reg64_2 R2 (
    .clk(clk),
    .we(dec_out[2]),
	 .reset(reset),
    .D(wr_data),
    .Q(r2_out)
);

reg64_2 R3 (
    .clk(clk),
    .we(dec_out[3]),
	 .reset(reset),
    .D(wr_data),
    .Q(r3_out)
);


mux4to1_64 MUX1 (
    .in0(r0_out),
    .in1(r1_out),
    .in2(r2_out),
    .in3(r3_out),
    .sel(rd_addr1),
    .y(rd_data1)
);

mux4to1_64 MUX2 (
    .in0(r0_out),
    .in1(r1_out),
    .in2(r2_out),
    .in3(r3_out),
    .sel(rd_addr2),
    .y(rd_data2)
);

endmodule

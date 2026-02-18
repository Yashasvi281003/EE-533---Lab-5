`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:03:08 02/12/2026
// Design Name:   regfile
// Module Name:   C:/Xilinx/10.1/ISE/Lab_YLR/lab5_2/regfile_tb.v
// Project Name:  lab5_2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: regfile
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module regfile_tb;

	// Inputs
	reg clk;
	reg we;
	reg reset;
	reg [1:0] wr_addr;
	reg [63:0] wr_data;
	reg [1:0] rd_addr1;
	reg [1:0] rd_addr2;

	// Outputs
	wire [63:0] rd_data1;
	wire [63:0] rd_data2;

	// Instantiate the Unit Under Test (UUT)
	regfile uut (
		.clk(clk), 
		.we(we),
      .reset(reset),		
		.wr_addr(wr_addr), 
		.wr_data(wr_data), 
		.rd_addr1(rd_addr1), 
		.rd_addr2(rd_addr2), 
		.rd_data1(rd_data1), 
		.rd_data2(rd_data2)
	);
	
	initial clk = 0;
   always #10 clk = ~clk;

	initial begin
		// Initialize Inputs
		clk = 0;
		we = 0;
		reset = 1;
		wr_addr = 0;
		wr_data = 0;
		rd_addr1 = 0;
		rd_addr2 = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		reset = 0;
		@(posedge clk);
		we = 1;
      wr_addr = 2'b00;
      wr_data = 64'hAAAA_AAAA_AAAA_AAAA;
      @(posedge clk);
      we = 0;

      @(posedge clk);
      we = 1;
      wr_addr = 2'b01;
      wr_data = 64'hBBBB_BBBB_BBBB_BBBB;
      @(posedge clk);
      we = 0;

      @(posedge clk);
      we = 1;
      wr_addr = 2'b10;
      wr_data = 64'hCCCC_CCCC_CCCC_CCCC;
      @(posedge clk);
      we = 0;

      @(posedge clk);
      we = 1;
      wr_addr = 2'b11;
      wr_data = 64'hDDDD_DDDD_DDDD_DDDD;
      @(posedge clk);
      we = 0;

      @(posedge clk);
      rd_addr1 = 2'b00;
      rd_addr2 = 2'b01;

      @(posedge clk);
      rd_addr1 = 2'b10;
      rd_addr2 = 2'b11;

      @(posedge clk);

      $stop;
 	end
      
endmodule


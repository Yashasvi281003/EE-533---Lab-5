`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:25:58 02/12/2026 
// Design Name: 
// Module Name:    pipeline_top 
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
module pipeline_top(
    input clk,
    input reset
    );

    // PC and IF

    wire [8:0] pc_out;
    wire [31:0] instruction;

    PC pc_inst (
        .clk(clk),
        .reset(reset),
        .pc_out(pc_out)
    );

    IMem imem_inst (
        .addr(pc_out),
		  .clk(clk),
		  .din(32'b0),
        .dout(instruction),
		  .we(1'b0)
    );


    // IF/ID Stage Reg

    wire [31:0] instruction_ID;

    IF_ID if_id_inst (
        .clk(clk),
        .reset(reset),
        .instruction_in(instruction),
        .instruction_out(instruction_ID)
    );

    // Instruction Decoder
    wire [3:0] opcode;
    wire [1:0] rs, rt, rd;
    wire [7:0] address;

	 assign opcode  = instruction_ID[31:28];
	 assign rs      = instruction_ID[27:26];
	 assign rt      = instruction_ID[25:24];
	 wire [1:0] rd_rtype = instruction_ID[23:22];   // R-type destination
	 wire [1:0] rd_load  = instruction_ID[27:26];   // Load rd (to avoid naming confusion later)
	 assign rd = (opcode == 4'b1010) ? rd_load : rd_rtype;
	 assign address = instruction_ID[21:14];

    wire WMemEn_ID;
    wire WRegEn_ID;
    wire MemToReg_ID;

    instruction_decoder decoder_inst (
        .opcode(opcode),
        .WMemEn(WMemEn_ID),
        .WRegEn(WRegEn_ID),
        .MemToReg(MemToReg_ID)
    );
	 
    // Reg File

    wire [63:0] rs_data;
    wire [63:0] rt_data;

    wire [63:0] write_data_WB;
    wire [1:0]  rd_WB;
    wire        WRegEn_WB;

    regfile regfile_inst (
        .clk(clk),
		  .we(WRegEn_WB),
		  .wr_addr(rd_WB),
		  .wr_data(write_data_WB),
		  .rd_addr1(rs),
		  .rd_addr2(rt),
		  .rd_data1(rs_data),
		  .rd_data2(rt_data)
    );

    // ID/EX Stage Reg

    wire [63:0] rs_data_EX;
    wire [63:0] rt_data_EX;
    wire [1:0]  rd_EX;
    wire [7:0]  address_EX;
    wire        WMemEn_EX;
    wire        WRegEn_EX;
    wire        MemToReg_EX;

    ID_EX id_ex_inst (
        .clk(clk),
        .reset(reset),

        .rs_data_in(rs_data),
        .rt_data_in(rt_data),
        .rd_in(rd),
        .address_in(address),
        .WRegEn_in(WRegEn_ID),
        .WMemEn_in(WMemEn_ID),
        .MemToReg_in(MemToReg_ID),

        .rs_data_out(rs_data_EX),
        .rt_data_out(rt_data_EX),
        .rd_out(rd_EX),
        .address_out(address_EX),
        .WRegEn_out(WRegEn_EX),
        .WMemEn_out(WMemEn_EX),
        .MemToReg_out(MemToReg_EX)
    );

    // EX Stage - no alu so bypassing this stage

    wire [63:0] alu_result_EX;

    assign alu_result_EX = rs_data_EX;  

    // EX/MEM Stage Register


    wire [63:0] alu_result_MEM;
    wire [63:0] rt_data_MEM;
    wire [1:0]  rd_MEM;
    wire        WMemEn_MEM;
    wire        WRegEn_MEM;
    wire        MemToReg_MEM;
	 wire [7:0]  address_MEM;
	 wire [63:0] rs_data_MEM;


    EX_MEM ex_mem_inst (
        .clk(clk),
        .reset(reset),

        .alu_result_in(alu_result_EX),
        .rt_data_in(rt_data_EX),
        .rd_in(rd_EX),
        .WRegEn_in(WRegEn_EX),
        .WMemEn_in(WMemEn_EX),
        .MemToReg_in(MemToReg_EX),
		  .address_in(address_EX),
		  .address_out(address_MEM),
		  .rs_data_in(rs_data_EX),
        .rs_data_out(rs_data_MEM),
        .alu_result_out(alu_result_MEM),
        .rt_data_out(rt_data_MEM),
        .rd_out(rd_MEM),
        .WRegEn_out(WRegEn_MEM),
        .WMemEn_out(WMemEn_MEM),
        .MemToReg_out(MemToReg_MEM)
    );

 
    // Data Memory


    wire [63:0] mem_data;
	 DMem dmem_inst (

    // Port A : READ (not exactly using this functionality yet but for future ref)
        .addra(address_MEM),
        .clka(clk),
        .dina(64'b0),
        .douta(mem_data),
        .wea(1'b0),

    // Port B : WRITE 
        .addrb(address_MEM),
        .clkb(clk),
        .dinb(rs_data_MEM),
        .doutb(),               
        .web(WMemEn_MEM)

    );

    // MEM/WB Stage Register

    wire [63:0] alu_result_WB;
    wire [63:0] mem_data_WB;
    wire        MemToReg_WB;

    MEM_WB mem_wb_inst (
        .clk(clk),
        .reset(reset),

        .alu_result_in(alu_result_MEM),
        .mem_data_in(mem_data),
        .rd_in(rd_MEM),
        .WRegEn_in(WRegEn_MEM),
        .MemToReg_in(MemToReg_MEM),

        .alu_result_out(alu_result_WB),
        .mem_data_out(mem_data_WB),
        .rd_out(rd_WB),
        .WRegEn_out(WRegEn_WB),
        .MemToReg_out(MemToReg_WB)
    );

    // Writeback MUX

    assign write_data_WB = (MemToReg_WB) ? mem_data_WB : alu_result_WB;

endmodule

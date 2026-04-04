`timescale 1ns / 100ps
`include "ALU.v"
`include "RF.v"

module TOP(
    input clk,
    input rst,
    
    input [4:0] rd_addr1,
    input [4:0] rd_addr2,
    
    input RegWrite,
    input [4:0] wr_addr,

    input [4:0] shamt,
    input [3:0] funct,
    output [31:0] rd_data1,
    output [31:0] rd_data2,
    output [31:0] wr_data
    );
    
    wire [31:0] net1;
    wire [31:0] net2;

    RF rf (.clk(clk), .rst(rst), 
        .rd_addr1(rd_addr1), .rd_addr2(rd_addr2), 
        .RegWrite(RegWrite), 
        .wr_addr(wr_addr), .wr_data(wr_data),
        .rd_data1(net1), .rd_data2(net2) );

    ALU alu(
        .operand1(net1), .operand2(net2), 
        .funct(funct), .shamt(shamt), 
        .alu_result(wr_data) );
    
    assign rd_data1 = net1;
    assign rd_data2 = net2;

    

	// Instantiate modules and connect them!
    
endmodule

// Copyright (C) 1991-2013 Altera Corporation
// Your use of Altera Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License 
// Subscription Agreement, Altera MegaCore Function License 
// Agreement, or other applicable license agreement, including, 
// without limitation, that your use is for the sole purpose of 
// programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the 
// applicable agreement for further details.

module top
(
// {ALTERA_ARGS_BEGIN} DO NOT REMOVE THIS LINE!

	LED1,
	LED2,
	LED3,
	P3_2,
	P3_3,
	P3_4,
	P4_2,
	P5_2,
	P5_3,
	P6_2,
	P6_3,
	P8_3,
	P8_4,
	P8_5,
	P8_6,
	P8_7,
	P8_8,
	P8_9,
	P8_10,
	P8_11,
	P8_12,
	P8_13,
	P8_14,
	P8_15,
	P8_16,
	S1,
	S2,
	S3,
	SDA,
	SDC,
	sys_clk,
	tdm_tx1_p,
	TX,
	RX
// {ALTERA_ARGS_END} DO NOT REMOVE THIS LINE!

);

// {ALTERA_IO_BEGIN} DO NOT REMOVE THIS LINE!
output			LED1;
output			LED2;
output			LED3;
input			P3_2;
input			P3_3;
input			P3_4;
input			P4_2;
input			P5_2;
input			P5_3;
input			P6_2;
input			P6_3;
input			P8_3;
input			P8_4;
input			P8_5;
input			P8_6;
input			P8_7;
input			P8_8;
input			P8_9;
input			P8_10;
input			P8_11;
input			P8_12;
input			P8_13;
input			P8_14;
input			P8_15;
input			P8_16;
input			S1;
input			S2;
input			S3;
input			SDA;
input			SDC;
input			sys_clk;
input			tdm_tx1_p;
input			TX;
input			RX;

// {ALTERA_IO_END} DO NOT REMOVE THIS LINE!
// {ALTERA_MODULE_BEGIN} DO NOT REMOVE THIS LINE!
	
//`include "src/test.sv"

Test test(
	.CLK(sys_clk),
	.LED1(LED1),
	.LED2(LED2),
	.LED3(LED3)
);

///////////////////////////////////////
// Interconnecting internal signals //
/////////////////////////////////////
wire cmd_rdy;					// command from wireless ready
wire [7:0] cmd;				// 8-bit command from wireless
wire [15:0] data;				// 16-bit data from wireless
wire clr_cmd_rdy;				// clear the command from wireless
wire [7:0] resp;				// response to wireless
wire send_resp;				// asserted to send response to wireless
wire resp_sent;				// indicates response to wireless has been sent
/////////////////////////////////////////////////////////////////////////
// Instantiate UART_wrapper that receives commands from wireless link //
/////////////////////////////////////////////////////////////////////// 
UART_wrapper iUART_WRAP(.clr_cmd_rdy(clr_cmd_rdy), .cmd_rdy(cmd_rdy), .snd_resp(send_resp), .resp_sent(resp_sent), 
	.cmd(cmd), .data(data), .resp(resp), .clk(sys_clk), .rst_n(S1), .RX(RX), .TX(TX));
// {ALTERA_MODULE_END} DO NOT REMOVE THIS LINE!
endmodule





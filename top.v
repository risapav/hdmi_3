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
	SDA,
	SDC,
	button,
	led,
	sys_clk,
	uart_rx,
	uart_tx,
	lvds_tx*,
	lvds_tx_n
// {ALTERA_ARGS_END} DO NOT REMOVE THIS LINE!

);

// {ALTERA_IO_BEGIN} DO NOT REMOVE THIS LINE!
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
input			SDA;
input			SDC;
input	[0:2]	button;
output	[0:2]	led;
input			sys_clk;
input			uart_rx;
output			uart_tx;
input			lvds_tx*;
input	[3:3]	lvds_tx_n;

// {ALTERA_IO_END} DO NOT REMOVE THIS LINE!
// {ALTERA_MODULE_BEGIN} DO NOT REMOVE THIS LINE!
// {ALTERA_MODULE_END} DO NOT REMOVE THIS LINE!
endmodule









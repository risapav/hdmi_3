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
	lvds_tx,
	sys_clk,
	uart_rx,
	uart_tx,
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
output	[0:3]	lvds_tx;
input			sys_clk;
input			uart_rx;
output		uart_tx;

// {ALTERA_IO_END} DO NOT REMOVE THIS LINE!
// {ALTERA_MODULE_BEGIN} DO NOT REMOVE THIS LINE!

//frequency generator
wire	clk_50;
wire	clk_25;
wire	clk_250;
wire	clk_32;

pll	b2v_inst(
	.inclk0(sys_clk),
	.c0(clk_50),
	.c1(clk_25),
	.c2(clk_250),
	.c3(clk_32)	
	);
//end of frequency generator

//test clock
Test test(
	.CLK1(clk_25), 
	.CLK2(clk_250), 
	.CLK3(clk_32), 
	.LED1(led[0]),
	.LED2(led[1]),
	.LED3(led[2])
	);
//end of test clock

//hdmi app
App app(
	.clk_pixel(clk_25), 
	.clk_pixel_x10(clk_250), 
	.clk_audio(clk_32),
	.tmds_p(), 
	.tmds_clock_p(), 
	.tmds_n(), 
	.tmds_clock_n()
	);
//end of hdmi app


// {ALTERA_MODULE_END} DO NOT REMOVE THIS LINE!
endmodule

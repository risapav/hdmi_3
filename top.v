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
	lvds_tx_n,
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
input		[0:2]	button;
output	[0:2]	led;
output	[0:3]	lvds_tx;
output	[0:3]	lvds_tx_n;
input			sys_clk;
input			uart_rx;
output		uart_tx;

// {ALTERA_IO_END} DO NOT REMOVE THIS LINE!
// {ALTERA_MODULE_BEGIN} DO NOT REMOVE THIS LINE!

//frequency generator
wire	pixel_clk;
wire	pixel_clk10;
wire	audio_clk;
wire	atari_clk;

pll	clock(
	.inclk0(sys_clk),
	.c0(pixel_clk),
	.c1(pixel_clk10),
	.c2(audio_clk),
	.c3(atari_clk),
		
	);
//end of frequency generator

//test clock
Test test(
	.CLK1(pixel_clk), 
	.CLK2(pixel_clk10), 
	.CLK3(audio_clk), 
	.LED1(led[0]),
	.LED2(led[1]),
	.LED3(led[2])
	);
//end of test clock

//hdmi app
App app(
	.clk_pixel(pixel_clk), 
	.clk_pixel_x10(pixel_clk10), 
	.clk_audio(audio_clk),
	.tmds_p({lvds_tx[0],lvds_tx[1],lvds_tx[2]}), 
	.tmds_clock_p(lvds_tx[3]), 
	.tmds_n({lvds_tx_n[0],lvds_tx_n[1],lvds_tx_n[2]}), 
	.tmds_clock_n(lvds_tx_n[3])
	);
//end of hdmi app


// {ALTERA_MODULE_END} DO NOT REMOVE THIS LINE!
endmodule

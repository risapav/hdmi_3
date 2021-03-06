// Project F: FPGA Graphics - 640x480 Display Timings
// (C)2020 Will Green, open source hardware released under the MIT License
// Learn more at https://projectf.io


//    Name          640x480p60
//    Standard      Historical
//    VIC                    1
//    Short Name       DMT0659
//    Aspect Ratio         4:3
//
//    Pixel Clock       25.175 MHz
//    TMDS Clock       251.750 MHz
//    Pixel Time          39.7 ns ±0.5%
//    Horizontal Freq.  31.469 kHz
//    Line Time           31.8 μs
//    Vertical Freq.    59.940 Hz
//    Frame Time          16.7 ms
//
//    Horizontal Timings
//    Active Pixels        640
//    Front Porch           16
//    Sync Width            96
//    Back Porch            48
//    Blanking Total       160
//    Total Pixels         800
//    Sync Polarity        neg
//
//    Vertical Timings
//    Active Lines         480
//    Front Porch           10
//    Sync Width             2
//    Back Porch            33
//    Blanking Total        45
//    Total Lines          525
//    Sync Polarity        neg
//
//    Active Pixels    307,200 
//    Data Rate           0.60 Gbps
//
//    Frame Memory (Kbits)
//     8-bit Memory      2,400
//    12-bit Memory      3,600
//    24-bit Memory      7,200
//    32-bit Memory      9,600

`default_nettype none
`timescale 1ns / 1ps

module display_timings 
#(
	// screen coordinate width in bits
	parameter int CORDW = 10,
	
	// size of screen (including blanking)
	parameter H_RES = 800,
	parameter V_RES = 525,
	
	// size of visible screen
	parameter X_RES = 640,	//Active Pixels 
	parameter Y_RES = 480,	//Active Lines
	
	// horizontal timings
	parameter H_FRONT_PORCH	= 16,	// Front Porch
	parameter H_SYNC_WIDTH = 96,	// Sync Width
	parameter H_BACK_PORCH = 48,	// Back Porch
	
	// vertical timings
	parameter V_FRONT_PORCH = 10,	// Front Porch
	parameter V_SYNC_WIDTH = 2,	// Sync Width
	parameter V_BACK_PORCH = 33	// Back Porch
	)
	(
	input  wire logic clk_pix,   // pixel clock
	input  wire logic rst,       // reset
	output      logic [CORDW:0] sx,  // horizontal screen position
	output      logic [CORDW:0] sy,  // vertical screen position
	output      logic hsync,     // horizontal sync
	output      logic vsync,     // vertical sync
	output      logic de         // data enable (low in blanking interval)
	);
	
	localparam HA_END = X_RES - 1;	// end of active pixels
	localparam HS_STA = HA_END + H_FRONT_PORCH;	// sync starts after front porch
	localparam HS_END = HS_STA + H_SYNC_WIDTH;	// sync ends
	localparam LINE   = H_RES - 1;	// last pixel on line (after back porch)

	localparam VA_END = Y_RES - 1;	// end of active pixels
	localparam VS_STA = VA_END + V_FRONT_PORCH;	// sync starts after front porch
	
	localparam VS_END = VS_STA + V_SYNC_WIDTH;	// sync ends
	localparam SCREEN = V_RES - 1;	// last line on screen (after back porch)

	always_comb 
		begin
			hsync = ~(sx >= HS_STA && sx < HS_END);  // invert: hsync polarity is negative
			vsync = ~(sy >= VS_STA && sy < VS_END);  // invert: vsync polarity is negative
			de = (sx <= HA_END && sy <= VA_END);
		end

	// calculate horizontal and vertical screen position
	always_ff @ (posedge clk_pix)
		begin
			if (sx == LINE) 
				begin  // last pixel on line?
					sx <= 0;
					sy <= (sy == SCREEN) ? 0 : sy + 1;  // last line on screen?
				end 
			else 
				begin
					sx <= sx + 1;
				end
			if (rst) 
				begin
					sx <= 0;
					sy <= 0;
				end
		end
endmodule

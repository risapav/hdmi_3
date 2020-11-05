//App app(.pixel_clk(clk_25), .pixel_clk10(clk_250), .clk(clk_32));

module App (
	input wire rst_in,
	input wire logic clk_pix, 
	input wire logic clk_pix10, 
	input wire logic clk_audio,
	// These outputs go to your HDMI port
	output logic [0:3] tmds_p,
	output logic [0:3] tmds_n
	);

//	//generate sound
//	logic [15:0] audio_sample_word [1:0] = '{16'sd0, 16'sd0};
//	always @(posedge clk_audio)
//		audio_sample_word <= '{audio_sample_word[0] + 16'sd1, audio_sample_word[1] - 16'sd1};
//		
//	//generate picture
//	logic [23:0] rgb = 24'd0;
//	logic [9:0] cx, cy, screen_start_x, screen_start_y, frame_width, frame_height, screen_width, screen_height;
//	// Border test (left = red, top = green, right = blue, bottom = blue, fill = black)
//	always @(posedge clk_pixel)
//		rgb <= {
//			cx == screen_start_x ? ~8'd0 : 8'd0, 
//			cy == screen_start_y ? ~8'd0 : 8'd0, 
//			cx == frame_width - 1'd1 || cy == frame_height - 1'd1 ? ~8'd0 : 8'd0
//			};

	//---------------------
	// Operating Modes 
	// See Section 5.2
	//---------------------
//	logic video_data_period = 1;
//	always_ff @(posedge clk_pixel)
//		video_data_period <= cx >= screen_start_x && cy >= screen_start_y;
	
//	logic [2:0] mode = 3'd1;
//	logic [23:0] video_data = 24'd0;
//	logic [5:0] control_data = 6'd0;
//	logic [11:0] data_island_data = 12'd0;
	
	//---------------------
	// channels output
	//---------------------
//	logic [3:0] tmdsint;
//	always_ff @ (posedge clk_pix)
//		tmdsint[3] <= clk_pix;
	// If Altera synthesis, a true differential buffer is built with altera_gpio_lite from the Intel IP Catalog.
	// If simulation, a mocked signal inversion is used.
//	OBUFDS obufds(
//		.din(tmdsint), 
//		.pad_out(tmds_p), 
//		.pad_out_b(tmds_n)
//	);
	//---------------------	
	// display timings
	//---------------------
//	localparam CORDW = 10;  // screen coordinate width in bits
///	logic [CORDW-1:0] sx, sy;//coordinates in visible frame
//	logic de;
//	logic hsync, vsync;	//picture synchronzation
//
//	display_timings timings_640x480 (
//		.clk_pix,	//pixel clock
//		.rst(rst_in),	//reset
//		.sx,	// X position in full frame (visible + blanking)
//		.sy,	// Y position in full frame (visible + blanking)
//		.hsync(hsync),
//		.vsync(vsync),
//		.de	// signaling, coordinates are inside visible area
//		);
	//---------------------
	// hdmi interface
	//---------------------
	hdmi hdmi_int
	(
		input logic clk_pixel_x10,
		input logic clk_pixel,
		input logic clk_audio,
		input logic [23:0] rgb, // vstup pre video data
		input logic [AUDIO_BIT_WIDTH-1:0] audio_sample_word [1:0],

		// These outputs go to your HDMI port
		output logic [2:0] tmds_p,
		output logic tmds_clock_p,
		output logic [2:0] tmds_n,
		output logic tmds_clock_n,

		// All outputs below this line stay inside the FPGA
		// They are used (by you) to pick the color each pixel should have
		// i.e. always_ff @(posedge pixel_clk) rgb <= {8'd0, 8'(cx), 8'(cy)};
		output logic [BIT_WIDTH-1:0] cx = BIT_WIDTH'(0),
		output logic [BIT_HEIGHT-1:0] cy = BIT_HEIGHT'(0),

		// the screen is at the bottom right corner of the frame, namely:
		// frame_width = screen_start_x + screen_width
		// frame_height = screen_start_y + screen_height
		output logic [BIT_WIDTH-1:0] frame_width,
		output logic [BIT_HEIGHT-1:0] frame_height,
		output logic [BIT_WIDTH-1:0] screen_width,
		output logic [BIT_HEIGHT-1:0] screen_height,
		output logic [BIT_WIDTH-1:0] screen_start_x,
		output logic [BIT_HEIGHT-1:0] screen_start_y
	);	
	//---------------------
	//generate picture
	//---------------------
	logic [23:0] rgb = 24'd0;
	
//	wire [7:0] red = {sx[5:0] & {6{sy[4:3]==~sx[4:3]}}, 2'b00};
//	wire [7:0] green = sx[7:0] & {8{sy[6]}};
//	wire [7:0] blue = sy[7:0];

endmodule

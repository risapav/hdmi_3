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

	// 640x480 @ 59.94Hz
//	hdmi #(.VIDEO_ID_CODE(1), .VIDEO_REFRESH_RATE(59.94), .AUDIO_RATE(48000), .AUDIO_BIT_WIDTH(16)) 
//	hdmi(
//	  .clk_pixel_x10(clk_pixel_x10),
//	  .clk_pixel(clk_pixel),
//	  .clk_audio(clk_audio),
//	  .rgb(rgb),
//	  .audio_sample_word(audio_sample_word),
//	  .tmds_p(tmds_p),
//	  .tmds_clock_p(tmds_clock_p),
//	  .tmds_n(tmds_n),
//	  .tmds_clock_n(tmds_clock_n),
//	  .cx(cx),
//	  .cy(cy),
//	  .screen_start_x(screen_start_x),
//	  .screen_start_y(screen_start_y),
//	  .frame_width(frame_width),
//	  .frame_height(frame_height),
//	  .screen_width(screen_width),
//	  .screen_height(screen_height)
//	);
	
//	// 640x480 @ 60Hz
//	hdmi #(.VIDEO_ID_CODE(1), .VIDEO_REFRESH_RATE(60.00), .AUDIO_RATE(44100), .AUDIO_BIT_WIDTH(16)) 
//	hdmi(
//		.clk_pixel_x10(clk_pixel_x10),
//		.clk_pixel(clk_pixel),
//		.clk_audio(clk_audio),
//		.rgb(rgb),
//		.audio_sample_word(audio_sample_word),
//		.tmds_p(tmds_p),
//		.tmds_clock_p(tmds_clock_p),
//		.tmds_n(tmds_n),
//		.tmds_clock_n(tmds_clock_n),
//		.cx(cx),
//		.cy(cy),
//		.screen_start_x(screen_start_x),
//		.screen_start_y(screen_start_y),
//		.frame_width(frame_width),
//		.frame_height(frame_height),
//		.screen_width(screen_width),
//		.screen_height(screen_height)
//	);
	
	//---------------------
	// channels output
	//---------------------
	logic [3:0] tmdsint;
	always_ff @ (posedge clk_pix)
		tmdsint[3] <= clk_pix;
	// If Altera synthesis, a true differential buffer is built with altera_gpio_lite from the Intel IP Catalog.
	// If simulation, a mocked signal inversion is used.
	OBUFDS obufds(
		.din(tmdsint), 
		.pad_out(tmds_p), 
		.pad_out_b(tmds_n)
	);
	//---------------------	
	// display timings
	//---------------------
	localparam CORDW = 10;  // screen coordinate width in bits
	logic [CORDW-1:0] sx, sy;//coordinates in visible frame
	logic de;
	logic hsync, vsync;	//picture synchronzation

	display_timings timings_640x480 (
		.clk_pix,	//pixel clock
		.rst(rst_in),	//reset
		.sx,	// X position in full frame (visible + blanking)
		.sy,	// Y position in full frame (visible + blanking)
		.hsync(hsync),
		.vsync(vsync),
		.de	// signaling, coordinates are inside visible area
		);

	// size of screen (including blanking)
	localparam H_RES = 800;
	localparam V_RES = 525;

	// square 'Q' - origin at top-left
	localparam Q_SIZE = 32; // square size in pixels
	localparam Q_SPEED = 4; // pixels moved per frame
	logic [CORDW-1:0] qx, qy;     // square position

	logic animate;  // high for one clock tick at start of blanking
	always_comb 
		animate = (sy == 480 && sx == 0);

	// update square position once per frame
	always_ff @(posedge clk_pix) 
		begin
			if (animate) 
				begin
			if (qx >= H_RES - Q_SIZE) 
				begin
					qx <= 0;
					qy <= (qy >= V_RES - Q_SIZE) ? 0 : qy + Q_SIZE;
				end 
			else 
				begin
					qx <= qx + Q_SPEED;
				end
			end
		end

	// is square at current screen position?
	logic q_draw;
	always_comb 
		begin
			q_draw = (sx >= qx) && (sx < qx + Q_SIZE) && (sy >= qy) && (sy < qy + Q_SIZE);
		end
	//---------------------
	//generate picture
	//---------------------
	wire [7:0] red = {sx[5:0] & {6{sy[4:3]==~sx[4:3]}}, 2'b00};
	wire [7:0] green = sx[7:0] & {8{sy[6]}};
	wire [7:0] blue = sy[7:0];

endmodule

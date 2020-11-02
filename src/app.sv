//App app(.pixel_clk(clk_25), .pixel_clk10(clk_250), .clk(clk_32));

module App (clk_pixel, clk_pixel_x10, clk_audio, tmds_p, tmds_clock_p, tmds_n, tmds_clock_n);
	input clk_pixel, clk_pixel_x10, clk_audio;
	// These outputs go to your HDMI port
	output logic [2:0] tmds_p;
	output logic [2:0] tmds_n;
	output logic tmds_clock_p;
	output logic tmds_clock_n;

	//generate sound
	logic [15:0] audio_sample_word [1:0] = '{16'sd0, 16'sd0};
	always @(posedge clk_audio)
		audio_sample_word <= '{audio_sample_word[0] + 16'sd1, audio_sample_word[1] - 16'sd1};
		
	//generate picture
	logic [23:0] rgb = 24'd0;
	logic [9:0] cx, cy, screen_start_x, screen_start_y, frame_width, frame_height, screen_width, screen_height;
	// Border test (left = red, top = green, right = blue, bottom = blue, fill = black)
	always @(posedge clk_pixel)
		rgb <= {
			cx == screen_start_x ? ~8'd0 : 8'd0, 
			cy == screen_start_y ? ~8'd0 : 8'd0, 
			cx == frame_width - 1'd1 || cy == frame_height - 1'd1 ? ~8'd0 : 8'd0
			};

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
	
	// 640x480 @ 60Hz
	hdmi #(.VIDEO_ID_CODE(1), .VIDEO_REFRESH_RATE(60.00), .AUDIO_RATE(44100), .AUDIO_BIT_WIDTH(16)) 
	hdmi(
		.clk_pixel_x10(clk_pixel_x10),
		.clk_pixel(clk_pixel),
		.clk_audio(clk_audio),
		.rgb(rgb),
		.audio_sample_word(audio_sample_word),
		.tmds_p(tmds_p),
		.tmds_clock_p(tmds_clock_p),
		.tmds_n(tmds_n),
		.tmds_clock_n(tmds_clock_n),
		.cx(cx),
		.cy(cy),
		.screen_start_x(screen_start_x),
		.screen_start_y(screen_start_y),
		.frame_width(frame_width),
		.frame_height(frame_height),
		.screen_width(screen_width),
		.screen_height(screen_height)
	);

endmodule
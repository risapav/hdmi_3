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


	// picture 
	logic [9:0] cx, cy, screen_start_x, screen_start_y, frame_width, frame_height, screen_width, screen_height;
	//	//generate sound
	logic [15:0] audio_sample_word [1:0] = '{16'sd0, 16'sd0};
	always @(posedge clk_audio)
		audio_sample_word <= '{audio_sample_word[0] + 16'sd1, audio_sample_word[1] - 16'sd1};
	//---------------------
	//generate picture
	//---------------------
	logic [23:0] rgb = 24'd0;
	always_ff @(posedge clk_pix)
		begin
			rgb[23:16] <= {cx[5:0] & {6{cy[4:3]==~cx[4:3]}}, 2'b00};
			rgb[15:8] <= cx[7:0] & {8{cy[6]}};
			rgb[7:0] <= cy[7:0];
		end
	//---------------------
	// hdmi interface
	//---------------------


	hdmi hdmi_int
	(
		.clk_pixel_x10(clk_pix10),
		.clk_pixel(clk_pix),
		.clk_audio(clk_audio),
		.rgb, // vstup pre video data
		.audio_sample_word,

		// These outputs go to your HDMI port
		.tmds_p({tmds_p[2],tmds_p[1],tmds_p[0]}),
		.tmds_clock_p(tmds_p[3]),
		.tmds_n({tmds_n[2],tmds_n[1],tmds_n[0]}),
		.tmds_clock_n(tmds_n[3]),

		// All outputs below this line stay inside the FPGA
		// They are used (by you) to pick the color each pixel should have
		// i.e. always_ff @(posedge pixel_clk) rgb <= {8'd0, 8'(cx), 8'(cy)};
		.cx,
		.cy,

		// the screen is at the bottom right corner of the frame, namely:
		// frame_width = screen_start_x + screen_width
		// frame_height = screen_start_y + screen_height
		.frame_width,
		.frame_height,
		.screen_width,
		.screen_height,
		.screen_start_x,
		.screen_start_y
	);	
	
	


endmodule

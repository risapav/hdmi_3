module sawtooth 
#(
    parameter int AUDIO_BIT_WIDTH = 16,
    parameter int SAMPLE_RATE = 48000,
    parameter int WAVE_RATE = 480
)
(
    input logic clk_audio,
   // output logic [AUDIO_BIT_WIDTH-1:0] audio_sample_word = AUDIO_BIT_WIDTH'(0)
	 output logic [AUDIO_BIT_WIDTH-1:0] audio_sample_word [1:0] = AUDIO_BIT_WIDTH'(0)
);

localparam int NUM_PCM_STEPS = (AUDIO_BIT_WIDTH + 1)'(2)**(AUDIO_BIT_WIDTH + 1)'(AUDIO_BIT_WIDTH) - 1;
localparam real FREQUENCY_RATIO = real'(WAVE_RATE) / real'(SAMPLE_RATE);
localparam bit [AUDIO_BIT_WIDTH-1:0] INCREMENT = AUDIO_BIT_WIDTH'(NUM_PCM_STEPS * FREQUENCY_RATIO);

always @(posedge clk_audio)
    audio_sample_word [1]<= audio_sample_word [1] + INCREMENT;
endmodule
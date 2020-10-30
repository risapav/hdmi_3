module top(
	sys_clk,
	LED1,
	LED2,
	LED3
);


input wire	sys_clk;
output wire	LED1;
output wire	LED2;
output wire	LED3;

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



Divider	b2v_div1(
	.sig_in(clk_50),
	.sig_out(LED1));
	defparam	b2v_div1.DIVISOR = 50000000;

Divider	b2v_div2(
	.sig_in(clk_25),
	.sig_out(LED3));
	defparam	b2v_div2.DIVISOR = 50000000;

Divider	b2v_div3(
	.sig_in(clk_250),
	.sig_out(LED2));
	defparam	b2v_div3.DIVISOR = 50000000;



endmodule
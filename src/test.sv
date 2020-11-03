//Test test(.CLK1(), .CLK2(), .CLK3(), .LED1(led[0]),.LED2(led[1]),.LED3(led[2]));

module Test(CLK1, CLK2, CLK3 ,LED1,LED2,LED3);

input wire	CLK1, CLK2, CLK3;
output wire	LED1, LED2,	LED3;

Divider	b2v_div1(
	.sig_in(CLK1),
	.sig_out(LED1));
	defparam	b2v_div1.DIVISOR = 25000000;

Divider	b2v_div2(
	.sig_in(CLK2),
	.sig_out(LED2));
	defparam	b2v_div2.DIVISOR = 250000000;

Divider	b2v_div3(
	.sig_in(CLK3),
	.sig_out(LED3));
	defparam	b2v_div3.DIVISOR = 44100;

endmodule
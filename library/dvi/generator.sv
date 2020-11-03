reg [9:0] CounterX;  // counts from 0 to 799
always @(posedge pixclk) CounterX <= (CounterX==799) ? 0 : CounterX+1;

reg [9:0] CounterY;  // counts from 0 to 524
always @(posedge pixclk) if(CounterX==799) CounterY <= (CounterY==524) ? 0 : CounterY+1;

wire hSync = (CounterX>=656) && (CounterX<752);
wire vSync = (CounterY>=490) && (CounterY<492);
wire DrawArea = (CounterX<640) && (CounterY<480);

and generate some red, green and blue signals (8 bits each)...

wire [7:0] red = {CounterX[5:0] & {6{CounterY[4:3]==~CounterX[4:3]}}, 2'b00};
wire [7:0] green = CounterX[7:0] & {8{CounterY[6]}};
wire [7:0] blue = CounterY[7:0];

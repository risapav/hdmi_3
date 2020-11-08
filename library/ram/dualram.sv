module dual_ram(
    input  logic         clk,
    input  logic         wreq,
    input  logic [11:0]  waddr,
    input  logic [ 7:0]  wdata,
    input  logic [11:0]  raddr,
    output logic [ 7:0]  rdata
);
initial rdata = 8'h0;

logic [7:0] data_ram_cell [4096];
    
always @ (posedge clk)
    rdata <= data_ram_cell[raddr];

always @ (posedge clk)
    if(wreq) 
        data_ram_cell[waddr] <= wdata;

endmodule
`timescale 1ns/100ps

module crc16_tb;

reg clk, rst_n;
reg [7:0] data;
wire [15:0] crc_code;

crc16 DUT (.clk(clk), .rst_n(rst_n), .data(data), .crc_code(crc_code));

initial
begin
clk = 1'b0;
rst_n = 1'b1;
data = 8'b10110110;

forever #5 clk = ~clk;
end

initial
begin
#4 rst_n = 1'b0;
#6 rst_n = 1'b1;
#10 data = 8'b01001100;
#10 data = 8'b10110011;
#10 data = 8'b10010110;
#10 data = 8'b10100101;
#10 data = 8'b00110101;
#10 data = 8'b01101100;
#10 data = 8'b01011111;
#10 data = 8'b10000001;
#10 data = 8'b00001111;
#15 $stop;
#10 $finish;
end

endmodule 
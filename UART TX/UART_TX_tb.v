`timescale 1ns/100ps

module UART_TX_tb ;

reg clk_50M;
reg rst_n;
reg write_en;
reg [7:0] write_data;
wire uart_txd;
wire busy;

UART_TX DUT0 (.clk_50M(clk_50M),
              .rst_n(rst_n),
              .write_en(write_en),
              .write_data(write_data),
              .uart_txd(uart_txd),
              .busy(busy));
				  
initial begin
clk_50M = 1'b0;
rst_n = 1'b0;
write_en = 1'b0;
#80 rst_n = 1'b1;
#20 write_en = 1'b1;
#20 write_data = 8'b01010101;
#1000000 write_data = 8'b00110011;
#1000000 write_data = 8'b11001111;
#1000000 write_data = 8'b10100010;
#1000000 write_data = 8'b01000101;
#1000000 write_en = 1'b0;
#1000000 write_en = 1'b1;
#1000000 write_data = 8'b10011101;
#1000000 write_en = 1'b0;

#1000000 $stop;
#1000000 $finish;
end

always #10 clk_50M = ~clk_50M;

/*initial begin
#60;
rst_n = 1'b1;
#20;
write_en = 1'b1;
write_data = 8'b01010101;
#2000000;
write_data = 8'b00110011;
#2000000;
write_data = 8'b11001111;
#2000000;
write_data = 8'b10100010;
#2000000;
write_data = 4'b01000101;
#2000000;
write_en = 1'b0;

#2000000 $stop;
#2000000 $finish;
end*/

endmodule 
`timescale 1ns/100ps


module UART_RX_tb;

  reg clk_50M;
  reg rst_n;
  reg write_en;
  reg [7:0] write_data;
  
  wire uart_txd;
  wire busy;
  wire out_RX_D;
  wire [7:0] out_RX_byte;
  wire baud_rate;

  UART_TX DUT0 (
                .clk_50M(clk_50M),
                .rst_n(rst_n),
                .write_en(write_en),
                .write_data(write_data),
                .uart_txd(uart_txd),
                .busy(busy),
					 .baud_tick(baud_rate)
					 );

  UART_RX DUT1 (
                .clk(clk_50M),
					 .rst_n(rst_n),
					 .data_serial(uart_txd),
					 .out_RX_D(out_RX_D),
					 .out_RX_byte(out_RX_byte)
					 );


  initial begin
    clk_50M = 1'b0;
    rst_n = 1'b0;
    write_en = 1'b0;
    #80 rst_n = 1'b1;
    #20 write_en = 1'b1;
    #20 write_data = 8'b01010101;
	 #1000000 write_en = 1'b0;
	 #500000 write_en = 1'b1;
	 #20 write_data = 8'b00110011;
	 #1000000 write_en = 1'b0;
	 #500000 write_en = 1'b1;
	 #20 write_data = 8'b11001111;
	 #500000 rst_n = 1'b0;
	 #500000 write_data = 8'b10100010;
	 #500000 rst_n = 1'b1;
    #1000000 write_data = 8'b01000101;
	 #1000000 write_en = 1'b0; 
	 
	 #1000000 $stop;
    #1000000 $finish;
  end
  
  always #10 clk_50M = ~clk_50M;
  
 endmodule 
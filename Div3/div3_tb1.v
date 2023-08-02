`timescale 1ns/100ps

module div3_tb1;

    reg clk, rst_n;
	 wire div3_out;
	 
	 div3 D1 (.clk(clk), .rst_n(rst_n), .div3_out(div3_out));
	 
	 initial
	 begin
	     clk = 1'b0;
		  rst_n = 1'b1;
		  forever #5 clk = ~clk;
	 end
	 
	 initial
	 begin
	     #10 rst_n = 1'b0;
		  #10 rst_n = 1'b1;
		  #880 $stop;
		  #10 $finish;
	 end
	 
endmodule

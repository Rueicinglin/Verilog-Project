`timescale 1ns/100ps

module Regfile_4x8bits_tb;

      reg clk, rst;
		reg [1:0] w_addr, r_addr;
		reg w_en, r_en;
		reg [7:0] w_data;
		wire [7:0] r_data;
		
		Regfile_4x8bits Rf1 (.clk(clk),
		                     .rst(rst),
				     .w_addr(w_addr),
				     .r_addr(r_addr),
				     .w_en(w_en),
				     .r_en(r_en),
				     .w_data(w_data),
				     .r_data(r_data));
		
		initial
		begin
		     clk = 1'b0;
		     rst = 1'b0;
		     w_addr = 2'b00;
		     r_addr = 2'b00;
		     w_en = 1'b0;
		     r_en = 1'b0;
		     forever #5 clk = ~clk;
		 end
		 
		 initial
		 begin : Regfile_test
		 
		 integer i;
		 integer seed;
				
		 seed = 3;
				
		 #10 rst = 1'b1;
		 #10 rst = 1'b0;
		 #10;
		 r_en = 1'b1;
		 r_addr = 2'b00;
		 #10 r_addr = 2'b01;
		 #10 r_addr = 2'b10;
		 #10 r_addr = 2'b11;
		 #10;
		 r_en = 1'b0;
		 r_addr = 2'b00;
		 w_en = 1'b1;
		 for (i=0; i<4; i=i+1)begin
		     w_addr = i;
		     w_data = $random(seed);
		     #10;
		 end
		 w_en = 1'b0;
		 r_en = 1'b1;
		 #10 r_addr = 2'b01;
		 #10 r_addr = 2'b10;
		 #10 r_addr = 2'b11;
		 #10;
		 r_en = 1'b0;
		 rst = 1'b1;
		 #10;
		 rst = 1'b0;
		 r_en = 1'b1;
		 r_addr = 2'b00;
		 #10 r_addr = 2'b01;
		 #10 r_addr = 2'b10;
	         #10 r_addr = 2'b11;
		 #10 r_en = 1'b0;
		 #50 $stop;
		 #10 $finish;
		 end
				
endmodule 

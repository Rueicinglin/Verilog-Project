`timescale 1ns / 1ps

module Edge_detect_tb;

// Inputs
reg clk;
reg rst_n;
reg a;

// Outputs
wire rise;
wire down;
  
 Edge_detect DUT (
                  .clk(clk), 
                  .rst_n(rst_n),
			         .a(a),
			         .rise(rise),
			         .down(down)
                 );
 
 initial begin
 
 clk = 1'b0;
 rst_n = 1'b0;
 #20;
 rst_n = 1'b1;
 
 #500 $stop;
 #10 $finish;
 
 end
 
 initial begin
 
 forever #5 clk = ~clk;
 
 end
 
 always @(posedge clk, negedge rst_n)begin
 
 if (!rst_n)begin
 a <= 1'b0;
 end
 else begin
 a <= $random%2;
 end
 
 end
      
endmodule 
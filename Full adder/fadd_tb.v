`timescale 1ns/100ps

module fadd_tb;

    reg a, b, cin;
	 wire sum, cout;
	 
	 fadd FA1 (.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));
	 
	 initial
	 begin
	     a = 1'b0;
		  b = 1'b0;
		  cin = 1'b0;
		  #5 cin = 1'b1;
		  #5;
		  b = 1'b1;
		  cin = 1'b0;
		  #5 cin = 1'b1;
		  #5;
		  a = 1'b1;
		  b = 1'b0;
		  cin = 1'b0;
		  #5 cin = 1'b1;
		  #5;
		  b = 1'b1;
		  cin = 1'b0;
		  #5 cin = 1'b1;
		  #5 $stop;
		  #5 $finish;
	 end
	 
	 initial
	 begin
	    $monitor($time, "a=%b b=%b cin=%b sum=%b cout=%b", a, b, cin, sum, cout);
	 end
	 
endmodule

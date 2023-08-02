`timescale 1ns/100ps

module mux_4to1_tb;

      reg [3:0] a, b, c, d;
		reg [1:0] sel;
		wire [3:0] out;
		
		mux_4to1 m1 (.a(a), .b(b), .c(c), .d(d), .sel(sel), .out(out));
		
		initial
		begin : mux4to1
		     integer i;
			  integer seed1, seed2, seed3, seed4;
			  
			  seed1 = 1;
			  seed2 = 2;
			  seed3 = 3;
			  seed4 = 4;
			  
			  for (i=0; i<50; i=i+1)
			  begin
			       a = $random(seed1);
					 b = $random(seed2);
					 c = $random(seed3);
					 d = $random(seed4);
					 sel = $random(seed1);
					 #5;
			  end
			  #5 $stop;
			  #5 $finish;
	   end
		
		initial
		begin
		     $monitor ($time, " a= %d b= %d c= %d d= %d sel= %d out= %d", a, b, c, d, sel, out);
		end

endmodule
		
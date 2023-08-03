module Regfile_4x8bits #(parameter Depth = 4, Width = 8, Addr = 2) (
                                                                    input clk, rst,
			                                            input [Width-1:0] w_data,
						                    input [Addr-1:0] w_addr, r_addr,
								    input w_en, r_en,
								    output [Width-1:0] r_data
								   );
		
		 reg [Width-1:0] regf [Depth-1:0];
		 
		 assign r_data = (r_en) ? regf[r_addr] : {Width{1'bz}};
		 
		 always @(posedge clk, posedge rst)
                 begin : reg_file
		 
                 integer i;
		 
	         if (rst)
				
	            for (i=0; i<Depth; i=i+1)
		        regf[i] <= {Width{1'b0}};
			   
		    else if (w_en)
	                regf[w_addr] <= w_data;
		 end
		 
endmodule 

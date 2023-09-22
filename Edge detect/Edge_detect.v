module Edge_detect (

            input clk,
            input rst_n,
            input a,

            output rise,
            output down

            );

reg [1:0] state, nstate;
reg a_temp;

parameter Check = 2'b00, Rse = 2'b01, Dow = 2'b10;

always @(state, a, a_temp)begin

       case (state)
           Check: nstate = (a > a_temp) ? Rse : ((a < a_temp) ? Dow : Check);
           Rse: nstate = a ? Check : Dow;
           Dow: nstate = a ? Rse : Check;
	   default: nstate = Check;
       endcase

end

always @(posedge clk, negedge rst_n)begin
      if (!rst_n)begin
           state <= Check;
      end
      else begin
           state <= nstate;
      end
end

always @(posedge clk, negedge rst_n)begin
      if (!rst_n)begin
	   a_temp <= 1'b0;
      end
      else begin
	   a_temp <= a;
      end
end

assign rise = (state == Rse);
assign down = (state == Dow);

endmodule

module Multiplier (
                   input clk, rst,
                   input load,
                   input [3:0] m1, m2,
                   output reg done,
                   output reg [7:0] out
                  );

reg [7:0] in1;
reg [3:0] in2;
reg [8:0] reg_out;
reg [2:0] cnt;
reg [1:0] state, nstate;

parameter init = 2'b00, Add = 2'b01, Shift = 2'b10, Sum = 2'b11;


//state description
always @(state, load, in2, cnt)
begin
     case (state)
         init: nstate = load ? Add : init;
	 Add: nstate = (in2 == 4'd0) ? Sum : Shift;
         Shift: nstate = (cnt == 3'd4) ? Sum : Add;
         Sum: nstate = load ? Add : init;
     endcase
end

always @(posedge clk, posedge rst)
begin
     if (rst)
       state <= init;
     else
       state <= nstate;
end

// load input, shift register
always @(posedge clk, posedge rst)
begin
     if (rst)
     begin
          in1 <= 8'd0;
          in2 <= 4'd0;
     end
     else if (state == init || state == Sum)
     begin
          if (load)
          begin
               in1 <= {{4{m1[3]}}, m1};
               in2 <= m2;
          end
          else
          begin
               in1 <= 8'd0;
               in2 <= 4'd0;
          end
     end
	  else if (state == Shift)
	  begin
	       in1 <= (cnt == 3'd4) ? in1 : (in1 << 1);
	       in2 <= (cnt == 3'd4) ? in2 : (in2 >> 1);
	  end
end

//multiplier
always @(posedge clk, posedge rst)
begin
     if (rst)
       reg_out <= 9'd0;
     else if (state == init || state == Sum)
       reg_out <= 9'd0;
     else
     begin
          if (state == Add)
            reg_out <= in2[0] ? ((cnt == 3'd3) ? (reg_out + (~in1 + 8'd1)) : (reg_out + in1)) : reg_out;
          else
            reg_out <= reg_out;
     end
end

// counter
always @(posedge clk, posedge rst)
begin
     if (rst)
       cnt <= 3'd0;
	  else
	  begin
	  if (state == init || state == Sum)
              cnt <= 3'd0;
          else if (state == Add)
              cnt <= cnt + 3'd1;
	  end
end

//Output
always @(posedge clk, posedge rst)
begin
    if (rst)
	 begin
	      out <= 8'd0;
	      done <= 1'b0;
	 end
	 else
	 begin
	      if (nstate == Sum)
	      begin
	           out <= reg_out[7:0];
		   done <= 1'b1;
	      end
	      else
	      begin
		   done <= 1'b0;
	      end
    end
end

endmodule 

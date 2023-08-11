module Unsigned_divider #(parameter Width = 4) (

input [Width-1:0] a, b,
output reg [Width-1:0] D, R,
output reg err

);

reg [2*Width-1:0] temp;
reg [2*Width-1:0] temp_a;
reg [2*Width-1:0] temp_b;
wire [Width-1:0] b_n;

assign b_n = ~b + 1;

always @(a, b, b_n, temp_a, temp_b)
begin : divider

integer i;

temp_a = {{Width{1'b0}}, a};
temp_b = {1'b1, b_n, {(Width-1){1'b0}}};
D = 0;
err = 1'b0;

for (i=Width; i>0; i=i-1)
begin
     if (b == 0)
	  begin
	       err = 1'b1;
			 D = 0;
			 R = 0;
	  end
	  else
	  begin
	       if (temp_a == 0)
	       begin
	            D[i-1] = 1'b0;
			      temp = temp;
	       end
	       else
	       begin
               temp = temp_a + temp_b;
	            if (temp[2*Width-1])
	            begin
	                 temp_a = temp_a;
			           temp_b = {1'b1, temp_b[2*Width-1:1]};
			           D[i-1] = 1'b0;
	            end
	            else
	            begin
			           temp_a = temp;
	                 temp_b = {1'b1, temp_b[2*Width-1:1]};
	                 D[i-1] = 1'b1;
	            end
			 end
	  end
end

if (temp_a == 0) R = temp[Width-1:0];
else R = temp_a[Width-1:0];

end	

endmodule 
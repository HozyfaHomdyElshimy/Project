
module Floatingnmulsub
                        (input [31:0]A,
                         input [31:0]B,
                         input [31:0]C,
                         input clk,
                         input  wire                       EN ,
                         output reg [31:0] result);
wire [31:0] result1;
wire [31:0] result2;

FloatingMultiplication M1(.clk(clk),.A(A),.B(B),.result(result1));   

//assign result1 = {~result1[31],result1[30:0]}
                      
FloatingAddition A1(.clk(clk),.A({~result1[31],result1[30:0]}),.B(C),.result(result2));

always @(*)
begin
if (!EN)
    begin
      
      result  <= 'b0 ;
      	
	 end
   else
     begin
       result = result2;
     end
     end

endmodule
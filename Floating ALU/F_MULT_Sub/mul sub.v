`timescale 1ns / 1ps
module Floating__mulsub
                        (input [31:0]A,
                         input [31:0]B,
                         input [31:0]C,
                         input clk,
                         input  wire                       EN ,
                         output reg [31:0] result);
wire [31:0] result1;
wire [31:0] result2;

     
FloatingMultiplication M11(.clk(clk),.A(A),.B(B),.result(result1));  
//assign C = {~C[31],C[30:0]};                       
FloatingAddition A11(.clk(clk),.A(result1),.B({~C[31],C[30:0]}),.result(result2));
 	
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
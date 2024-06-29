`timescale 1ns / 1ps
module FloatSqrt_TB ();   
reg [31:0] A;
reg overflow, underflow, exception;
wire [31:0] result;
real  value;

  reg                      clk  ;
  reg                       EN ;

Floating_Sqrt F_Mult (.clk(clk),.EN(EN),.A(A),.result(result));

initial  
begin
  $display("\t\t  Time a result ");
 $monitor("%d %b %b ", $time , A, result);
 
 //initial values
clk = 1'b0;
EN = 1'b1 ;

A = 32'h41c80000;  // 25
#20
A = 32'h42040000;  // 33
#20
A = 32'h42aa0000;  // 85
#20
A = 32'h42b80000;  // 92
end
always #20 clk = ~clk;

endmodule
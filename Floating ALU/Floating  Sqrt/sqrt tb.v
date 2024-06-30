`timescale 1ns / 1ps
module F_SqrT_TB ();   
reg [31:0] A;
reg overflow, underflow, exception;
wire [31:0] result;
real  value;

  reg                      CLK  ;
  reg                       EN ;

F_Sqrt F_Mult (
.A(A),
.RST(RST),
.CLK(CLK),
.overflow(overflow),
.underflow(underflow),
.exception(exception),
.EN(EN),
.OUT_FSQRT(result)
);

initial  
begin
  $display("\t\t  Time a result ");
 $monitor("%d %b %b ", $time , A, result);
 
 //initial values
CLK = 1'b0;
EN = 1'b1 ;

A = 32'h41c80000;  // 25
#20
A = 32'h42040000;  // 33
#20
A = 32'h42aa0000;  // 85
#20
A = 32'h42b80000;  // 92
end
always #5 CLK = ~CLK;

endmodule
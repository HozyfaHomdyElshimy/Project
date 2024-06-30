`timescale 1ns / 1ps

module F_mulsub_TB ();
  
reg [31:0]              A,B,C;
reg                       RST,clk;
reg                       EN ;

wire [31:0]            result;
real                    value;

F_MulSub M (.CLK(clk),.RST(RST),.EN(EN),.A(A),.B(B),.C(C),.OUT_FMSUB(result));

initial  
begin
 $display("\t\t  Time a b c result ");
 $monitor("%d %b %b %b %b ", $time , A, B, C, result);
 
 
//initial values
clk = 1'b0;
EN = 1'b1 ;
 
A = 32'b0_10000001_00001100110011001100110;  // 4.2 
B = 32'b0_10000000_10011001100110011001100;  // 3.2
C = 32'b0_10000000_10011001100110011001100;  // 3.2
#20
A = 32'b0_01111110_01010001111010111000010;  // 0.66
B = 32'b0_01111110_00000101000111101011100;  // 0.51
C = 32'b0_10000000_10011001100110011001100;  // 3.2
#20
A = 32'b0_10000001_10011001100110011001100;  // 6.4
B = 32'b1_01111110_00000000000000000000000;  // -0.5
C = 32'b0_10000000_10011001100110011001100;  // 3.2

end
always #5 clk = ~clk;
endmodule
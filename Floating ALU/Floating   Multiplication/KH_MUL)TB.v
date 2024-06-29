`timescale 1ns / 1ps

module F_Mul_Tb ();   
reg [31:0] A,B;
reg clk,EN;
wire   zero,infinity,Flag_Mul;
wire [31:0] OUT_MUL;
real  value;

FloatingMultiplication F_Mult
 (
 
 .A(A),
 .B(B),
 .CLK(clk),
 .RST(RST),
 .EN(EN),
 .zero(zero),
 .Flag_Mul(Flag_Mul),
 .infinity(infinity),
 .OUT_MUL(OUT_MUL)
 );
 


 
initial  
begin
   
  $dumpfile("FloatingMultiplication.vcd");
  $dumpvars ;
  
 $display("\t\t  Time a b result ");
 $monitor("%d %b %b %b ", $time , A, B, OUT_MUL); 
 
 
 
  
 //initial values
clk = 1'b1;
RST = 1'b1;
EN= 1'b1;

A = 32'b0_11111111_00000000000000000000000;  // +inf
B = 32'b0_10000000_10011001100110011001100;  // 3.2
#20

A = 32'b01000001101100100110011001100110; // 22.3
B = 32'b10111111000000000000000000000000;  // -0.5
#20

A = 32'b01000001011111001100110011001101; // 15.8
B = 32'b00111111101001100110011001100110;  // 1.3
#20

A = 32'b1_11111111_00000000000000000000000;  // -inf
B = 32'b1_10000000_10011001100110011001100;  // -3.2
#20

A = 32'b00000000000000000000000000000000;  // 0 
B = 32'b0_10000000_10011001100110011001100;  // 3.2
#20

A = 32'b0_01111110_01010001111010111000010;  // 0.66
B = 32'b0_01111110_00000101000111101011100;  // 0.51
#20
A = 32'b1_10000001_10011001100110011001100;  // -6.4 
B = 32'b1_01111110_00000000000000000000000;  // -0.5
#20
A = 32'b0_10000001_10011001100110011001100;  // 6.4
B = 32'b1_01111110_00000000000000000000000;  // -0.5

end

// Clock Generator with 100 KHz (10 us)
  always  
   begin
    #6  clk = ~ clk ;
    #4  clk = ~ clk ;
   end

endmodule

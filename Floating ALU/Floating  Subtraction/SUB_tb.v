module FSUB_TB ();

reg [31:0] A,B;
wire [31:0] result;

  reg                      clk,RST  ;
  reg                       EN ;


F_SUB F_subb (.clk(clk),.RST(RST),.EN(EN),.A(A),.B(B),.OUT_SUB(result));


initial  
begin
 $display("\t\t  Time a b result ");
 $monitor("%d %b %b %b ", $time , A, B, result);
 
  //initial values
clk = 1'b0;
EN = 1'b1 ;
 
A = 32'b11000000000000000000000000000000;  // -2 
B = 32'b00111111100000000000000000000000;  // 1
#20
A = 32'b1_10000001_00001100110011001100110;  // -4.2 
B = 32'b0_10000000_10011001100110011001100;  // 3.2
#20
A = 32'b1_01111110_01010001111010111000010;  // -0.66
B = 32'b0_01111110_00000101000111101011100;  // 0.51
#20
A = 32'b1_10000001_10011001100110011001100;  // -6.4 
B = 32'b1_01111110_00000000000000000000000;  // -0.5
#20
A = 32'b0_10000001_10011001100110011001100;  // 6.4
B = 32'b1_01111110_00000000000000000000000;  // -0.5

end
always #5 clk = ~clk;
endmodule


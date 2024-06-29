`timescale 1ns / 1ps

module Floatingmulsub
                        (input [31:0]A,
                         input [31:0]B,
                         input [31:0]C,
                         
input  wire                       CLK ,
input  wire                       RST ,
input  wire                       EN ,


 
                         output reg  [31:0] OUT_FMSUB ,
                         output reg Flag_FMSUB);
                         
wire [31:0] result1;
wire [31:0] result2;
wire      zero;
wire      infinity;


//sequential always
always @ (posedge CLK or negedge RST)
 begin 
   if (!RST)
     begin
      OUT_FMSUB  <= 'b0 ;
      Flag_FMSUB <= 'b0 ;	
	 end
   else
     begin   
       
       if (EN)
    begin
      
  
      
 FloatingMultiplication U_FloatingMultiplication (CLK,RST,infinity,zero,EN,A,B,Flag_MUL,OUT_MUL);
     
//FloatingMultiplication MUL(.CLK(CLK),.A(A),.B(B),.OUT_MUL(result1));  
//assign C = {~C[31],C[30:0]};                       
//FloatingAddition ADD(.clk(clk),.A(result1),.B({~C[31],C[30:0]}),.OUT_ADD(OUT_FMSUB));
FloatingAddition F_Ad (CLK,RST,EN,A,B,C,Flag_Add,OUT_ADD);


       end
   end
end
endmodule


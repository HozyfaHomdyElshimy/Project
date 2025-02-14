`timescale 1ns / 1ps

module F_MulSub
                        (input [31:0]A,
                         input [31:0]B,
                         input [31:0]C,
                         
input  wire                       CLK ,
input  wire                       RST ,
input  wire                       EN ,

            
                  output reg  [31:0] OUT_FMSUB 
                 );
                      
                      
                         
wire [31:0] result1,OUT_ADD;
wire [31:0] result2,OUT_MUL;
wire      zero,MUL_enable;
wire      infinity;


//sequential always
always @ (posedge CLK or negedge RST)
 begin 
   if (!RST)
     begin
      OUT_FMSUB  <= 'b0 ;
	 end
   else
     begin   
       
       if (EN)
    begin
      
  OUT_FMSUB  <= 'b0 ;
      
       end
   end
end
 F_Mul  U_F_Mul  (
.A(A),
.B(B),
.RST(RST),
.CLK(CLK),
.EN(EN),
.OUT_MUL(result1),
.infinity(infinity),
.zero(zero)
);
     
//FloatingMultiplication MUL(.CLK(CLK),.A(A),.B(B),.OUT_MUL(result1));  
//assign C = {~C[31],C[30:0]};                       
//FloatingAddition ADD(.clk(clk),.A(result1),.B({~C[31],C[30:0]}),.OUT_ADD(OUT_FMSUB));
F_Addition   F_ad
(
.A(A),
.B(C),
.RST(RST),
.CLK(CLK),
.EN(EN),
.OUT_ADD(OUT_ADD)
);   

endmodule


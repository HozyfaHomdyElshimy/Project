`timescale 1ns / 1ps

module FloatingSqrt

                    (
                    input [31:0]                       A,
                     input                             CLK,
                     input  wire                       RST ,
                     input  wire                       EN ,
                     output                  overflow,
                     output                 underflow,
                     output                 exception,
                     output reg [31:0]           OUT_FSQRT  );
         
         
                       
reg [31:0]   result;  

                   
wire [7:0] Exponent;
wire [22:0] Mantissa;
wire        Sign;
wire [31:0] temp1,temp2,temp3,temp4,temp5,temp6,temp7,temp8,temp;
wire [31:0] x0,x1,x2,x3;
wire [31:0] sqrt_1by05,sqrt_2,sqrt_1by2;
wire [7:0] Exp_2,Exp_Adjust;
wire        remainder;
wire          pos;
assign x0 = 32'h3f5a827a;
assign sqrt_1by05 = 32'h3fb504f3;  // 1/sqrt(0.5)
assign sqrt_2 = 32'h3fb504f3;
assign sqrt_1by2 = 32'h3f3504f3;
assign Sign = A[31];
assign Exponent = A[30:23];
assign Mantissa = A[22:0];

/*----First Iteration----*/
FloatingDivision D1(.CLK(CLK),.RST(RST),.EN(EN),.A({1'b0,8'd126,Mantissa}),.B(x0),.OUT_DIV(temp1));
FloatingAddition A1(.CLK(CLK),.RST(RST),.EN(EN),.A(temp1),.B(x0),.OUT_ADD(temp2));
assign x1 = {temp2[31],temp2[30:23]-1,temp2[22:0]};

/*----Second Iteration----*/
FloatingDivision D2(.CLK(CLK),.RST(RST),.EN(EN),.A({1'b0,8'd126,Mantissa}),.B(x1),.OUT_DIV(temp3));
FloatingAddition A2(.CLK(CLK),.RST(RST),.EN(EN),.A(temp3),.B(x1),.OUT_ADD(temp4));
assign x2 = {temp4[31],temp4[30:23]-1,temp4[22:0]};

/*----Third Iteration----*/
FloatingDivision D3(.CLK(CLK),.RST(RST),.EN(EN),.A({1'b0,8'd126,Mantissa}),.B(x2),.OUT_DIV(temp5));
FloatingAddition A3(.CLK(CLK),.RST(RST),.EN(EN),.A(temp5),.B(x2),.OUT_ADD(temp6));
assign x3 = {temp6[31],temp6[30:23]-1,temp6[22:0]};
FloatingMultiplication M1(.A(x3),.B(sqrt_1by05),.OUT_MUL(temp7));

assign pos = (Exponent>=8'd127) ? 1'b1 : 1'b0;
assign Exp_2 = pos ? (Exponent-8'd127)/2 : (Exponent-8'd127-1)/2 ;
assign remainder = (Exponent-8'd127)%2;
assign temp = {temp7[31],Exp_2 + temp7[30:23],temp7[22:0]};

//assign temp7[30:23] = Exp_2 + temp7[30:23];
FloatingMultiplication M2( .CLK(CLK),.RST(RST),.EN(EN),.A(temp),.B(sqrt_2),.OUT_MUL(temp8));



always @ (*)
begin 
  if (EN)
    begin
if (remainder)
    begin
 result = temp8 ;
    end
    else
     begin
  result = temp;
     end
    end
   
    else
     begin
  result = 0;
     end
   end	

//sequential always
always @ (posedge CLK or negedge RST)
 begin 
   if (!RST | !EN)
     begin
     OUT_FSQRT <= 'b0 ;
   	 end
   else
     begin   
      OUT_FSQRT  <= result ;
	   end
 end	
    



endmodule




module FloatingAddition

                        
(input [31:0]   A, 
 input [31:0]   B,       
              
input  wire                       CLK ,
input  wire                       RST ,
input  wire                       EN ,
output reg  [31:0]          OUT_ADD ,
output reg                 Flag_ADD);


//internal sigs.......

 reg  [31:0]    result;
 reg        Flag_ADD_com;
reg [23:0] A_Mantissa,B_Mantissa;
reg [23:0]    Temp_Mantissa;
reg [22:0]       Mantissa;
reg [7:0]        Exponent;
reg            Sign;
wire            MSB;
reg [7:0]   A_Exponent,B_Exponent,Temp_Exponent,diff_Exponent;
reg         A_sign,B_sign,Temp_sign;
reg [32:0]      Temp;
reg             carry;
reg [2:0]     one_hot;
reg             comp;
reg [7:0] exp_adjust;


//sequential always
always @ (posedge CLK or negedge RST)
 begin 
   if (!RST)
     begin
     OUT_ADD <= 'b0 ;
      Flag_ADD <= 'b0 ;	
	 end
   else
     begin   
      OUT_ADD  <= result ;
       Flag_ADD <= Flag_ADD_com ;
	 end
 end	





always @(*)
begin

comp =  (A[30:23] >= B[30:23])? 1'b1 : 1'b0;
  
A_Mantissa = comp ? {1'b1,A[22:0]} : {1'b1,B[22:0]};
A_Exponent = comp ? A[30:23] : B[30:23];
A_sign = comp ? A[31] : B[31];
  
B_Mantissa = comp ? {1'b1,B[22:0]} : {1'b1,A[22:0]};
B_Exponent = comp ? B[30:23] : A[30:23];
B_sign = comp ? B[31] : A[31];

diff_Exponent = A_Exponent-B_Exponent;
B_Mantissa = (B_Mantissa >> diff_Exponent);
{carry,Temp_Mantissa} =  (A_sign ~^ B_sign)? A_Mantissa + B_Mantissa : A_Mantissa-B_Mantissa ; 
exp_adjust = A_Exponent;
if(carry)
    begin
        Temp_Mantissa = Temp_Mantissa>>1;
        exp_adjust = exp_adjust+1'b1;
    end
else
    begin
   if(!Temp_Mantissa[23])
        begin
           Temp_Mantissa = Temp_Mantissa<<1;
           exp_adjust =  exp_adjust-1'b1;
        end
    end
 if (EN)
    begin
	Sign = A_sign;
Mantissa = Temp_Mantissa[22:0];
Exponent = exp_adjust;
        result = {Sign,Exponent,Mantissa};

    end
  else
    begin
       result = 0;
     end
    
    
    







//Temp_Mantissa = (A_sign ~^ B_sign) ? (carry ? Temp_Mantissa>>1 : Temp_Mantissa) : (0); 
//Temp_Exponent = carry ? A_Exponent + 1'b1 : A_Exponent; 
//Temp_sign = A_sign;
//result = {Temp_sign,Temp_Exponent,Temp_Mantissa[22:0]};
end



endmodule

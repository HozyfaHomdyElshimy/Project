
module F_nmulsub
                        (input [31:0]A,
                         input [31:0]B,
                         input [31:0]C,
                         input CLK,RST,
                         input  wire   EN ,
                         output reg [31:0] result);


wire [31:0] result1;
wire [31:0] result2;
wire    infinity, zero;

F_Mul M1
 (
.A(A),
.B(B),
.RST(RST),
.CLK(CLK),
.EN(EN),
.OUT_MUL(result1),
.infinity(infinity),
.zero(zero)
);   

//assign result1 = {~result1[31],result1[30:0]}
                      
F_Addition A1
(
.A({~result1[31],result1[30:0]}),
.B(C),
.RST(RST),
.CLK(CLK),
.EN(EN),
.OUT_ADD(result2)
); 


always @(posedge CLK or negedge RST)
begin
if (!EN || !RST)
    begin
      
      result  <= 'b0 ;
      	
	 end
   else
     begin
       result = result2;
     end
     end

endmodule
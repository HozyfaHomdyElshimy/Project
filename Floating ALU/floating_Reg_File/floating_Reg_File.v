module FReg_File #(parameter WIDTH = 32 , WID_IN = 5)
  (
input    wire                CLK,
input    wire                RST, 
input  wire                 Reg_Wr,

 input  wire [WID_IN-1:0]          Rs1_rd,
 input  wire [WID_IN-1:0]          Rs2_rd,
 input  wire [WID_IN-1:0]          Rs3_rd,
 input  wire [WID_IN-1:0]          Rd_Wr,
 input  wire [WIDTH-1:0]           Rd_In,

 output wire  [WIDTH-1:0]      Rs1_Out,
 output wire  [WIDTH-1:0]      Rs2_Out,
 output wire  [WIDTH-1:0]      Rs3_Out  
  );
    
  reg [WIDTH-1:0] Float [0:31];
  integer i = 0;
  
 
  always @(posedge CLK or negedge RST)
 begin
   if(!RST)                 
    begin
	  for (i = 0;i < WIDTH;i = i + 1) 
	     begin
   Float[i] <= 'b0;
		    end
		 end
		 else if (Reg_Wr && Rd_Wr != 5'b00000) 
	      begin
  Float[Rd_Wr] <= Rd_In;
         end
     
  end
  
assign Rs1_Out = Float[Rs1_rd];
assign Rs2_Out = Float[Rs2_rd];
assign Rs3_Out = Float[Rs3_rd];
 
endmodule

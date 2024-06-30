
module FMVWX 
            (input [63:0] rs,
  
input  wire                       CLK ,
input  wire                       RST ,
input  wire                       EN ,

                         output reg  [31:0] OUT_FMV_W_X 
                         );
  
  
  //sequential always
always @ (posedge CLK or negedge RST)
 begin 
   if (!RST)
     begin
      OUT_FMV_W_X  <= 'b0 ;
	 end
   else
     begin   
      
      //always @(*)
//begin
if (EN)
    begin
      
        OUT_FMV_W_X = rs[31:0];
  
    end
  end
end 
endmodule



module FMVWX_TB ();
  reg  [63:0] rs;
  
  
  wire [31:0] OUT_FMV_W_X;
  wire Flag_FMV_W_X ;
  reg                       CLK ;
  reg                       RST ;
  reg                       EN ;
  
  
  FMVWX FM (.CLK(CLK),.RST(RST),.EN(EN),.rs(rs),.Flag_FMV_W_X(Flag_FMV_W_X),.OUT_FMV_W_X(OUT_FMV_W_X));


initial  
begin
  $dumpfile("FMVWX.vcd");
  $dumpvars ;
  
 $display("\t\t  Time rs  OUT_FMV_W_X ");
 $monitor("%d %b %b  ", $time , rs, OUT_FMV_W_X); 
 
  
    
 
 
 //initial values
CLK = 1'b0;
RST = 1'b1;
EN = 1'b1 ;

rs= 64'b1100000011001100110011001100110011000001011010010110000001000010;  // -14.586 

#20
rs = 64'b1100000101101001011000000100001000111111001010001111010111000010;  // 0.66

#20
rs = 64'b0011111100101000111101011100001011000000110011001100110011001100;  // -6.4 

#20
rs = 64'b0011111100101000111101011100001001000000110011001100110011001100;  // 6.4


end
always #20 CLK = ~CLK;
endmodule

module FSGNJX (rs1,rs2,OUT_FSGNJX,CLK,RST,EN);
  
  input [31:0] rs1,rs2;
  input     CLK,RST,EN;
  output reg [31:0] OUT_FSGNJX;
 
   wire [31:0] rd;
  assign rd = {rs1[31] ^ rs2[31], rs1[30:0]};

  //sequential always
always @ (posedge CLK or negedge RST)
 begin 
   if (!RST | !EN)
     begin
     OUT_FSGNJX <= 'b0 ;
   	 end
   else
     begin   
      OUT_FSGNJX  <= rd ;
	   end
 end	
  
endmodule




////////////// T B //////////////
module FSGNJX_TB ();
  reg  [31:0] rs1,rs2;
  wire [31:0] rd;
  reg clk;
  
  FSGNJX X (rs1,rs2,OUT_FSGNJX,CLK,RST,EN);
  
  
initial  
begin
 $display("\t\t  Time rs1 rs1 result ");
 $monitor("%d %b %b %b ", $time , rs1, rs2, rd); 
rs1= 32'b0_10000001_00001100110011001100110;  // 4.2 
rs2 = 32'b0_10000000_10011001100110011001100;  // 3.2
#20
rs1 = 32'b0_01111110_01010001111010111000010;  // 0.66
rs2 = 32'b0_01111110_00000101000111101011100;  // 0.51
#20
rs1 = 32'b1_10000001_10011001100110011001100;  // -6.4 
rs2 = 32'b1_01111110_00000000000000000000000;  // -0.5
#20
rs1 = 32'b0_10000001_10011001100110011001100;  // 6.4
rs2 = 32'b1_01111110_00000000000000000000000;  // -0.5

end

endmodule

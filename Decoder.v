module F_Decoder (

input  wire [4:0] IN ,
output reg  [31:0] OUT
);


always @(*)
  begin
  OUT = 32'b0000_0000_0000_0000_0000_0000_0000_0000 ;
    case (IN)
    5'b00000 : OUT = 32'b0000_0000_0000_0000_0000_0000_0000_0001 ;
    5'b00001 : OUT = 32'b0000_0000_0000_0000_0000_0000_0000_0010 ;         
    5'b00010 : OUT = 32'b0000_0000_0000_0000_0000_0000_0000_0100 ;   
    5'b00011 : OUT = 32'b0000_0000_0000_0000_0000_0000_0000_1000 ; 
    5'b00100 : OUT = 32'b0000_0000_0000_0000_0000_0000_0001_0000 ;
    5'b00101 : OUT = 32'b0000_0000_0000_0000_0000_0000_0010_0000 ;
    5'b00110 : OUT = 32'b0000_0000_0000_0000_0000_0000_0100_0000 ; 
    5'b00111 : OUT = 32'b0000_0000_0000_0000_0000_0000_1000_0000 ; 
    5'b01000 : OUT = 32'b0000_0000_0000_0000_0000_0001_0000_0000 ;  
    5'b01001 : OUT = 32'b0000_0000_0000_0000_0000_0010_0000_0000 ;  
    5'b01010 : OUT = 32'b0000_0000_0000_0000_0000_0100_0000_0000 ;
    5'b01011 : OUT = 32'b0000_0000_0000_0000_0000_1000_0000_0000 ;
    5'b01100 : OUT = 32'b0000_0000_0000_0000_0001_0000_0000_0000 ;
    5'b01101 : OUT = 32'b0000_0000_0000_0000_0010_0000_0000_0000 ;
    5'b01110 : OUT = 32'b0000_0000_0000_0000_0100_0000_0000_0000 ;
    5'b01111 : OUT = 32'b0000_0000_0000_0000_1000_0000_0000_0000 ;
    5'b10000 : OUT = 32'b0000_0000_0000_0001_0000_0000_0000_0000 ;
    
    default  : OUT = 32'b0000_0000_0000_0000_0000_0000_0000_0000 ;
   
   endcase
 end 
 
 
 endmodule
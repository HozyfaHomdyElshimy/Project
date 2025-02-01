module RAM_TB #(parameter width=15 )();

reg clk , rst ,write_en;
reg  [width:0] data_in;
reg  [3:0] addr;
wire  [width:0] data_out; 

 initial
 begin

clk='b0; rst='b1;  #20;
clk='b1; rst='b0; data_in='b1011101; addr='b1001;   write_en='b1; 
#50
write_en='b0;
#50 $stop;

 end
  
  
 always #5 clk =~clk;
 
RAM  DUT (clk , rst ,write_en,addr,data_in,data_out );  
  
endmodule

 module Parameter();
  //Parameters
  parameter WIDTH=32; //32 or 64
  parameter EXP_WIDTH=8;
  parameter SIG_WIDTH=23;
  parameter BIAS=127;
  
  //localparam ADD_WIDTH=3*(SIG_WIDTH+1)+3;
  localparam SHAMT_WIDTH=6;
  parameter CLA_GRP_WIDTH=25;
  parameter N_CLA_GROUPS=2;
  
  localparam ADDER_WIDTH=N_CLA_GROUPS*CLA_GRP_WIDTH;
  
  parameter code_NaN=32'b0_11111111_1000_0000_0000_0000_0000_000;
  parameter code_PINF=32'b0_11111111_0000_0000_0000_0000_0000_000;
  parameter code_NINF=32'b1_11111111_0000_0000_0000_0000_0000_000;
  
endmodule
  
  


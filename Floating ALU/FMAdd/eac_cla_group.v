module eac_cla_group(a, b, GG, GP, s, s_plus_one);
  //End Around Carry adder -- CLA group
  
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
  
  input [CLA_GRP_WIDTH-1:0] a, b;
  output [CLA_GRP_WIDTH-1:0] s, s_plus_one;
  output GG, GP; //Group generate and group propagate
  //Generate, propagate vectors
  reg [CLA_GRP_WIDTH-1:0] G, P, sum, sum1;
  reg [CLA_GRP_WIDTH:0]  carry_in, carry_in1;
  
  wire cin;
  assign s = sum;
  assign s_plus_one = sum1;
  assign GG = carry_in[CLA_GRP_WIDTH];
  assign GP = &P;
  
  integer i;
  
  always @ (*) begin
     //Propagates, generates
     for(i=0;i<CLA_GRP_WIDTH;i=i+1) begin
        G[i] = a[i] & b[i];
        P[i] = a[i] ^ b[i];
        
     end
     
     //Carry
     carry_in[0] = 0;
     for(i=1;i<=CLA_GRP_WIDTH;i=i+1) begin
             carry_in[i]=G[i-1] | (carry_in[i-1] & P[i-1]) ;
     end
     
     carry_in1[0] = 1;
     for(i=1;i<=CLA_GRP_WIDTH;i=i+1) begin
             carry_in1[i]=G[i-1] | (carry_in1[i-1] & P[i-1]) ;
     end

     
  end
  
  //Sum
  always @ (*) begin
    for(i=0;i<CLA_GRP_WIDTH;i=i+1) begin
      sum[i] = carry_in[i] ^ P[i];
      sum1[i] = carry_in1[i] ^ P[i];
    end
  end
  
  
endmodule

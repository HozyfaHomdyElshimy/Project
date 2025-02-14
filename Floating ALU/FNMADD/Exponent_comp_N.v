module exponentComparison(aExp, bExp, cExp, shamt, cIsSubnormal, res_exp, cExpIsSmall);
   
   //Parameters
  parameter WIDTH=32; //32 or 64
  parameter EXP_WIDTH=8;
  parameter SIG_WIDTH=23;
  parameter BIAS=127;
  
  //localparam ADD_WIDTH=3*(SIG_WIDTH+1)+3;
  localparam SHAMT_WIDTH=6;

	//I/O decalarations
  input [EXP_WIDTH-1:0] aExp, bExp, cExp;
  input cIsSubnormal;
  output [SHAMT_WIDTH-1:0] shamt;
  output [EXP_WIDTH-1:0] res_exp;
  output cExpIsSmall;
  
  wire [EXP_WIDTH-1:0] product_exp;
  
  wire [SHAMT_WIDTH-1:0] shamt_internal, shamt_pre;
  
  assign product_exp = aExp + bExp;
  assign shamt_pre = product_exp - BIAS - cExp + (SIG_WIDTH+6);
  assign shamt_internal = (cExp > (product_exp - BIAS + (SIG_WIDTH+6)))?0:shamt_pre;
  
  assign shamt=(cIsSubnormal)? shamt_internal+1:shamt_internal;
  
  assign cExpIsSmall = ((product_exp - BIAS) >= cExp);
  
  assign res_exp= ( cExpIsSmall )?product_exp-BIAS:cExp;//Result exponent
  
endmodule




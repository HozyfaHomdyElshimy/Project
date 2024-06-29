module normalizeAndExpUpdate(prenormalized, lza_shamt, cExpIsSmall, shamt, exp_correction, normalized, res_exp, normalized_exp);
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
  
  input [3*(SIG_WIDTH+1)+7:0] prenormalized;//80-bit
  input [5:0] lza_shamt, shamt;
  input cExpIsSmall;
  input [EXP_WIDTH-1:0] res_exp;
  output [EXP_WIDTH-1:0] normalized_exp;
  
  
  output exp_correction;
  output [(SIG_WIDTH+1)+2:0] normalized; //27-bit
  
  wire [3*(SIG_WIDTH+1)+7:0] normalized1,normalized2;  //80-bit
  //If cExp was small, the top 24 bits only  so add 24
  //to lza_shamt
  wire shamt_portion = (shamt>=SIG_WIDTH+4);
  wire [5:0] lza_corrected1 = (shamt_portion)? lza_shamt+(SIG_WIDTH+3) : shamt;
  wire [EXP_WIDTH-1:0] exp_update1 = (shamt_portion)? res_exp-lza_shamt+3+cExpIsSmall-(shamt==27) : res_exp+1;
  
  //Big shift
  assign normalized1 = prenormalized << lza_corrected1;
  
  //Correction shamt
  reg [1:0] corr_shamt;
  reg [EXP_WIDTH-1:0] exp_update2;
  always @ * begin
     casex(normalized1[3*(SIG_WIDTH+1)+7:3*(SIG_WIDTH+1)+7-2])//79:77
       3'b001: begin corr_shamt=2;  exp_update2 = exp_update1 - 2; end
       3'b01x: begin corr_shamt=1; exp_update2 = exp_update1 - 1; end
       3'b000: begin corr_shamt=3; exp_update2 = exp_update1 - 3; end
       default: begin corr_shamt=0; exp_update2 = exp_update1; end
     endcase
  end
  //LZA correction shift
  assign normalized2 = normalized1<< corr_shamt;

  assign normalized = normalized2[3*(SIG_WIDTH+1)+7:2*(SIG_WIDTH+1)+5]; //79:54 -- 27-bit
  assign exp_correction = (~normalized1[3*(SIG_WIDTH+1)+7]);
  
  assign normalized_exp = exp_update2;
  
endmodule


module align(C, shamt, CAligned,  sticky);
  
    //Parameters
  parameter WIDTH=32;      //32 or 64
  parameter EXP_WIDTH=8;
  parameter SIG_WIDTH=23;
  parameter BIAS=127;
  localparam SHAMT_WIDTH=6; //localparam ADD_WIDTH=3*(SIG_WIDTH+1)+3;

   //I/O decalarations
  input [SIG_WIDTH:0] C;
  input [SHAMT_WIDTH-1:0] shamt;
  output [3*(SIG_WIDTH+1)+6:0] CAligned;//79-bit
  output sticky;
  
  //the for - loop create numbers of assign statements
  wire [SIG_WIDTH+2*(SIG_WIDTH+1):0] T;
  genvar i;
  generate
    for(i=2*(SIG_WIDTH+1);i<=SIG_WIDTH+2*(SIG_WIDTH+1);i=i+1) begin: gen_T
      assign T[i]=|C[i-2*(SIG_WIDTH+1):0];
    end
  endgenerate
  
  assign CAligned = {1'b0,C,{(2*(SIG_WIDTH+1)+2+2+2){1'b0}}} >> shamt; //1, 24, 54
  assign sticky = (shamt< 2*(SIG_WIDTH+1) + 7 /*55*/)?1'b0:T[shamt];

  
endmodule



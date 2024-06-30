`timescale 1us/1us

module FALU_TOP_TB();

parameter    OP_DATA_WIDTH   = 32 ;
parameter    CLK_PERIOD   = 10 ;


		   
/*************************************************************************/
/******************************** IN/OUTPUTs Signals *********************/
/*************************************************************************/


reg [OP_DATA_WIDTH-1:0]      A   ;
reg   [OP_DATA_WIDTH-1:0]    B   ;
reg [OP_DATA_WIDTH-1:0]      C   ;
reg   [4:0]             ALU_FUNC ;
reg                          CLK ;
reg                          RST ;
reg   [2*OP_DATA_WIDTH-1:0] A_64;
 wire   [OP_DATA_WIDTH-1:0] OUT_FMADD; 
 wire   [OP_DATA_WIDTH-1:0] OUT_FNMADD;
 wire   [OP_DATA_WIDTH-1:0] OUT_FMSUB;
 wire   [OP_DATA_WIDTH-1:0] OUT_FNMSUB;
 wire   [OP_DATA_WIDTH-1:0] OUT_ADD;
 wire   [OP_DATA_WIDTH-1:0]  OUT_SUB;
 wire   [OP_DATA_WIDTH-1:0]  OUT_MUL;
 wire   [OP_DATA_WIDTH-1:0] OUT_DIV;
 wire   [OP_DATA_WIDTH-1:0]  OUT_FSQRT;
 wire   [OP_DATA_WIDTH-1:0] OUT_FSGNJ;
 wire   [OP_DATA_WIDTH-1:0] OUT_FSGNJN;
 wire   [OP_DATA_WIDTH-1:0] OUT_FSGNJX;
 wire   [OP_DATA_WIDTH-1:0] OUT_MIN_MAX;
 wire         [9:0]         OUT_CLASS;
 wire   [(2*OP_DATA_WIDTH-1):0] OUT_FMV_X_W;
 wire   [OP_DATA_WIDTH-1:0] OUT_FMV_W_X;
 
 
 initial
  begin
    $dumpfile("floating_ALU_TOP.vcd");
    $dumpvars ;

//initial values
CLK = 1'b0;
RST = 1'b1;

// RST Activation
#5
RST = 1'b0 ;

// RST De-activation
#5
RST = 1'b1 ;
 
 
 
 
 $display ("*** TEST CASE 0 (F_MUL_ADDITION(FMADD) ***");

A = 32'b0_10000001_00001100110011001100110;  // 4.2 
B = 32'b0_00000000_00000000000000000000000;  // 0
C = 32'b0_10000000_10011001100110011001100;  // 3.2
ALU_FUNC = 5'b00000; 

#CLK_PERIOD

if (OUT_FMADD == 32'b0_10000000_10011001100110011001100 )
      begin
       $display ("Function IS True") ; 
     end
   else
      begin
       $display ("Function IS Failed") ;
      end 



   
    $display ("*** TEST CASE 1 (FN_MUL_ADDITION(FNMADD) ***");
 

A = 32'b0_10000001_00001100110011001100110;  // 4.2 
B = 32'b0_00000000_00000000000000000000000;  // 0
C = 32'b0_10000000_10011001100110011001100;  // 3.2
 ALU_FUNC = 5'b00001;   
#CLK_PERIOD

if (OUT_FNMADD == 32'b1_10000000_10011001100110011001100 )
       $display ("Function IS True") ;
   else
      begin
       $display ("Function IS Failed") ;
      end


 
  $display ("*** TEST CASE 2 (F_MULT_subtraction) ***");
    
A = 32'b0_10000001_00001100110011001100110;  // 4.2 
B = 32'b0_10000000_10011001100110011001100;  // 3.2
C = 32'b0_10000000_10011001100110011001100;  // 3.2

ALU_FUNC = 5'b00010;
#CLK_PERIOD


if (OUT_FMSUB == 32'b0_10000010_01000111101011100001000 )
       $display ("Function IS True") ;
   else
      begin
       $display ("Function IS Failed") ;
      end 


 
  $display ("*** TEST CASE 3 (FN_MULT_subtraction) ***");
    
A = 32'b0_01111110_01010001111010111000010;  // 0.66
B = 32'b0_01111110_00000101000111101011100;  // 0.51
C = 32'b0_10000000_10011001100110011001100;  // 3.2

ALU_FUNC = 5'b00011; 

#CLK_PERIOD


 $display ("*** TEST CASE 4 (Floating  Addition) ***");
    
A = 32'b0_10000001_10011001100110011001100;  // 6.4
B = 32'b1_01111110_00000000000000000000000;  // -0.5

ALU_FUNC = 5'b00100; 

#CLK_PERIOD

$display ("*** TEST CASE 5 (Floating  Subtraction) ***");
    
A = 32'b0_10000001_10011001100110011001100;  // 6.4
B = 32'b1_01111110_00000000000000000000000;  // -0.5

ALU_FUNC = 5'b00101; 

#CLK_PERIOD

$display ("*** TEST CASE 6 (Floating   multiplication) ***");
    
A = 32'b0_10000001_10011001100110011001100;  // 6.4
B = 32'b1_01111110_00000000000000000000000;  // -0.5

ALU_FUNC = 5'b00110; 

#CLK_PERIOD

$display ("*** TEST CASE 7 (Floating  Division) ***");
    
A = 32'b01000001110010000000000000000000;  // 25
B = 32'b01000000101000000000000000000000;  // 5

ALU_FUNC = 5'b00111; 

#CLK_PERIOD
if (OUT_FNMADD == 32'b01000000101000000000000000000000 )
       $display ("Function IS True") ;
   else
      begin
       $display ("Function IS Failed") ;
      end


$display ("*** TEST CASE 8 (Floating       Sqrt  ) ***");
    
A = 32'b01000001110010000000000000000000;  // 25


ALU_FUNC = 5'b01000; 

#CLK_PERIOD

$display ("*** TEST CASE 9 (Floating     SGNJ  ) ***");
    
A = 32'b0_10000001_10011001100110011001100;  // 6.4
B = 32'b1_01111110_00000000000000000000000;  // -0.5

ALU_FUNC = 5'b01001; 

#CLK_PERIOD

$display ("*** TEST CASE 10 (Floating     SGNJN  ) ***");
    
A = 32'b0_10000001_10011001100110011001100;  // 6.4
B = 32'b1_01111110_00000000000000000000000;  // -0.5

ALU_FUNC = 5'b01010; 

#CLK_PERIOD

$display ("*** TEST CASE 11 (Floating     SGNJX  )***");
    
A = 32'b0_10000001_10011001100110011001100;  // 6.4
B = 32'b1_01111110_00000000000000000000000;  // -0.5

ALU_FUNC = 5'b01011; 

#CLK_PERIOD

$display ("*** TEST CASE 12 (Floating   min_max  ) ***");
    
A = 32'b0_10000001_10011001100110011001100;  // 6.4
B = 32'b1_01111110_00000000000000000000000;  // -0.5

ALU_FUNC = 5'b01100; 

#CLK_PERIOD

$display ("*** TEST CASE 13 (Floating     class  ) ***");
    
A = 32'b0_10000001_10011001100110011001100;  // 6.4


ALU_FUNC = 5'b01101; 

#CLK_PERIOD

$display ("*** TEST CASE 14 (Floating   MOVE_X_W  ) ***");
    
A = 32'b0_10000001_10011001100110011001100;  // 6.4


ALU_FUNC = 5'b01110; 

#CLK_PERIOD

$display ("*** TEST CASE 15 (Floating   MOVE_W_X  ) ***");
    
A_64 = 64'b1100000011001100110011001100110011000001011010010110000001000010;


ALU_FUNC = 5'b01111; 

#CLK_PERIOD


 
 
 
 
 
 
  #100 $stop;  //finished with simulation 
  end
  
  
  // Clock Generator with 100 KHz (10 us)
  always  
   begin
    #4  CLK = ~ CLK ;
    #6  CLK = ~ CLK ;
   end
 
 // instantiate Design Unit
floating_ALU_TOP # (.OP_DATA_WIDTH(OP_DATA_WIDTH)) DUT (
.A(A), 
.B(B),
.C(C),
.ALU_FUNC(ALU_FUNC),
.CLK(CLK),
.RST(RST),
.A_64(A_64),
.OUT_FMADD(OUT_FMADD),
.OUT_FNMADD(OUT_FNMADD),
.OUT_FMSUB(OUT_FMSUB),
.OUT_FNMSUB(OUT_FNMSUB),
.OUT_ADD(OUT_ADD),
.OUT_SUB(OUT_SUB),
.OUT_MUL(OUT_MUL),
.OUT_DIV(OUT_DIV),
.OUT_FSQRT(OUT_FSQRT),
.OUT_FSGNJ(OUT_FSGNJ),
.OUT_FSGNJN(OUT_FSGNJN),
.OUT_FSGNJX(OUT_FSGNJX),
.OUT_MIN_MAX(OUT_MIN_MAX),
.OUT_CLASS(OUT_CLASS),
.OUT_FMV_X_W(OUT_FMV_X_W),
.OUT_FMV_W_X(OUT_FMV_W_X)
);

 
 
 
 endmodule

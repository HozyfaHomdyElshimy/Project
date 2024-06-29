
module  floating_ALU_TOP # ( parameter OP_DATA_WIDTH = 32 )
  (
  
input  wire [OP_DATA_WIDTH-1:0]    A   ,
input  wire [OP_DATA_WIDTH-1:0]    B   ,
input  wire [OP_DATA_WIDTH-1:0]    C   ,
input  wire [4:0]             ALU_FUNC ,
input  wire                        CLK ,
input  wire                        RST ,
input  wire   [(2*OP_DATA_WIDTH-1):0] A_64,
output wire   [OP_DATA_WIDTH-1:0] OUT_FMADD, 
output wire   [OP_DATA_WIDTH-1:0] OUT_FNMADD,
output wire   [OP_DATA_WIDTH-1:0] OUT_FMSUB,
output wire   [OP_DATA_WIDTH-1:0] OUT_FNMSUB,
output wire   [OP_DATA_WIDTH-1:0] OUT_ADD,
output wire   [OP_DATA_WIDTH-1:0]  OUT_SUB,
output wire   [OP_DATA_WIDTH-1:0]  OUT_MUL,
output wire   [OP_DATA_WIDTH-1:0] OUT_DIV,
output wire   [OP_DATA_WIDTH-1:0]  OUT_FSQRT,
output wire   [OP_DATA_WIDTH-1:0] OUT_FSGNJ,
output wire   [OP_DATA_WIDTH-1:0] OUT_FSGNJN,
output wire   [OP_DATA_WIDTH-1:0] OUT_FSGNJX,
output wire   [OP_DATA_WIDTH-1:0] OUT_MIN_MAX,
output wire         [9:0]         OUT_CLASS,
output wire   [(2*OP_DATA_WIDTH-1):0] OUT_FMV_X_W,
output wire   [OP_DATA_WIDTH-1:0] OUT_FMV_W_X
  
  );
  
 
///////// ...................internal connection...............//////////////////

wire                  FMADD_enable ;
wire                  FNMADD_enable ;
wire                  FMSUB_enable ;
wire                  FNMSUB_enable ;
wire                  ADD_enable ;
wire                  SUB_enable ;
wire                  MUL_enable ;
wire                  DIV_enable ;
wire                  FSQRT_enable ;
wire                  FSGNJ_enable ;
wire                  FSGNJN_enable ;
wire                  FSGNJX_enable ;
wire                  MIN_MAX_enable ;
wire                  CLASS_enable ;
wire                  FMV_X_W_enable ;
wire                  FMV_W_X_enable ;  
  
  
wire                            RND;
wire                       Flag_Add;
wire                       infinity;
wire                           zero;
wire                           exception;
wire                           underflow;
wire                           overflow;
wire    [OP_DATA_WIDTH-1:0]       MAX;
wire    [OP_DATA_WIDTH-1:0]       MIN;
wire                            Funct;
wire                           p_normal;
wire                           n_normal;
wire                           p_subnormal;
wire                           n_subnormal;
wire                           p_zero;
wire                           n_zero;
wire                           p_infinity;
wire                           n_infinity;
wire                           qnan;
wire                           snan;




  
  ///********************************************************///
//////////////////////////// Decoder //////////////////////////
///********************************************************///
  
F_Decoder FU0 (
.IN(ALU_FUNC),
.OUT({FMV_W_X_enable,FMV_X_W_enable,CLASS_enable,MIN_MAX_enable,FSGNJX_enable,FSGNJN_enable,FSGNJ_enable,FSQRT_enable,DIV_enable,MUL_enable,SUB_enable,ADD_enable,FNMSUB_enable,FMSUB_enable,FNMADD_enable,FMADD_enable})
);  
  
///********************************************************///
//////////////////////////// F_MUL_ADDITION(FMADD) ///////////
///********************************************************///
    
fpfma    #(.WIDTH(OP_DATA_WIDTH)) FU0_fpfma 
(
.A(A),
.B(B),
.C(C),
.RST(RST),
.clk(CLK),
.rnd(RND),
.enable_FMADD(FMADD_enable),
.OUT_FMADD(OUT_FMADD)

);    


///********************************************************///
//////////////////////////// FN_MUL_ADDITION(FNMADD) /////////
///********************************************************///
    
fpfNma   #(.WIDTH(OP_DATA_WIDTH)) FU0_fpfNma  
(
.A(A),
.B(B),
.C(C),
.RST(RST),
.clk(CLK),
.rnd(RND),
.enable_FNMADD(FNMADD_enable),
.OUT_FNMADD(OUT_FNMADD)

);    
  
///********************************************************///
//////////////////////////// (F_MULT_subtraction) ////////////
///********************************************************///
                      
Floatingmulsub   FU0_Floatingmulsub
(
.A(A),
.B(B),
.C(C),
.RST(RST),
.clk(CLK),
.EN(FMADD_enable),
.OUT_FMSUB(OUT_FMSUB)

);      


///********************************************************///
//////////////////////////// (FN_MULT_subtraction) ///////////
///********************************************************///
                      
Floatingnmulsub   FU0_Floatingnmulsub
(
.A(A),
.B(B),
.C(C),
.RST(RST),
.clk(CLK),
.EN(FNMADD_enable),
.OUT_FNMSUB(OUT_FNMSUB)

);      
  


///********************************************************///
//////////////////////////// (Floating  Addition) ////////////
///********************************************************///
                      
FloatingAddition   FU0_FloatingAddition
(
.A(A),
.B(B),
.RST(RST),
.clk(CLK),
.EN(ADD_enable),
.OUT_ADD(OUT_ADD),
.Flag_ADD(Flag_ADD)
);     


///********************************************************///
//////////////////////////// (Floating  Subtraction) /////////
///********************************************************///
                      
Floatingkha   FU0_Floatingkha
(
.A(A),
.B(B),
.RST(RST),
.clk(CLK),
.EN(SUB_enable),
.OUT_SUB(OUT_SUB)
);        


///********************************************************///
//////////////////////////// (Floating   multiplication) //////
///********************************************************///
                      
FloatingMultiplication   FU0_FloatingMultiplication
(
.A(A),
.B(B),
.RST(RST),
.clk(CLK),
.EN(MUL_enable),
.OUT_MUL(OUT_MUL),
.infinity(infinity),
.zero(zero)
);        
  
///********************************************************///
//////////////////////////// (Floating  Division) ////////////
///********************************************************///
                        
                      
FloatingDivision   FU0_FloatingDivision
(
.A(A),
.B(B),
.RST(RST),
.clk(CLK),
.EN(DIV_enable),
.overflow(overflow),
.underflow(underflow),
.exception(exception),
.OUT_DIV(OUT_DIV)
);          


///********************************************************///
////////////////////// (Floating       Sqrt  ) //////////////
///********************************************************///
                      
FloatingSqrt   FU0_FloatingSqrt
(
.A(A),
.RST(RST),
.CLK(CLK),
.overflow(overflow),
.underflow(underflow),
.exception(exception),
.EN(FSQRT_enable),
.OUT_FSQRT(OUT_FSQRT)
);     


///********************************************************///
////////////////////// (Floating     SGNJ  ) /////////////////
///********************************************************///

                      
FSGNJ   FU0_FSGNJ
(
.rs1(rs1),
.rs2(rs2),
.RST(RST),
.CLK(CLK),
.EN(FSGNJ_enable),
.OUT_FSGNJ(OUT_FSGNJ)
);         
  
  
///********************************************************///
////////////////////// (Floating     SGNJN  ) /////////////////
///********************************************************///

                      
FSGNJN   FU0_FSGNJN
(
.rs1(rs1),
.rs2(rs2),
.RST(RST),
.CLK(CLK),
.EN(FSGNJN_enable),
.OUT_FSGNJN(OUT_FSGNJN)
);           

///********************************************************///
////////////////////// (Floating     SGNJX  ) ////////////////
///********************************************************///

                      
FSGNJX   FU0_FSGNJX
(
.rs1(rs1),
.rs2(rs2),
.RST(RST),
.CLK(CLK),
.EN(FSGNJX_enable),
.OUT_FSGNJX(OUT_FSGNJX)
);           

///********************************************************///
////////////////////// (Floating   min_max  ) ////////////////
///********************************************************///

min_max_proj #(.XLEN(OP_DATA_WIDTH))   FU0_min_max_proj
(
.frs1(A),
.frs2(B),
.rst_n(RST),
.CLK(CLK),
.Funct(Funct),
.MIN(MIN),
.MAX(MAX),
.En(MIN_MAX_enable),
.frd(OUT_MIN_MAX)
);         
  
 ///********************************************************///
////////////////////// (Floating     class  ) ////////////////
///********************************************************///

                      
fclass   FU0_fclass
(
.f(A),
.snan(snan),
.qnan(qnan),
.n_infinity(n_infinity),
.p_infinity(p_infinity),
.n_zero(n_zero),
.p_zero(p_zero),
.n_subnormal(n_subnormal),
.p_subnormal(p_subnormal),
.n_normal(n_normal),
.rd(OUT_CLASS),
.p_normal(p_normal),
.RST(RST),
.CLK(CLK),
.EN(CLASS_enable)
);           
 
  
  ///********************************************************///
////////////////////// (Floating   MOVE_X_W  ) ////////////////
///********************************************************///

                      
FMVXW   FU0_FMVXW
(
.rs(A),
.RST(RST),
.CLK(CLK),
.EN(FMV_X_W_enable),
.rd(OUT_FMV_X_W)
);    
  
  
  
///********************************************************///
////////////////////// (Floating   MOVE_W_X  ) ////////////////
///********************************************************///

                      
FMVWX   FU0_FMVWX
(
.rs(A_64),
.RST(RST),
.CLK(CLK),
.EN(FMV_W_X_enable),
.rd(OUT_FMV_W_X)
);    
  
  
endmodule

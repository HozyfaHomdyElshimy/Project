module t_fpfma();
    
 //Parameters
  parameter WIDTH=32; //32 or 64

  reg [WIDTH-1:0]   A,B,C;
  reg [31:0]      x_ideal;
  reg [23:0]        x_man;
  reg [7:0]      idealExp;
  reg [1:0]           rnd;  
  reg                 clk;
  wire [WIDTH-1:0] result;
  
  
  wire [23:0] aSig={1'b1,A[22:0]};
  wire [23:0] bSig={1'b1,B[22:0]};
  wire [23:0] cSig={1'b1,C[22:0]};
  
  
  wire [7:0] aExp = A[30:23]; 
  wire [7:0] bExp = B[30:23];
  wire [7:0] cExp = C[30:23];
  
    
  wire [49:0] productSig = aSig * bSig;
  wire [7:0] productExp = aExp + bExp;
  
  
  
  fpfma     UUT(
  .A(A), 
  .B(B), 
  .C(C),
  .rnd(rnd),
  .clk(clk), 
  .result(result)
  );
  
  integer fd;
  initial begin
    rnd=2'b01;
   // fd=$fopen("sub_inputs.txt", "r");//fd=$fopen("testInputs.txt", "r");
                 //op=0;
  end
  
  
  integer i;
  
  always @ (*) 
  begin
    for(i=0;i<100;i=i+1) begin
      $display(fd, "%x %x %x %x", A, B, C, x_ideal);
     idealExp=x_ideal[30:23];
     x_man={1'b1,x_ideal[22:0]};
      #5
     $display("A=%x, B=%x, C=%x, X=%x\n", A, B, C, x_ideal);
   end
 
  end
 
 wire sig_compare = (UUT.renormalized!=x_man);
 wire res_compare = result!=x_ideal;

  initial begin
    //A=32'b1000_1100_1001_0001_1110_1001_1110_0000;     //-2.2481546e-31
    //B=32'b0010_1000_1000_0011_1010_1000_0000_0010;     //1.4616783e-14
    //C=32'b0110_0100_1101_1001_0110_0000_1110_0001;     //3.2079395e22
                                                       //result=-5.511198e32
                                                       
                                                       
    A=32'b01000000010011100110011001100110;  
    B=32'b01000001000110100101111000110101;     
    C=32'b11000000101101001011110001101010;     
                                                       
                                                        
    #5;
    for (i=0;i<25453;i=i+1) begin
      A = A + 1;
      B = B + 1;
      #5;
    end
    
  end
 
 
	always #5 clk = ~clk;

 
endmodule


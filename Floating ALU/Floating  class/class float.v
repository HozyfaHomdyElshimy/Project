module fclass      (f,RST,CLK,EN, snan, qnan, n_infinity,p_infinity, n_zero,p_zero,n_subnormal, p_subnormal,p_normal, n_normal,rd);
  
  input  wire                       CLK ;
  input  wire                       RST ;
  input  wire                       EN;
  input [31:0] f;
  output snan, qnan, n_infinity,p_infinity, n_zero,p_zero,n_subnormal, p_subnormal,p_normal, n_normal ;
  output reg [9:0] rd;
  
  reg [9:0] OUT_CLASS;
  wire expones, expzeros, sigzeros;
  
  assign expones = &f[30:23];
  assign expzeros = ~|f[30:23];
  assign sigzeros = ~|f[22:0];
   
  assign snan             =  expones      & ~sigzeros  & ~f[22];
  assign qnan             =  expones      &  f[22];
  assign p_infinity       =  ~f[31]  &   expones      &  sigzeros ;
  assign n_infinity       = f[31] & expones      &  sigzeros ;
  assign p_zero           = ~f[31]& expzeros     &  sigzeros ;
  assign n_zero           =  f[31] & expzeros     &  sigzeros;
  assign p_subnormal        = ~f[31]& expzeros     & ~sigzeros ;
  assign n_subnormal        =  f[31] & expzeros     & ~sigzeros ;
  assign p_normal           = ~f[31]& ~expones     & ~expzeros ;
  assign n_normal           =  f[31] & ~expones     & ~expzeros ;
  
  
  //sequential always
always @ (posedge CLK or negedge RST)
 begin 
   if (!RST)
     begin
     rd <= 'b0 ;
	 end
   else
     begin   
      rd  <= OUT_CLASS ;
       
	 end
 end	
  
  always@(*)
  begin
     if (EN)
    begin
    OUT_CLASS=0;
    if (n_infinity)
    begin
OUT_CLASS[0]=0;
  end
else if(n_normal)
begin
OUT_CLASS[1]=1;
end 
else if(n_subnormal)
begin
OUT_CLASS[2]=1;
end 
else if(n_zero)
begin
OUT_CLASS[3]=1;
end
else if(p_zero)
begin
OUT_CLASS[4]=1;
end
else if(p_subnormal)
begin
OUT_CLASS[5]=1;
end
else if(p_normal)
begin
OUT_CLASS[6]=1;
end
else if(p_infinity)
begin
OUT_CLASS[7]=1;
end
else if(snan)
begin
OUT_CLASS[8]=1;
end
else if(qnan)
begin
OUT_CLASS[9]=1;
end
  end
  else
     begin   
     OUT_CLASS=0;
	 end
  end
  
  

  
  
endmodule


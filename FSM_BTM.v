/////////////////////////////////
////////// ..RTL_CODE.. /////////
/////////////////////////////////

module Lock #(parameter width = 3)
   (
    input          clk,
    input      in0,in1,
    input        reset,
    output reg    out
    ); 

localparam A= 'b000,
           B= 'b001,
           C= 'b010,
           D= 'b011,
           E= 'b100,
           F= 'b101;
             
             //internal sig (in0=0 ,in1=1)
  /*      reg  in_0,in_1;   
     initial begin in_0 ='b0; in_1='b1; end
assign in_0 = in0;
assign in_1 = in1;
*/
    reg  [width-1:0] current_state , next_state;
 // State flip-flops with asynchronous reset
always @ ( posedge clk or posedge reset)
begin
if(reset) 
    begin
current_state <=  A;
        end
 else 
     begin
   current_state <= next_state;
         end
end  

 // State transition logic
always @ (*)
begin 
case(current_state)
    A: begin    
        if(in0)
            begin
           next_state= B;
            end
        else
             begin
           next_state= A;
         
            end
       end
     B: begin    
        if(in1)
           next_state= C;
        else
            next_state= A;
       end
      C: begin    
        if(in0)
           next_state= D;
        else
            next_state= A;
       end
    D: begin    
        if(in1)
           next_state= E;
        else
            next_state= A;
       end
    E: begin    
        if(in1)
           next_state= F;
        else
            next_state= A;
       end
  
   F: begin    
            next_state= A;
            end
    default: begin    
            next_state= A;  
            end      
endcase
end  

 //Output logic
 always @(*)
 begin
  case(current_state)
  A     : begin
              out   =  1'b0 ;          
             end
  B     : begin
              out   =  1'b0 ;
             end    
  C     : begin
              out   =  1'b0 ;       
             end
  D     : begin
              out   =  1'b0 ;       
             end
  E     : begin
              out   =  1'b0 ;           
             end             
  F     : begin
              out   =  1'b1 ;    
             end    
  default  : begin
              out   =  1'b0 ;
             end              
  endcase
 end  
    
endmodule

/////////////////////////////////
////// ..TEST BENCH_CODE.. //////
/////////////////////////////////

`timescale 1ns/1ps
module Lock_TB #(parameter Clk_Period=10)();

//localparam Clk_Period=10;

    reg          clk;
    reg      in0,in1;
    reg        reset;
    wire         out;
 


//initial block..

initial 
  begin                                          //password = 01011 and out = 1
    $dumpfile("Lock.vcd") ;
    $dumpvars ;
    //initial values..
    in0 = 0 ;                             
    in1 = 0 ;     
    reset = 1'b0 ;    //off
    clk = 1'b1 ; 
    #Clk_Period;
    
    reset = 1 ;    //on
    #Clk_Period;
    
     reset = 0 ;    //off
    #Clk_Period;
//password is true
    in0 = 1 ;    //press
    in1 = 0 ;    //NOT press 
    #Clk_Period;
    
     in1 = 1 ;    //press 
     in0 = 0 ;    //NOT press
    #Clk_Period;
    
     in0 = 1 ;    //press 
     in1 = 0 ;    //NOT press
    #Clk_Period;
    
    in1 = 1 ;    //press
    in0 = 0 ;    //NOT press 
    #Clk_Period;       //out=0
    
    in1 = 1 ;    //press 
    in0 = 0 ;    //NOT press
    #Clk_Period;       //out=0
    
    in1 = 0 ;    //press 
    in0 = 0 ;    //NOT press
    #(Clk_Period*3);       // out=1    ...7
    
    //password is FAIL
    in0 = 1 ;    //press
    in1 = 0 ;    //NOT press 
    #Clk_Period;
    
     in1 = 1 ;    //press 
     in0 = 0 ;    //NOT press
    #Clk_Period;
    
     in0 = 1 ;    //press 
     in1 = 1 ;    //press
    #Clk_Period;
    
    in1 = 0 ;    //NOT press
    in0 = 1 ;    // press 
    #Clk_Period;       //out=0
    
    in1 = 0 ;    //NOT press 
    in0 = 1 ;    // press
    #Clk_Period;       // out=0
 
	#(Clk_Period*10);
	$stop;
	
   end
  
  
// Clock Generator (type: Delay Control) 
  always #(Clk_Period/2) clk = !clk ;
  
 /* always
  begin
  #(Clk_Period/2) ;
    clk =0;
  #(Clk_Period/2) ;
    clk =1;
  end*/
  
  
// instaniate design instance 
  Lock DUT (
    .in0(in0),
    .in1(in1),
    .reset(reset),
    .clk(clk),
	  .out(out)
    
  );

endmodule

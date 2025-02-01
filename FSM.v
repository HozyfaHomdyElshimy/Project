/*module fsm (
input clk, rst, in ,
output  reg out
);

localparam st0= 'b00,
           st1= 'b00;

reg  [:] current_state , next_state;

always @ ( posedge clk or posedge rst)
begin
if(rst) 
current_state <=  st0;
 else 
   current_state <= next_state;
end  

always @ (*)
begin
if(000) 
case()
  00:    ;
  00:    ;
  
endcase
end  


endmodule*/


module top_module(
    input clk,
    input in,
    input areset,
    output reg out); //

    // State transition logic

    // State flip-flops with asynchronous reset

    // Output logic
localparam A= 'b0,
           B= 'b0,
           C= 'b0,
           D= 'b1;

    reg  [1:0] current_state , next_state;

always @ ( posedge clk or posedge areset)
begin
if(areset) 
    begin
current_state <=  A;
    out = in;
        end
 else 
     begin
   current_state <= next_state;
    out = 0;
         end
end  

always @ (*)
begin 
case(current_state)
    A: begin    
        if(in)
            begin
           next_state= B;
      
            end
        else
             begin
           next_state= A;
         
            end
       end
     B: begin    
        if(in)
           next_state= B;
        else
            next_state= C;
       end
      C: begin    
        if(in)
           next_state= D;
        else
            next_state= A;
       end
    D: begin    
        if(in)
           next_state= B;
        else
            next_state= C;
       end
  
endcase
end  
 always @(*) begin
        case (current_state)
            A: out = 0;  
            B: out = 0;  
            C: out = 0;  
            D: out = 1;  
            default: out = 0;  
        endcase
    end  
    
endmodule

///////////////////////////////////////////////////////
/////////////////////TB////////////////////////////////

module top_module_TB();
    reg clk;
    reg in;
    reg areset;
    wire out; //


 initial
  begin 
  in=0; areset=0; clk=0; #5;
   in=0; areset=1;  clk=1; #10;
    in=0;  #10;
    in=1;  #100;
    $stop;
    
  end 


 always #5 clk=~clk;
  
  top_module DUT (in , clk , areset , out );
  

endmodule

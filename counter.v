////////// ..RTL_CODE.. /////////

module counter #(parameter width = 4)(

input      load , up , down,clk,
input         [width-1:0]    IN,
output reg    [width-1:0] count,
output reg           high , low
);
// Sequential 
always @ ( posedge clk )
begin
if(load) 
count <= IN;
else if(down && !low)
 count <= count-1;
else if(up && !high && !down) 
  count <= count+1;
 else 
   count <= 'b0;
end  
// Combination 
always @ ( * )
begin
if(count == 'b1111 ) 
  begin
  high <= 'b1;    low <= 'b0;
  end
else if(count =='b0000)
    begin
    low <= 'b1;     high <= 'b0;
    end
  else 
   begin
   low <= 'b0;   high <= 'b0;
   end 
end  

endmodule





////////// ..Testbench.. ///////

  `timescale 1ns/1ps
module Counter_tb #(parameter Clk_Period=10)();

//localparam Clk_Period=10;

  reg up , down , load , clk;
  reg   [3:0]            IN ;
  wire  [3:0]          count;
  wire           high , low ;


//initial block..

initial 
  begin
    $dumpfile("counter.vcd") ;
    $dumpvars ;
    //initial values..
    IN = 4'b1110 ;     // 14 decimal ..
    load = 0 ;
    down = 0 ;
     up  = 0 ;
    clk  = 0 ;
    #Clk_Period;
	  
	  load = 1 ;       //counter = in
    clk    = 1 ;
    #Clk_Period;
	  
	   down = 1 ;      // down is high priority
     up  = 1 ;       // counter = in-1 =13
    #Clk_Period;
    
    down = 0 ;      
     up  = 1 ;       // counter = in+1 =13
    #Clk_Period;
    
    down = 0 ;      
     up  = 1 ;       // counter = in+1 =14
    #Clk_Period;
	   
	   down = 0 ;      
     up  = 1 ;  
     load = 0 ;     // counter = 0
    #Clk_Period;
    
     down = 0 ;      
     up  = 1 ;      // counter = in+1 =15 and High =1
    #(Clk_Period*2);
    
     down = 1 ;      // down is high priority
     up  = 1 ;      
    #Clk_Period;
	  
	
	#(Clk_Period * 10);
	$stop;
	
   end
  
  
// Clock Generator (type: Delay Control) 
  //always #(Clk_Period/2) clk = !clk ; 
 always
  begin
    clk = 0;
  #(Clk_Period / 2) ;
    clk = 1;
  #(Clk_Period / 2) ;
  end
  
  
// instaniate design instance 
  counter DUT (
  .up(up) , 
  .load(load) , 
  .clk(clk) , 
  .IN(IN) , 
  .count(count) , 
  .low(low) , 
  .high(high),
  .down(down)
   );
   
endmodule

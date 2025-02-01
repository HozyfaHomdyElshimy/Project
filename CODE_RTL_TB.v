
////////// ..RTL_CODE.. /////////

module RTL #(parameter width=00)(

input  clk,rst ,
output

);

// Internal Signals
  reg [width-1:0]   Sig_comb ;
  
  
  
// Assign Sig_comb logic to Sig_out register  
  always @ (posedge clk or posedge rst)
    begin
      Sig_out <= Sig_comb ;    
    end

//behaviour function   
  always @ (*)
   begin
   //code
   end

endmodule






////////// ..Testbench.. ///////

`timescale 1us/1us
module TB #(parameter Clk_Period=10)();

//localparam Clk_Period=10;

reg   in   ;
wire  out  ;


//initial block..

initial 
  begin
    $dumpfile("RTL.vcd") ;
    $dumpvars ;
    //initial values..
    IN = 4'b1110 ;     // 14 decimal .. //
    latch = 1'b0 ;
    dec = 1'b0 ;
    clk = 1'b0 ;
	                // Monitor signals.. //
	  $monitor("Time: %0t | clk: %b | resetn: %b | x: %b | y: %b | f: %b | g: %b", 
                 $time, clk, resetn, x, y, f, g);
	
	#(Clk_Period*10);
	$stop;
	
   end
  
  
// Clock Generator (type: Delay Control) 
  always #(Clk_Period/2) clk = !clk ;
  
 /* always
  begin
    clk =0;
  #(Clk_Period/2) ;
    clk =1;
    #(Clk_Period/2) ;
  end*/
  
  
// instaniate design instance 
  RTL DUT (
    .IN(IN),
    .zero(zero),
    .clk(clk),
	.rst(rst)
    
  );

endmodule

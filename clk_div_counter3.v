

////////// ..RTL_strection_CODE.. /////////

module clock_divider_by3 (
    input wire clk,          
    input wire rst,          
    output wire clk_out      
);

                                   // 3-bit counter to count clock cycles
    reg [2:0] counter;

    
    always @(posedge clk or posedge rst)
 begin
    if (rst)
        begin
            counter <= 3'b00;
        end 
     else
        begin
            counter <= counter + 1;
            end
   end
   
   assign clk_out = counter[2];

endmodule

////////// ..Testbench.. ///////

`timescale 1us/1us
module clock_divider_by3_tb #(parameter Clk_Period=10)();

reg   clk, rst   ;
wire  clk_div  ;


//initial block..

initial 
  begin
    $dumpfile("clock_divider_by3.vcd") ;
    $dumpvars ;
    //initial values..
    rst = 1'b0 ;
    clk = 1'b0 ;
#Clk_Period

     rst = 1'b1 ;
     clk = 1'b1 ;
#Clk_Period

    rst = 1'b0 ;
    clk = 1'b0 ;
#Clk_Period
	
	#(Clk_Period*20);
	$stop;
	
   end
  
  
// Clock Generator (type: Delay Control) 
  always #(Clk_Period/2) clk = !clk ;
  
  
// instaniate design instance 
  clock_divider_by3 DUT (
    .rst(rst),
    .clk(clk),
	  .clk_out(clk_div)
  );

endmodule


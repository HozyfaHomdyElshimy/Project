////////// ..RTL_CODE.. /////////
module clock_divider_2 (
    input clk_in,     
    input rst,         
    output reg clk_out    // Output clock signal (divided by 2)
);

    
    always @(posedge clk_in or posedge rst) begin
        if (rst) begin
            clk_out <= 0;              // If reset is active, set output clock to 0
        end
        else begin
          clk_out <= ~clk_out;     // Toggle the output clock on every rising edge of clk_in
        end
    end

endmodule


////////// ..Testbench.. ///////

`timescale 1us/1us
module clock_divider_TB #(parameter Clk_Period=10)();

//localparam Clk_Period=10;

reg   clk_in,rst   ;
wire  clk_out  ;


//initial block..

initial 
  begin
    $dumpfile("clock_divider_2.vcd") ;
    $dumpvars ;
    //initial values..

    rst = 1'b0 ;
    clk_in = 1'b0 ;
#Clk_Period

     rst = 1'b1 ;
    clk_in = 1'b1 ;
#Clk_Period

    rst = 1'b0 ;
    clk_in = 1'b0 ;
#Clk_Period
	
	#(Clk_Period*10);
	$stop;
	
   end
  
  
// Clock Generator (type: Delay Control) 
  always #(Clk_Period/2) clk_in = !clk_in ;
  
  
// instaniate design instance 
  clock_divider_2 DUT (
    .clk_out(clk_out),
    .clk_in(clk_in),
	.rst(rst)
     );

endmodule


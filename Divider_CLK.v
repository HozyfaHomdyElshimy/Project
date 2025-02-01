
////////// ..RTL_CODE.. /////////

module CLKDIV (

input  clk,rst ,clk_en,ratio,
output reg clk_out
);

// Internal Signals
  reg    Q  ;
 wire ClK_DIV_EN;

  assign clk_div_en = (clk_en && (ratio != 0) && (ratio != 1));
// Assign Sig_comb logic to Sig_out register  
  always @ (posedge clk or posedge rst)
    begin
     if(rst) Q <= 0;
      else Q <= ( ~Q & clk_out );
    end
    

     always @ (posedge clk or posedge rst)
    begin
     if(rst) clk_out <=0;
      else clk_out <= ~clk_out;
    end


endmodule









////////// ..Testbench.. ///////

`timescale 1us/1us
module CLKDIV_tb #(parameter Clk_Period=10)();

//localparam Clk_Period=10;

reg   clk, rst ,clk_en ,ratio   ;
wire  clk_out  ;


//initial block..

initial 
  begin
    $dumpfile("clk_divider3.vcd") ;
    $dumpvars ;
    //initial values..
    rst = 1'b0 ;
    clk = 1'b0 ;
    ratio = 1'b0 ;
    clk_en = 1'b0 ;
#Clk_Period
    ratio = 1'b1 ;
    clk_en = 1'b1 ;
     rst = 1'b1 ;
     clk = 1'b1 ;
#Clk_Period

    rst = 1'b0 ;
    clk = 1'b0 ;
#Clk_Period
	ratio = 1'b1 ;
    clk_en = 1'b0 ;
	#(Clk_Period*20);
	$stop;
	
   end
  
  
// Clock Generator (type: Delay Control) 
  always #(Clk_Period/2) clk = !clk ;
  
  
// instaniate design instance 
  CLKDIV DUT (
    .rst(rst),
    .clk(clk),
    .clk_en(clk_en),
    .ratio(ratio),
	  .clk_out(clk_out)
  );

endmodule 

////////// ..RTL_CODE.. /////////
/*
module CLKDIV (
    input clk,     // Clock input
    input rst,     // Reset input
    input clk_en,  // Enable clock
    output reg clk_out  // Output clock
);

// Internal Signals
    reg [1:0] count;  // Counter for clock division

// Counter logic to divide clock by 3
always @(posedge clk or posedge rst) begin
    if (rst) begin
        count <= 2'b00;  // Reset the counter
        clk_out <= 0;    // Reset the output clock
    end else if (clk_en) begin
        // Increment the counter on each clock edge
        count <= count + 1;
        // Generate the output clock when count is 2 (i.e., on every 3rd clock cycle)
        if (count == 2'b10) begin
            clk_out <= ~clk_out;  // Toggle the output clock every 3 cycles of input clock
        end
    end
end

endmodule


////////// ..Testbench.. ///////

`timescale 1us/1us
module CLKDIV_tb #(parameter Clk_Period=10)();

// Local parameters
    reg clk, rst, clk_en;
    wire clk_out;

// Initial block
initial begin
    $dumpfile("CLKDIV.vcd");  // Dump file for waveform
    $dumpvars;                      // Dump all signals
    // Initial values
    rst = 1'b0;
    clk = 1'b0;
    clk_en = 1'b0;
    #Clk_Period
    clk_en = 1'b1;  // Enable clock
    rst = 1'b1;     // Apply reset
    #Clk_Period
    rst = 1'b0;     // Release reset
    #Clk_Period*10;
    clk_en = 1'b0;  // Disable clock
    #Clk_Period*20;
    $stop;           // Stop the simulation
end

// Clock generator (delay control)
always #(Clk_Period / 2) clk = !clk;

// Instantiate the DUT (Device Under Test)
CLKDIV DUT (
    .rst(rst),
    .clk(clk),
    .clk(clk),
    .clk_en(clk_en),
    .clk_out(clk_out)
);

endmodule */



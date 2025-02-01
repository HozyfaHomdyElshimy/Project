////////// ..RTL_CODE.. /////////
 
module RAM #(parameter width=15 )
  
(
input clk , rst ,write_en,
input  [width:0] data_in,
input  [3:0] addr,
output reg [width:0] data_out
);
    
    reg [15:0] ram_mem [15:0];       // 16 locations, each 16 bits wide

   
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            data_out <= 16'b0;  
        end
        else if (write_en) 
        begin
            ram_mem[addr] <= data_in;
        end
        else begin
            data_out <= ram_mem[addr];
        end
    end

endmodule


////////// ..Testbench.. ///////

`timescale 1us/1us
module RAM_TB #(parameter Clk_Period=10, width=15)();

//localparam Clk_Period=10;

reg clk , rst ,write_en;
reg  [width:0] data_in;
reg  [3:0] addr;
wire [width:0] data_out;

//initial block..

initial 
  begin
    $dumpfile("RAM.vcd") ;
    $dumpvars ;
   
   // Initialize signals
        clk = 1;
        write_en = 0;
        data_in = 16'b0;
        addr = 4'b0;


                                          // Apply reset
        $display("Applying reset...");
        rst = 1; 
        #10;
        rst = 0; 
        #10;
        
        data_in='b1011101; addr='b1001;   write_en='b1; 
       #10

                                        // Test writing and reading at address 4
        $display("Writing data to address 4...");
        addr = 4'b0100;                   // Select address 4
        data_in = 16'b1010101010101010;   // Data to write
        write_en = 1;  
        #10;  
        write_en = 0; 
                                       // Test reading from address 4
        $display("Reading data from address 4...");
        addr = 4'b0100; 
        #10;

                                      // Test writing and reading at address 10
        $display("Writing data to address 10...");
        addr = 4'b1010; 
        data_in = 16'b1100110011001100;         // Data to write
        write_en = 1; 
        #10; 
        write_en = 0; 

        // Test reading from address 10
        $display("Reading data from address 10...");
        addr = 4'b1010 ;                         // Read from address 10
        #10;

      
	    
	#(Clk_Period*10);
	$stop;
	
   end
  
  
// Clock Generator (type: Delay Control) 
  //always #(Clk_Period/2) clk = !clk ;
  
 always
  begin
    clk =0;
  #(Clk_Period/2) ;
    clk =1;
      #(Clk_Period/2) ;
  end
  
  
// instaniate design instance 
  RAM DUT (
  .write_en(write_en),
  .data_in(data_in),
  .addr(addr),
  .data_out(data_out),
  .clk(clk),
	.rst(rst)
    
  );

endmodule

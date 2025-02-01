
////////// ..RTL_CODE.. /////////

module CLKDIV (
    input wire I_ref_clk,      // Reference clock input
    input wire I_rst_n,        // Active-low asynchronous reset
    input wire I_clk_en,       // Clock divider enable
    input wire [31:0] I_div_ratio,  // Integer division ratio (positive value)
    output reg O_clk_out       // Output clock after division
);

// Internal signal for counting the clock cycles
reg [31:0] count;  // Counter to track the clock division cycles

// Clock Divider Enable Logic
wire clk_div_en;
assign clk_div_en = I_clk_en && (I_div_ratio != 0) && (I_div_ratio != 1);

// Always block for clock division logic
always @(posedge I_ref_clk or negedge I_rst_n) begin
    if (~I_rst_n) begin
        // Asynchronous reset
        count <= 32'b0;
        O_clk_out <= 1'b0;
    end else if (clk_div_en) begin
        // Counting logic for the clock divider
        if (count == (I_div_ratio - 1)) begin
            // Toggle the output clock after the specified division ratio
            O_clk_out <= ~O_clk_out;
            count <= 32'b0;  // Reset the counter
        end else begin
            count <= count + 1;  // Increment the counter
        end
    end
end

endmodule



////////// ..Testbench.. ///////

`timescale 1us/1us
module CLKDIV_tb();

// Declare testbench signals
reg I_ref_clk, I_rst_n, I_clk_en;
reg [31:0] I_div_ratio;
wire O_clk_out;

// Define parameters for the clock period
parameter Clk_Period = 10;  // Period of reference clock in time units

// Initial block for stimulus generation
initial begin
    // Initialize signals
    $dumpfile("clk_divider_integer.vcd");  // Dump file for waveform
    $dumpvars;  // Dump all signals

    I_rst_n = 1'b0;   // Reset initially active
    I_ref_clk = 1'b0;  // Start with reference clock low
    I_clk_en = 1'b0;   // Initially, clock divider is disabled
    I_div_ratio = 32'd0; // Invalid ratio (shouldn't work)
    
    // Apply reset
    #Clk_Period I_rst_n = 1'b1;  // Deassert reset after one period
    #Clk_Period I_div_ratio = 32'd4; // Set valid division ratio (4)
    I_clk_en = 1'b1;  // Enable clock divider
    #(Clk_Period*10);

    I_div_ratio = 32'd3; // Set valid division ratio (3)
    #(Clk_Period*10);

    I_div_ratio = 32'd6; // Set valid division ratio (6)
    #(Clk_Period*10);

    I_div_ratio = 32'd0; // Invalid division ratio (0)
    #(Clk_Period*10);

    I_div_ratio = 32'd1; // Invalid division ratio (1)
    #(Clk_Period*10);

    I_div_ratio = 32'd7; // Set valid division ratio (7)
    #(Clk_Period*10);

    I_clk_en = 1'b0;  // Disable clock divider
    #(Clk_Period*10);

    $stop;  // Stop simulation for analysis
end

// Clock generator (reference clock)
always #(Clk_Period / 2) I_ref_clk = !I_ref_clk;

// Instantiate the DUT (Device Under Test)
CLKDIV DUT (
    .I_ref_clk(I_ref_clk),
    .I_rst_n(I_rst_n),
    .I_clk_en(I_clk_en),
    .I_div_ratio(I_div_ratio),
    .O_clk_out(O_clk_out)
);

endmodule

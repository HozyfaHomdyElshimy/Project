/*module clk_divider (

input clk,rst,
output reg out
);

//always @ (posedge clk or posedge rst)
begin
  if(rst)
    out <= 'b0;
  else
    out <= !out;
  
end

endmodule*/

module clock_divider_2 (
    input clk_in,      // Input clock signal
    input rst,         // Reset signal
    output reg clk_out    // Output clock signal (divided by 2)
);

    // On every rising edge of clk_in, toggle the output clock
    always @(posedge clk_in or posedge rst) begin
        if (rst) begin
            // If reset is active, set output clock to 0
            clk_out <= 0;
        end
        else begin
            // Toggle the output clock on every rising edge of clk_in
            clk_out <= ~clk_out;
        end
    end

endmodule


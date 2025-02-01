////////// ..RTL_CODE.. /////////

module TX (
  input [7:0] IN_tx,
  input clk_tx, rst, latch_enable,  // Latch enable signal
  output reg [7:0] OUT_TX,
  output reg en_synth
);

  // Assign Sig_comb logic to Sig_out register
  always @ (posedge clk_tx or posedge rst) 
  begin
    if (rst)
    begin 
      OUT_TX <= 8'b0;
      en_synth <= 0; // Disabled initially
    end
    else if (latch_enable) 
    begin  // Only enable when latch_enable is high
      OUT_TX <= IN_tx;
      en_synth <= 1;  // Enable TX
    end
     else begin
      en_synth <= 0;  // Disable TX when latch_enable is low
    end
  end
endmodule

////////// ..RTL_CODE.. /////////

module RX (
  input [7:0] in_data,
  input clk_rx, rst, en_Rx,
  output reg [7:0] OUT_RX,
  output reg latch_enable  // Output to latch enable signal
);

  // Assign Sig_comb logic to Sig_out register
  always @ (posedge clk_rx or posedge rst) begin
    if (rst) begin
      OUT_RX <= 8'b0;
      latch_enable <= 0;  // Initially disable latch
    end else if (en_Rx) begin
      OUT_RX <= in_data;  // Receive data
      latch_enable <= 1;  // Enable latch signal to TX
    end else begin
      latch_enable <= 0;  // Disable latch after RX
    end
  end
endmodule

////////// ..RTL_CODE.. /////////

module synthesizer (
  input clk,       
  input rst,     
  output reg wave  
);

  reg [1:0] counter; 

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      counter <= 2'b00;  
      wave <= 1'b0;      
    end else begin
      counter <= counter + 1;  
      if (counter == 2'b11) begin
        wave <= ~wave;      
      end
    end
  end
endmodule

////////// ..RTL_CODE.. /////////

module TX_RX_TOP (
  input clk_rx, clk_tx, rst, en_Rx, IN,
  output  [7:0] OUT
);

  // Internal Signals
  wire [7:0] OUT_TX;
  wire latch_enable;  // Latch signal to control TX enable

  // TX module
  TX DUT0 (
    .rst(rst),
    .clk_tx(clk_tx),
    .IN_tx(IN),
    .latch_enable(latch_enable),  // Connect latch_enable to TX
    .OUT_TX(OUT_TX),
    .en_synth()  // Don't need to output en_synth here as it's internal
  );

  // RX module
  RX DUT1 (
    .rst(rst),
    .clk_rx(clk_rx),
    .en_Rx(en_Rx),
    .OUT_RX(OUT),
    .latch_enable(latch_enable)  // Connect latch_enable to RX
  );
  
  // Synthesizer module
  synthesizer DUT2 (
    .rst(rst),
    .clk(clk_tx),  // Use clk_tx for synthesizer clock (or change if needed)
    .wave()
  );

endmodule

////////// ..Testbench.. ///////

`timescale 1us/1us
module TX_RX_TOP_tb #(parameter Clk_Period=20)();

  reg clk_rx, clk_tx, rst, en_Rx, IN_tx;
  wire OUT;

  // Initial block..
  initial begin
    $dumpfile("TX_RX_TOP.vcd");
    $dumpvars;
    // Initial values..
    rst = 1'b0;
    clk_rx = 1'b0;
    clk_tx = 1'b0;
    IN_tx = 1'b0;
    #Clk_Period

    rst = 1'b1;
    clk_rx = 1'b1;
    clk_tx = 1'b1;
    IN_tx = 1'b0;
    #Clk_Period

    rst = 1'b0;
    en_Rx = 1'b1;
    IN_tx = 1'b1;
    #Clk_Period

    #(Clk_Period*20);
    $stop;
  end
  
  // Clock Generator (type: Delay Control)
  initial begin 
    fork
      forever #(Clk_Period/2) clk_rx = !clk_rx;
      forever  #(Clk_Period*2) clk_tx = !clk_tx;
    join
  end

  // Instantiate design instance
  TX_RX_TOP DUT (
    .rst(rst),
    .clk_rx(clk_rx),
    .clk_tx(clk_tx),
    .en_Rx(en_Rx),
    .IN(IN_tx),
    .OUT(OUT)
  );

endmodule

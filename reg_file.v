module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output reg out);
    
    reg q1 , q2 , q3 ;
    
    always @ (posedge clk)
        begin
            if(!resetn)
                out<= 'b0;
          else
            out<= q3;
        end
  always @ (posedge clk)
        begin
            if(!resetn)
                q3<= 'b0;
            else
            q3<= q2;
        end
    always @ (posedge clk)
        begin
            if(!resetn)
                q2<= 'b0;
            else
            q2<= q1;
        end
    always @ (posedge clk)
        begin
            if(!resetn)
                q1<= 'b0;
            else
            q1<= in;
        end
    

endmodule


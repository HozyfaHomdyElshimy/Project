module counter_RX (
  
  input CLK,
  input RST,
  input enable,
  output bit_cnt,
  output edge_cnt
  
   );
   
//internal sigals

reg     bit_cnt_cmb;
reg     edge_cnt_cmb;

always @ (posedge CLK or posedge RST)
begin
  if(RST)
    begin
      bit_cnt<=0;
      edge_cnt<=0;
    end
  else
    begin
      edge_cnt<=edge_cnt_cmb;
      bit_cnt<=bit_cnt_cmb;
    end
 end
 
 
always @ (*)
begin    



end    

endmodule
module Sum(
  input logic[31:0]Asum,
  output logic[31:0]Bsum);
  
   assign Bsum = Asum + 4;
  
endmodule

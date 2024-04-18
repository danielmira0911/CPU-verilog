module PC(
  input logic clk,
  input logic [31:0] NextPC,
  output reg [31:0] Pc=0);

  always @(posedge clk) 
    Pc <= NextPC;
endmodule
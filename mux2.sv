module MUX2(
  input logic [31:0]A,
  input logic [31:0]B,
  input logic select,
  output logic [31:0]Out);
  
  always@(*) begin
    case(select)
      1'b0: Out = A;
      1'b1: Out = B;
    endcase
  end
endmodule
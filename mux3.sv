module MUX3(
  input logic [31:0]A,
  input logic [31:0]B,
  input logic [31:0]C,
  input logic [1:0]select,
  output logic [31:0]Out);
  
  always@(*) begin
    case(select)
      2'b10: Out = A;
      2'b01: Out = B;
      2'b00: Out = C;
    endcase
  end
endmodule
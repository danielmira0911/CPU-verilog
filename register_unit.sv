module RegisterUnit(
  input logic CLK,
  input logic [4:0] rs1,   
  input logic [4:0] rs2,
  input logic [4:0] rd,
  input logic [31:0] DataWr,
  input logic RuWr,
  output logic [31:0] Rus1,
  output logic [31:0] Rus2
);

  reg [0:31] Ru [31:0];
  
  initial begin
    $readmemb("Registros.txt",Ru);
  end

  assign Rus1 = Ru[rs1];
  assign Rus2 = Ru[rs2];

  always @(posedge CLK) begin
    if (RuWr == 1'b1 && rd != 5'b0)
      Ru[rd] = DataWr;
    $monitor("%d", Ru[18]);
  end

endmodule

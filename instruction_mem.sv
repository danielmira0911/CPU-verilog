module InstructionMemory(
  input logic [31:0] Address,
  output logic [31:0] Instruction);
  
  reg [7:0] Matriz [(2**21)-1 : 0];
  
  initial begin 
    $readmemb("Instructions.txt", Matriz);
  end
  
  always_comb begin
    Instruction <= {Matriz[Address], Matriz[Address+1], Matriz[Address+2], Matriz[Address+3]};
  end
  
  
endmodule
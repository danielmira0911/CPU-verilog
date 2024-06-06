module ImmGen(
  input logic [31:0]Inst,
  input logic [2:0]ImmSrc,
  output logic[31:0]ImmExt);
  
  always_comb begin
    case (ImmSrc)
      3'b000: ImmExt = {{20{Inst[31]}}, Inst[31:20]};      
      3'b001: ImmExt = {{20{Inst[31]}}, Inst[31:25], Inst[11:7]};      
      3'b101: ImmExt = {{19{Inst[31]}}, Inst[31], Inst[7], Inst[30:25], Inst[11:8], 1'b0};
      3'b010: ImmExt = {Inst[31:12], 12'b0};
      3'b110: ImmExt = {{19{Inst[31]}}, Inst[31], Inst[19:12], Inst[20], Inst[30:21], 1'b0};
      default: ImmExt = 32'bx;
    endcase
  end
  
endmodule
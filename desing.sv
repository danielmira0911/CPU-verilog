`include "BranchUnit.sv"
`include "ControlUnit.sv"
`include "ALU.sv"
`include "InstructionMemory.sv"
`include "DataMemory.sv"
`include "PC.sv"
`include "RegisterUnit.sv"
`include "Sum.sv"
`include "MUX_2.sv"
`include "MUX_3.sv"
`include "ImmGen.sv"

module procesador_mono_ciclo(
	input logic clk
);
  
  wire [31:0] nextpc, pc, bsum, instruction, mux3a1, rus1, rus2, immext, mux2a1alua, mux2a1alub, alures, datamemory;
  wire [4:0] brop;
  wire [3:0] aluop;
  wire [2:0] immsrc, dmctrl;
  wire [1:0] rudataWrsrc;
  wire aluasrc, alubsrc, dmwr, ruwr, nextpcsrc;
  
  
  
  
  PC program_counter(
    .clk(clk),
    .NextPC(nextpc),
    .Pc(pc)
  );
  
  Sum sum(
    .Asum(pc),
    .Bsum(bsum)
  );
  
  InstructionMemory instructionmemory(
    .Address(pc),
    .Instruction(instruction)
  );
  
  ControlUnit contrilunit(
    .OpCode(instruction[6:0]),
    .Funct3(instruction[14:12]),
    .Funct7(instruction[31:25]),
    .ImmSrc(immsrc),
    .ALUASrc(aluasrc),
    .ALUBSrc(alubsrc),
    .ALUOp(aluop),
    .DMWr(dmwr),
    .DMCtrl(dmctrl),
    .RUDataWrSrc(rudataWrsrc),
    .RUWr(ruwr),
    .BrOp(brop)
  );
  
  RegisterUnit unidadderegistros(
    .CLK(clk),
    .rs1(instruction[19:15]),
    .rs2(instruction[24:20]),
    .rd(instruction[11:7]),
    .DataWr(mux3a1),
    .RuWr(ruwr),
    .Rus1(rus1),
    .Rus2(rus2)
  );
  
  ImmGen immgen( 
    .Inst(instruction),
    .ImmSrc(immsrc),
    .ImmExt(immext)
  );
  
  BranchUnit branchunit(
    .A(rus1),
    .B(rus2),
    .BrOp(brop),
    .NextPCSrc(nextpcsrc)
  );
  MUX2 mux_2_1_alu_a(
    .A(rus1),
    .B(pc),
    .select(aluasrc),
    .Out(mux2a1alua)
  );
  
  MUX2 mux_2_1_alu_b(
    .A(rus2),
    .B(immext),
    .select(alubsrc),
    .Out(mux2a1alub)
  );
  
  ALU alu(
    .A(mux2a1alua),
    .B(mux2a1alub),
    .ALUOp(aluop),
    .ALURes(alures)

  );
  
  MUX2 mux2a1nextpc(
    .A(bsum),
    .B(alures),
    .select(nextpcsrc),
    .Out(nextpc)
  );
  
  DataMemory datamemory_1(
    .DMWr(dmwr),
    .DMCtrl(dmctrl),
    .Address(alures),
    .DataWr(rus2),
    .DataRd(datamemory)
  );
  
  MUX3 mux3a1_1(
    .A(bsum),
    .B(datamemory),
    .C(alures),
    .select(rudataWrsrc),
    .Out(mux3a1)
  );
    
endmodule
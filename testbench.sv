module procesador_tb;
  reg clk;
  procesador_mono_ciclo DUT(clk);
  
  always #15 clk = ~clk;
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(2);
    clk=0;
    #850;
    $finish;
  end
  
endmodule
module ALU(input logic signed [31:0]A, 
           input logic signed [31:0]B,
           input logic [3:0]ALUOp, 
           output logic signed [31:0]ALURes);
  always@(*)
    begin
      case(ALUOp)
        4'b0000:
          begin
            ALURes <= A + B;
          end
        4'b1000:
          begin
            ALURes <= A - B;
          end
        4'b0001:
          begin
            ALURes <= A << B;
          end
        4'b0010:
          begin
            ALURes <= A < B;
          end
        4'b0011:
          begin
            ALURes <= $unsigned(A) < $unsigned(B);
          end
        4'b0100:
          begin
            ALURes <= A ^ B;
          end
        4'b0101:
          begin
            ALURes <= A >> B;
          end
        4'b1101:
          begin
            ALURes <= A >>> B;
          end
        4'b0110:
          begin
            ALURes <= A | B;
          end
        4'b0111:
          begin
            ALURes <= A & B;
          end
        4'b1111:
          begin
            ALURes <= B;
          end
        default: ALURes = 32'bx;
      endcase
    end
endmodule
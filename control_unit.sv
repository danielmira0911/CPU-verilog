module ControlUnit(
  input logic [6:0] OpCode,
  input logic [2:0] Funct3,
  input logic [6:0] Funct7,
  output logic [2:0]ImmSrc,
  output logic ALUASrc,
  output logic ALUBSrc,
  output logic [3:0]ALUOp,
  output logic DMWr,
  output logic [2:0]DMCtrl,
  output logic [1:0]RUDataWrSrc,
  output logic RUWr,
  output logic [4:0]BrOp); 
  
    always_comb begin
      case(OpCode)
        7'b0110011:begin//Type R
            ImmSrc = 3'bxxx;
            ALUASrc = 1'b0;
            ALUBSrc = 1'b0;
		    ALUOp = {Funct7[5], Funct3};
            DMWr = 1'b0;
            DMCtrl = 3'bxxx;
            RUDataWrSrc = 2'b00;
            RUWr = 1'b1;
            BrOp = 5'b00xxx;
        end
        7'b0010011:begin//Type I
            ImmSrc = 3'b000;
            ALUASrc = 1'b0;
            ALUBSrc = 1'b1;
      		if(Funct3==101)
              ALUOp = {Funct7[5], Funct3};//SRAI SRLI
      		else
              ALUOp = {1'b0, Funct3};
            DMWr = 1'b0;
            DMCtrl = 3'bxxx;
            RUDataWrSrc = 2'b00;
            RUWr = 1'b1;
            BrOp = 5'b00xxx;
         end
        7'b1100011:begin//Type B
            ImmSrc = 3'b101;
            ALUASrc = 1'b1;
            ALUBSrc = 1'b1;
            ALUOp = 4'b0000;
            DMWr = 1'b0;
            DMCtrl = 3'bxxx;
            RUDataWrSrc = 2'bxx;
            RUWr = 1'b0;
            BrOp = {2'b01, Funct3};
         end
      
     
         7'b0000011:begin // Tipo I Loads
            ImmSrc = 3'b000;
            ALUASrc = 1'b0;
            ALUBSrc = 1'b1;
            ALUOp = 4'b0000;
            DMWr = 1'b0;
            DMCtrl = Funct3;
            RUDataWrSrc = 2'b01;
            RUWr = 1'b1;
          	BrOp = 5'b00xxx;
         end
      
       	7'b0100011:begin// Tipo S
            ImmSrc = 3'b001;
            ALUASrc = 1'b0;
            ALUBSrc = 1'b1;
            ALUOp = 4'b0000;
            DMWr = 1'b1;
            DMCtrl = Funct3;
            RUDataWrSrc = 2'bxx;
            RUWr = 1'b0;
          	BrOp = 5'b00xxx;
         end
      
       	7'b1100111:begin// Tipo I JALR
            ImmSrc = 3'b000;
            ALUASrc = 1'b0;
            ALUBSrc = 1'b1;
            ALUOp = 4'b0000;
            DMWr = 1'b0;
            DMCtrl =3'bxxx;
            RUDataWrSrc = 2'b10; //10, XX
            RUWr = 1'b1;
          	BrOp = 5'b1xxxx;
         end
      
       	7'b1101111:begin// JAL
            ImmSrc = 3'b110;
            ALUASrc = 1'b1;
            ALUBSrc = 1'b1;
            ALUOp = 4'b0000;
            DMWr = 1'b0;
            DMCtrl =3'bxxx;
            RUDataWrSrc = 2'b10;
            RUWr = 1'b1;
          	BrOp = 5'b1xxxx;
         end
      
       	7'b0110111:begin// Lui
            ImmSrc = 3'b010;
            ALUASrc = 1'bx;
            ALUBSrc = 1'b1;
            ALUOp = 4'b1111;
            DMWr = 1'b0;
            DMCtrl =3'bxxx;
            RUDataWrSrc = 2'b00;
            RUWr = 1'b1;
          	BrOp = 5'b00xxx;
         end
      
       	7'b0010111:begin// AUIPC
            ImmSrc = 3'b010;
            ALUASrc = 1'b1;
            ALUBSrc = 1'b1;
            ALUOp = 4'b0000;
            DMWr = 1'b0;
            DMCtrl =3'bxxx;
            RUDataWrSrc = 2'b10;
            RUWr = 1'b1;
          	BrOp = 5'b00xxx;
         end
      
      
         default: begin // En caso de encontrar el OpCode
            ImmSrc = 3'bxxx;
            ALUASrc = 1'bx;
            ALUBSrc = 1'bx;
            ALUOp = 4'bxxxx;
            DMWr = 1'b0;
            DMCtrl = 3'bxxx;
            RUDataWrSrc = 2'bxx;
            RUWr = 1'b0;
            BrOp = 5'b00xxx;
         end
    
    
      endcase
    end
endmodule
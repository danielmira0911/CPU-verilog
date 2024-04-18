module DataMemory(
  input logic DMWr,
  input logic [2:0] DMCtrl,
  input logic [31:0] Address,
  input logic signed [31:0] DataWr,
  output logic signed [31:0] DataRd);
  
  integer i;
  localparam memory_size = 2**21;
  reg [7:0] memory [memory_size - 1: 0];

  //Writing
  always_comb begin 
    if(DMWr == 1'b1) begin
      case (DMCtrl)
        //Byte
        3'b000: begin 
          memory[Address] <= DataWr[7:0];
        end
        
        //Half word
        3'b001: begin 
          memory[Address] <= DataWr[7:0];
          memory[Address+1] <= DataWr[15:8];
        end
        
        //Word
        3'b010: begin
          for(i=0; i<4; i=i+1)begin
            memory[Address+i] = DataWr[i*8 +: 8];
          end
        end
      endcase
    end    
  end
  
  //Reading
  always_comb begin
    case (DMCtrl)
      //Byte
      3'b000: begin
        DataRd <= {{24{memory[Address][7]}}, memory[Address]};
      end
      
      //Half word
      3'b001: begin
        DataRd <= {{16{memory[Address+1][7]}}, memory[Address+1], memory[Address]};
      end
      
      //Word
      3'b010: begin
        DataRd <= {memory[Address+3], memory[Address+2], memory[Address+1], memory[Address]};
      end
      
      //Byte unsigned
      3'b100: begin
        DataRd <= {24'b0, memory[Address]};
      end
      
      //Half word unsigned
      3'b101: begin
        DataRd <= {16'b0, memory[Address+1], memory[Address]};
      end
      
      default: DataRd = 32'bx;
    endcase

  end
  
endmodule
module ALU (
    A,
    B,
    ALU_control_In,
    ALUResult,
    zero
);

  input [31:0] A, B;
  input [3:0] ALU_control_In;
  output reg zero;
  output reg [31:0] ALUResult;

  always @(ALU_control_In or A or B) begin
    case (ALU_control_In)
      4'b0000: begin
        zero <= 0;
        ALUResult <= A & B;
      end
      4'b0001: begin
        zero <= 0;
        ALUResult <= A | B;
      end
      4'b0010: begin
        zero <= 0;
        ALUResult <= A + B;
      end
      4'b0110: begin
        if (A == B) zero <= 1;
        else zero <= 0;
        ALUResult <= A - B;
      end
      default: begin
        zero <= 0;
        ALUResult <= A;
      end
    endcase
    zero = ALUResult == 32'b0;
  end
endmodule

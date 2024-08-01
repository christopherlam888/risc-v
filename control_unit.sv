module control_unit (
    opcode,
    branch,
    mem_rd,
    memtoReg,
    mem_wr,
    ALUSrc,
    reg_wr,
    ALUOp
);

  input [6:0] opcode;
  output reg branch, mem_rd, memtoReg, mem_wr, ALUSrc, reg_wr;
  output reg [1:0] ALUOp;

  always_comb begin
    case (opcode)
      7'b0110011: begin  // R-type
        branch = 1'b0;
        mem_rd = 1'b0;
        memtoReg = 1'b0;
        mem_wr = 1'b0;
        ALUSrc = 1'b0;
        reg_wr = 1'b1;
        ALUOp = 2'b10;
      end
      7'b0000011: begin  // Load
        branch = 1'b0;
        mem_rd = 1'b1;
        memtoReg = 1'b1;
        mem_wr = 1'b0;
        ALUSrc = 1'b1;
        reg_wr = 1'b1;
        ALUOp = 2'b00;
      end
      7'b0100011: begin  // Store
        branch = 1'b0;
        mem_rd = 1'b0;
        memtoReg = 1'b0;
        mem_wr = 1'b1;
        ALUSrc = 1'b1;
        reg_wr = 1'b0;
        ALUOp = 2'b00;
      end
      7'b1100011: begin  // branch
        branch = 1'b1;
        mem_rd = 1'b0;
        memtoReg = 1'b0;
        mem_wr = 1'b0;
        ALUSrc = 1'b0;
        reg_wr = 1'b0;
        ALUOp = 2'b01;
      end
      default: begin  // R-type
        branch = 1'b0;
        mem_rd = 1'b0;
        memtoReg = 1'b0;
        mem_wr = 1'b0;
        ALUSrc = 1'b0;
        reg_wr = 1'b1;
        ALUOp = 2'b10;
      end
    endcase
  end
endmodule

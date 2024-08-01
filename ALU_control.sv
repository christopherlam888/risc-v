module ALU_control (
    ALUOp,
    func7,
    func3,
    ALU_control_out
);

  input [1:0] ALUOp;
  input func7;
  input [14:12] func3;
  output reg [3:0] ALU_control_out;

  always @(ALUOp or func7 or func3) begin
    case ({
      ALUOp, func7, func3
    })
      {2'b00, 1'b0, 3'b000} : ALU_control_out <= 4'b0010;
      {2'b01, 1'b0, 3'b000} : ALU_control_out <= 4'b0110;
      {2'b10, 1'b0, 3'b000} : ALU_control_out <= 4'b0010;
      {2'b10, 1'b1, 3'b000} : ALU_control_out <= 4'b0110;
      {2'b10, 1'b0, 3'b111} : ALU_control_out <= 4'b0000;
      {2'b10, 1'b0, 3'b110} : ALU_control_out <= 4'b0001;
      default: ALU_control_out <= 4'b0000;
    endcase
  end
endmodule

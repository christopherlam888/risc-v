module immediate_generator (
    opcode,
    instruction,
    immExt
);

  input [6:0] opcode;
  input [31:0] instruction;
  output reg [31:0] immExt;

  always_comb begin
    case (opcode)
      7'b0010011: immExt = {{20{instruction[31]}}, instruction[31:20]};  // I-type
      7'b0100011:
      immExt = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};  // S-type
      7'b1100011:
      immExt = {
        {19{instruction[31]}}, instruction[31], instruction[30:25], instruction[11:8], 1'b0
      };  // SB-type
      default: immExt = {{20{instruction[31]}}, instruction[31:20]};  // I-type
    endcase
  end
endmodule

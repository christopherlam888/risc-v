module program_inc (
    fromPC,
    nexttoPC
);

  input [31:0] fromPC;
  output [31:0] nexttoPC;
  assign nexttoPC = fromPC + 32'b00000000000000000000000000000100;
endmodule

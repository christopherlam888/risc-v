module instruction_memory (
    clk,
    reset,
    read_addr,
    instructions_out
);

  input clk, reset;
  input [31:0] read_addr;
  output [31:0] instructions_out;
  reg [31:0] Imemory[1024];  // mem size 1024 bit each 32 bit wide
  integer i;
  assign instructions_out = Imemory[read_addr[31:2]];
  always @(posedge clk) begin
    if (reset) begin
      for (i = 0; i < 1024; i = i + 1) begin
        Imemory[i] = 32'b0;
      end
      $readmemh("instruction_memory.hex", Imemory);
    end
  end
endmodule

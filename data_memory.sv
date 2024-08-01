module data_memory (
    clk,
    reset,
    mem_wr,
    mem_rd,
    addr,
    wr_data,
    data_out
);

  input clk, reset, mem_wr, mem_rd;
  input [31:0] addr, wr_data;
  output [31:0] data_out;
  reg [31:0] data_memory[64];  // mem size 64 bit each 32 bit wide
  assign data_out = (mem_rd) ? data_memory[addr] : 32'b0;
  integer i;
  always @(posedge clk) begin
    if (reset) begin
      for (i = 0; i < 64; i = i + 1) begin
        data_memory[i] = 32'b0;
      end
      $readmemh("data_memory.hex", data_memory);
    end else begin
      if (mem_wr) data_memory[addr] = wr_data;
    end
  end
endmodule

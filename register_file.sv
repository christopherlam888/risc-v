module register_file (
    clk,
    reset,
    reg_wr,
    rs1,
    rs2,
    rd,
    wr_data,
    rd_data1,
    rd_data2
);

  input clk, reset, reg_wr;
  input [4:0] rs1, rs2, rd;
  input [31:0] wr_data;
  output [31:0] rd_data1, rd_data2;
  reg [31:0] registers[32];  // 32 registers each 32 bit wide
  integer i;
  always @(posedge clk) begin
    if (reset) begin
      for (i = 0; i < 32; i = i + 1) begin
        registers[i] = 32'b0;
      end
      $readmemh("registers.hex", registers);
    end else begin
      if (reg_wr) registers[rd] = wr_data;
    end
  end
  assign rd_data1 = registers[rs1];
  assign rd_data2 = registers[rs2];
endmodule

`include "ALU.sv"
`include "ALU_control.sv"
`include "control_unit.sv"
`include "data_memory.sv"
`include "immediate_generator.sv"
`include "instruction_memory.sv"
`include "mux.sv"
`include "program_inc.sv"
`include "program_counter.sv"
`include "register_file.sv"

module Top (
    input clk,
    reset
);

  wire [31:0] PC, nexttoPC, instructions_out, rd_data1, rd_data2, toALU, ALU_control_out, ALUResult, data_out, writeBack, immExt, mux3_out;
  wire reg_wr, ALUSrc, mem_wr, mem_rd, memtoReg, branch, zero;
  wire [1:0] ALUOp;

  program_inc pc4 (
      .fromPC  (PC),
      .nexttoPC(nexttoPC)
  );

  program_counter program_counter (
      .clk(clk),
      .reset(reset),
      .in(mux3_out),
      .out(PC)
  );

  instruction_memory instruction_memory (
      .clk(clk),
      .reset(reset),
      .read_addr(PC),
      .instructions_out(instructions_out)
  );

  register_file reg_file (
      .clk(clk),
      .reset(reset),
      .reg_wr(reg_wr),
      .rs1(instructions_out[19:15]),
      .rs2(instructions_out[24:20]),
      .rd(instructions_out[11:7]),
      .wr_data(writeBack),
      .rd_data1(rd_data1),
      .rd_data2(rd_data2)
  );

  ALU ALU (
      .A(rd_data1),
      .B(rd_data2),
      .ALU_control_In(ALU_control_out),
      .ALUResult(ALUResult),
      .zero(zero)
  );

  mux mux1 (
      .sel(ALUSrc),
      .A(rd_data2),
      .B(immExt),
      .out(toALU)
  );

  ALU_control ALU_control (
      .ALUOp(ALUOp),
      .func7(instructions_out[30]),
      .func3(instructions_out[14:12]),
      .ALU_control_out(ALU_control_out)
  );

  data_memory data_memory (
      .clk(clk),
      .reset(reset),
      .mem_wr(mem_wr),
      .mem_rd(mem_rd),
      .addr(ALUResult),
      .wr_data(rd_data2),
      .data_out(data_out)
  );

  mux mux2 (
      .sel(memtoReg),
      .A(ALUResult),
      .B(data_out),
      .out(writeBack)
  );

  control_unit control_unit (
      .opcode(instructions_out[6:0]),
      .branch(branch),
      .mem_rd(mem_rd),
      .memtoReg(memtoReg),
      .mem_wr(mem_wr),
      .ALUSrc(ALUSrc),
      .reg_wr(reg_wr),
      .ALUOp(ALUOp)
  );

  immediate_generator immediate_generator (
      .opcode(instructions_out[6:0]),
      .instruction(instructions_out),
      .immExt(immExt)
  );

  mux mux3 (
      .sel(branch & zero),
      .A(nexttoPC),
      .B(immExt + PC),
      .out(mux3_out)
  );

endmodule

module Top_tb ();

  reg clk = 1'b1, reset;

  Top DUT (
      .clk  (clk),
      .reset(reset)
  );

  initial begin
    $dumpfile("waves.vcd");
    $dumpvars(0);
  end

  always begin
    clk = ~clk;
    #50;

  end

  initial begin
    reset <= 1'b0;
    #150;

    reset <= 1'b1;
    #150;

    reset <= 1'b0;
    #450 $finish;
  end
endmodule

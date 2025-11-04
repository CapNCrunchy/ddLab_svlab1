module fa (
  input  logic input1,
  input  logic input2,
  input  logic carry_in,
  output logic sum,
  output logic carry_out
);

assign sum = input1 ^ input2 ^ carry_in;
assign carry_out = (input1 & input2) | (input1 & carry_in) | (input2 & carry_in);

endmodule

module adder (
  input  logic [3:0] input1,
  input  logic [3:0] input2,
  input  logic       carry_in,
  output logic [3:0] sum,
  output logic       carry_out
);

logic tmp0, tmp1, tmp2;

fa fa0(input1[0], input2[0], carry_in, sum[0], tmp0);
fa fa1(input1[1], input2[1], tmp0, sum[1], tmp1);
fa fa2(input1[2], input2[2], tmp1, sum[2], tmp2);
fa fa3(input1[3], input2[3], tmp2, sum[3], carry_out);

endmodule

//------------------------------------------------------------------------------
// project: sva_example
//
// brief  : basic formal verification property for behavioral multiplication
//
// author(s):
//      - Ciro Ceissler, ciro at ceissler.com.br
//------------------------------------------------------------------------------

module example2(A, B, C);
  input  signed [31:0] A;
  input  signed [31:0] B;
  output signed [63:0] C;

  assign C = A*B;

  assert property (C == A*B);
endmodule

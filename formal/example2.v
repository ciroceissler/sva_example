//------------------------------------------------------------------------------
// project: sva_example
//
// brief  : basic formal verification property for behavioral multiplication
//
// author(s):
//      - Ciro Ceissler, ciro at ceissler.com.br
//------------------------------------------------------------------------------

module example2(A, B, C);
  signed input  [31:0] A;
  signed input  [31:0] B;
  signed output [63:0] C;

  assign C = A*B;

  assert property (C == A*B);
endmodule

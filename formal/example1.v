//------------------------------------------------------------------------------
// project: sva_example
//
// brief  : basic formal verification property based on
//          http://www.clifford.at/papers/2015/yosys-icestorm-etc/slides.pdf
//
// author(s):
//      - Ciro Ceissler, ciro at ceissler.com.br
//------------------------------------------------------------------------------

module example1(A);
  signed input [31:0] A;
  signed wire  [31:0] B;

  assign B = A < 0 ? -A : A;

  assert property (B >= 0);
endmodule

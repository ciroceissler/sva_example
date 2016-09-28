sva_example
===========

Overview:
---------

Basics examples of how to use system verilog assertions and how to use yosys
for formal verification with sva property.

SystemVerilog Assertions:
-------------------------

The folder dut/ contains 5 finite state machine VHDL code, some of them with
bugs.  SVA is used to find these bugs and the code is at the folder testbench/.

Formal Verification with Yosys:
-------------------------------

Some examples of how to create property to formal verification is going to be
put at formal/ folder.  The RTL code will contain the property necessary to
make some basics tests.

More information:
-----------------
- mail to ciro.ceissler at gmail.com

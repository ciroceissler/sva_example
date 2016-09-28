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

How to run formal with Yosys:
-----------------------------

Bellow we show the steps necessary to run formal/example1.v:

```
$ yosys

yosys> read_verilog -sv example1.v
yosys> hierarchy -top example1
yosys> proc; -keepdc
yosys> sat -prove-asserts -show-inputs

```

More information:
-----------------
- mail to ciro.ceissler at gmail.com

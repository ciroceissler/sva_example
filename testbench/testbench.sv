//------------------------------------------------------------------------------
//
// Company: Ceissler
//
// Project: MIC59 Course
//
// Description: Simple System Verilog Assertion.
//
// Version: 1.0
//
// Author(s):
//      - Ciro Ceissler, ciro at ceissler.com.br
//
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
//
// MODULE: testbench
//
//------------------------------------------------------------------------------
module testbench;

  ///////////////////////////////////////////////////
  // signal declarations - registers
  ///////////////////////////////////////////////////
  reg clk;
  reg reset;
  reg start;
  reg [3:0] data;

  ///////////////////////////////////////////////////
  // signal declarations - variables
  ///////////////////////////////////////////////////
  reg is_less_then_100;
  reg less_then_100_done;
  reg [3:0] tmp;

  ///////////////////////////////////////////////////
  // signal declarations - wires
  ///////////////////////////////////////////////////
  wire avail;
  wire done;
  wire [1:0] flag;

  ///////////////////////////////////////////////////
  // module instantiation
  ///////////////////////////////////////////////////

  // FSM5 instantiation
  FSM5 fsm
    (
      .clk (clk) ,
      .reset (reset) ,
      .start (start) ,
      .data_in (data) ,
      .AVAIL (avail) ,
      .DONE (done) ,
      .flag (flag)
    );

  ////////////////////////////////////////////////////////////
  //
  // procedure INITIAL_CONF
  //
  // brief: inital configuration
  //
  ////////////////////////////////////////////////////////////
  initial begin : INITIAL_CONF
    clk       = 1'b0;
    reset     = 1'b1;

    data      =  'h0;
    start     = 1'b0;

    #50 reset = 1'b0;
  end

  ///////////////////////////////////////////////////////////
  //
  // procedure GEN_CLK
  //
  // brief: generate clock
  //
  ////////////////////////////////////////////////////////////
  always begin : GEN_CLK
     #1 clk = ~clk;
  end

  ///////////////////////////////////////////////////////////
  //
  // procedure TEST_CASES
  //
  // brief: test case implementation
  //
  ////////////////////////////////////////////////////////////
  always begin : TEST_CASES

     is_less_then_100 = $urandom()%2;

     wait(avail == 1'b1);

     @(posedge clk);

     start <= 1'b1 ;

     @(posedge clk);

     start <= 1'b0 ;

     if (is_less_then_100) begin
       less_then_100_done = 1'b0;
       repeat(100) begin

         if (!less_then_100_done) begin
           data  <= $urandom();
         end
         else begin
           data <= 'h0;
         end

         @(posedge clk);

         if (data == 4'b1011) begin
           less_then_100_done = 1'b1;
         end
       end
     end
     else begin
       repeat(102) begin
         tmp = $urandom();
         data  <= (tmp != 4'b1011) ? tmp : 4'b0000 ;
         @(posedge clk);
       end
     end

     repeat(2) @(posedge clk);
  end

  ///////////////////////////////////////////////////////////
  //
  // System Verilog Assertions
  //
  ////////////////////////////////////////////////////////////

  //---------------------------------
  //
  // property
  //
  // number : 000
  //
  // brief  : reset definitions
  //
  //---------------------------------
  property p_000_reset;
    @(posedge clk)
      (reset == 1'b1) |=> (done == 1'b0 & flag == 2'b00 & avail == 1'b1);
  endproperty

  assert_000_reset : assert property (p_000_reset);

  cover_000_reset : cover property (p_000_reset);

  //---------------------------------
  //
  // property
  //
  // number : 001
  //
  // brief  :
  //
  //---------------------------------
  property p_001_less_then_100;
    @(posedge clk) disable iff (reset)
    	(start == 1'b1 & avail == 1'b1) ##[1:100] (data == 4'b1011 & done == 1'b0 & avail == 1'b0)
    	|=> ##1 (done == 1'b1 & flag == 2'b01) [*2] ##1 (done == 1'b0);
  endproperty

  assert_001_less_then_100 : assert property (p_001_less_then_100);

  cover_001_less_then_100 : cover property (p_001_less_then_100);

  //---------------------------------
  //
  // property
  //
  // number : 002
  //
  // brief  :
  //
  //---------------------------------
  property p_002_equals_to_100;
    @(posedge clk) disable iff (reset)
    	(start == 1'b1 & avail == 1'b1) ##1 (data != 4'b1011 & done == 1'b0 & avail == 1'b0) [*100]
    	|=> ##1 (done == 1'b1 & flag == 2'b00) [*2] ##1 (done == 1'b0);
  endproperty

  assert_002_equals_to_100 : assert property (p_002_equals_to_100);

  cover_002_equals_to_100 : cover property (p_002_equals_to_100);

  //---------------------------------
  //
  // property
  //
  // number : 003
  //
  // brief  :
  //
  //---------------------------------
  property p_003_avail_done;
    @(posedge clk)
    	not (avail & done);
  endproperty

  assert_003_avail_done : assert property (p_003_avail_done);

  cover_003_avail_done : cover property (p_003_avail_done);

  //---------------------------------
  //
  // property
  //
  // number : 004
  //
  // brief  :
  //
  //---------------------------------
  property p_004_done_2_cycles;
    @(posedge clk) disable iff (reset)
      (done == 1'b0) ##1 (done == 1'b1)
      |=> (done == 1'b1);
  endproperty

  assert_004_done_2_cycles : assert property (p_004_done_2_cycles);

  cover_004_done_2_cycles : cover property (p_004_done_2_cycles);

  //---------------------------------
  //
  // property
  //
  // number : 005
  //
  // brief  :
  //
  //---------------------------------
  property p_005_start_avail_done;
    @(posedge clk) disable iff (reset)
      (start == 1'b1 & avail == 1'b1)
      |=> (avail == 1'b0 & done == 1'b0) [*1:100] ##1 (done == 1'b1) [*2] ##1 (avail == 1'b1);
  endproperty

  assert_005_start_avail_done : assert property (p_005_start_avail_done);

  cover_005_start_avail_done : cover property (p_005_start_avail_done);

endmodule

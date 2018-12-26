`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:20:13 12/26/2018
// Design Name:   FSM_MAN_one_shot
// Module Name:   C:/Users/Hawkins/Desktop/ex4/final/fsm_tb.v
// Project Name:  final
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: FSM_MAN_one_shot
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module fsm_tb;

	// Inputs
	reg clk;
	reg rst;
	reg data;

	// Outputs
	wire [2:0] stat;
	wire pos;
	wire neg;
	wire [3:0] num;
	wire [1:0] now;
	wire [3:0] count;

	// Instantiate the Unit Under Test (UUT)
	FSM_MAN_one_shot uut (
		.clk(clk), 
		.rst(rst), 
		.data(data), 
		.stat(stat), 
		.pos(pos), 
		.neg(neg), 
		.num(num), 
		.now(now), 
		.count(count), 
		.ji(ji)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		data = 0;

		// Wait 100 ns for global reset to finish
		#100;
		rst=1;
		data=0;
		#24;
		data=1;
		#24;
		
		data=0;
		#8;
		data=1;
		#8;
		data=0;
		#8;
		data=1;
		#8;
        
		// Add stimulus here

	end
    always #1 clk=~clk;
      
endmodule


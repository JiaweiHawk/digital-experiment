`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   08:57:24 12/25/2018
// Design Name:   pre_catch
// Module Name:   C:/Users/Hawkins/Desktop/ex4/final/pre_tb.v
// Project Name:  final
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: pre_catch
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module pre_tb;

	// Inputs
	reg clk;
	reg rst;
	reg data;

	// Outputs
	wire pre;
	wire [1:0] now;
	wire [3:0] count;
	// Instantiate the Unit Under Test (UUT)
	pre_catch uut (
		.clk(clk), 
		.rst(rst), 
		.data(data), 
		.pre(pre), 
		.now(now),
		.count(count)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		data = 1;

		// Wait 100 ns for global reset to finish
		#100;
		rst=1;
		#100;
		data = 0;
		#24;
		data=1;
		#24;
		data=1;
		#8;
		data=0;
		
        
		// Add stimulus here

	end
   always #1 clk=~clk;  
endmodule


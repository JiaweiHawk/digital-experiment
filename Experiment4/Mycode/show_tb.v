`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:45:45 12/26/2018
// Design Name:   show
// Module Name:   C:/Users/Hawkins/Desktop/ex4/final/show_tb.v
// Project Name:  final
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: show
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module show_tb;

	// Inputs
	reg clk;
	reg rst;
	reg [1:0] key;
	reg [1:0] sw;
	reg [3:0] ji;
	reg [15:0] data;

	// Outputs
	wire [6:0] light;
	wire [1:0] com;
	wire [3:0] led;
	wire [3:0] index;
	wire [25:0]tim;
	wire [7:0] num;
	// Instantiate the Unit Under Test (UUT)
	show uut (
		.clk(clk), 
		.rst(rst), 
		.key(key), 
		.sw(sw), 
		.ji(ji), 
		.light(light), 
		.com(com), 
		.led(led), 
		.data(data),
		.index(index),
		.tim(tim),
		.num(num)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		key = 0;
		sw = 2'b00;
		ji = 4'b1111;
		data = 16'b0011110000111100;

		// Wait 100 ns for global reset to finish
		#100;
      rst = 1;
		#100;
		sw=2'b01;
		key = 2'b11;
		#2;
		key = 2'b00;
		#200;
		#1000000000;
		
		// Add stimulus here

	end
	
   always #1 clk=~clk;
	
endmodule


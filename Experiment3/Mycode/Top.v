`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:20:03 12/08/2018 
// Design Name: 
// Module Name:    Top 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Top(clk,rst,key,sw,com,led,light,dp);
	input clk;
	input rst;
	input [1:0]key;
	input [1:0]sw;
	
	output [1:0]com;
	output [6:0]light;
	output [3:0]led;
	output [0:0]dp;
	
	wire [1:0]key_de;
	wire [7:0]num;
	wire [3:0]dp_tmp;
	
	debounce key_debounce (
    .clk(clk), 
    .rst(rst), 
    .key(key), 
    .key_pulse(key_de)
    );
	
	FSM fsm (
    .clk(clk), 
    .rst(rst), 
    .key(key_de), 
    .sw(sw), 
    .num(num), 
    .led(led),
	 .dp(dp_tmp)
    );
	 
	 Display_num shumaguan (
    .clk(clk),
	 .rst(rst),
    .light(light), 
    .num(num), 
    .com(com), 
    .sw(sw),
	 .dp_in(dp_tmp),
	 .dp(dp)
    );

endmodule

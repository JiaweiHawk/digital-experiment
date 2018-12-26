`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:48:24 12/18/2018 
// Design Name: 
// Module Name:    posedge_detection 
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
module posedge_detection(clk,rst,i_data_in,o_rising_edge); 
	
	input clk;
	input rst; 
	input i_data_in; 
	output o_rising_edge; 
	reg r_data_in0; 
	reg r_data_in1; 
	
	assign o_rising_edge=r_data_in0&~r_data_in1;
	
	always@(posedge clk or negedge rst)
	begin 
		if(rst==1'b0)
		begin 
			r_data_in0<=0; 
			r_data_in1<=0; 
		end 
		
		else 
		begin 
			r_data_in1<=r_data_in0; 
			r_data_in0<=i_data_in; 
		end 
	end 
	
endmodule


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:55:09 12/23/2018 
// Design Name: 
// Module Name:    FSM_MAN_one_shot 
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
module FSM_MAN_one_shot(clk,rst,data,stat,pos,neg,num,now,count,ji);
	
	input clk;
	input rst;
	input data;
	output reg [2:0]stat;
	
	output pos;
	output neg;
	output  [1:0]now;
	output  [3:0]count;
	output reg [3:0]ji;
	
	parameter sta1=3'b000;
	parameter sta2=3'b001;
	parameter sta3=3'b011;
	parameter sta4=3'b111;
	parameter sta5=3'b110;
	parameter sta6=3'b100;
	wire pre;
	wire first;
	output reg [3:0] num;
	
	always@(posedge clk or negedge rst)
	begin
		if(!rst)
		begin
			stat<=sta1;
			ji<=1;
			num<=0;
		end
		
		else
		begin
				case(stat)
				sta1:
					if( pre &&(pos || neg))
					begin
						stat<=sta2;
						num[0]<=first;
						if(pos && (ji!=15))
						begin
							num[ji]<=0;
							ji<=ji+1;
						end
						
						else
						begin
							num[ji]<=1;
							ji<=ji+1;
						end
					end
					
				sta2:
						stat<=sta3;
					
				sta3:
						stat<=sta4;
						
				sta4:
						stat<=sta5;
				sta5:
						stat<=sta6;
				sta6:
						stat<=sta1;
				default:
						stat<=sta1;
				endcase
				
		end
	end

negedge_detection neg_dec (
    .clk(clk), 
    .rst(rst), 
    .i_data_in(data), 
    .o_down_edge(neg)
    );
	 
posedge_detection pos_dec (
    .clk(clk), 
    .rst(rst), 
    .i_data_in(data), 
    .o_rising_edge(pos)
    );
	 
pre_catch pre_catch (
    .clk(clk), 
    .rst(rst), 
    .data(data), 
    .pre(pre), 
    .now(now), 
    .count(count),
	 .m_code(first)
    );
	 
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:26:29 12/26/2018 
// Design Name: 
// Module Name:    show 
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
module show(clk,rst,key,sw,ji,light,com,led,data,index,tim,num);
	
	input clk;
	input rst;
	input [1:0]key;
	input [1:0]sw;
	input [3:0]ji;				//判断是否检测最后一次
	input [15:0]data;
	output [1:0]com;
	output [6:0]light;
	output reg [3:0]led;
	
	reg mode_chu=0;
	reg zidong=0;
	output reg [25:0]tim;
	parameter s_1=50000;
	output reg [3:0] index;
	output reg [7:0] num;
	wire [7:0] num_in;
	
	assign num_in = num;
	
	always@(posedge clk or negedge rst)
	begin
		if(sw[0]==0)
		begin
			if(!rst)
			begin
				mode_chu<=1;
				led<=4'b0001;
				num<=0;
				index<=ji;
				tim<=26'b0;
				zidong<=0;
			end
			
			if(mode_chu)
			begin
				led<=4'b0010;
			end
		end
		
		else
		begin
			if(!rst)
			begin
				zidong<=0;
				index<=ji;
				tim<=26'b0;
			end
				
			
			else if(key[1]==1)
				zidong<=~zidong;
				
			if(zidong)
			begin
				if(index == 0)
				begin
					led<=4'b1000;
					num[3:0]<=data[0];
					num[7:4]<=0;
				end
				
				else
				begin
					led<=4'b0100;
					if(tim == 5'b10000)				//时间放少便于测试
					begin
						tim<=0;
						num[3:0]<=data[index];
						num[7:4]<=index;
						index<=index-1;
					end
					
					else
						tim<=tim+1;
				end
			end
		end
	end
				
				

Display_num diaplay (
    .clk(clk), 
    .rst(rst), 
    .sw(sw), 
    .light(light), 
    .num(num_in), 
    .com(com)
    );

endmodule

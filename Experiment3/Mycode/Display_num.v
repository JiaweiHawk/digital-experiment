`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:25:28 12/08/2018 
// Design Name: 
// Module Name:    shumaguan 
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
module Display_num(clk,rst,light,num,com,sw,dp_in,dp);
		
		input clk;
		input rst;
		input [1:0]sw;
		input [7:0]num;
		input [3:0]dp_in;
		
		output reg[1:0]com;
		output reg[6:0]light=7'b0;
		output reg [0:0]dp;
		
		parameter s_1=7000000;
		reg [25:0]fen;
		reg [20:0] tim=21'h0;  		
		reg [0:0]pan;
		reg [1:0]dp_tmp;
		
		always@(posedge clk or negedge rst)
		begin
			if(!rst)
			begin
				dp_tmp[1]<=1;
				dp_tmp[0]<=1;
				fen<=0;
			end
			
			else			
			if(sw[1]==1 && sw[0]==1)
			begin
					if(fen==s_1)
					begin
						fen<=0;
						if(dp_in[3]==1)
							dp_tmp[1]<=~dp_tmp[1];
						if(dp_in[1]==1)
							dp_tmp[0]<=~dp_tmp[0];
					end
					
					else
					begin
						if(dp_in[3]==0)
								dp_tmp[1]<=dp_in[2];
						if(dp_in[1]==0)
								dp_tmp[0]<=dp_in[0];
						fen<=fen+1;
					end
					
					if(tim==20'h40000) begin
						com<=2'b10;
						tim<=tim+1;
					end
					
					else if(tim==20'h80000) begin
						com<=2'b01;
						tim<=0;
					end
					
					else
						tim<=tim+1;
			end
			else
			begin
				tim<=0;
			end
		end	
		
			
		always@(com or dp_tmp)		//显示二位数
			if(sw[1]==1 && sw[0]==1) begin
				if(com[1]==1)
					begin
						dp<=dp_tmp[1];
						case(num[7:4])
							4'h0: light<=7'b1111110;
							4'h1: light<=7'b0110000;
							4'h2: light<=7'b1101101;
							4'h3: light<=7'b1111001;
							4'h4: light<=7'b0110011;
							4'h5: light<=7'b1011011;
							4'h6: light<=7'b1011111;
							4'h7: light<=7'b1110000;
							4'h8: light<=7'b1111111;
							4'h9: light<=7'b1111011;
						default: light<=7'b1111110;
						endcase
						
					end
				else
					begin
					dp<=dp_tmp[0];
						case(num[3:0])
							4'h0: light<=7'b1111110;
							4'h1: light<=7'b0110000;
							4'h2: light<=7'b1101101;
							4'h3: light<=7'b1111001;
							4'h4: light<=7'b0110011;
							4'h5: light<=7'b1011011;
							4'h6: light<=7'b1011111;
							4'h7: light<=7'b1110000;
							4'h8: light<=7'b1111111;
							4'h9: light<=7'b1111011;
						default: light<=7'b1111110;
						endcase
					end
		end
			else
			begin
				light<=7'b0;
				dp<=0;
			end
		
endmodule

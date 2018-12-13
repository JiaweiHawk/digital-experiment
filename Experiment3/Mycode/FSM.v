`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:30:00 12/08/2018 
// Design Name: 
// Module Name:    FSM 
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
module FSM(clk,rst,key,sw,num,led,dp);
	input [1:0]sw;			
	input [1:0]key;
	input rst;
	input clk;
	
	output reg[3:0]led;
	output reg[7:0]num;
	output reg[3:0]dp;
	
	parameter white_on=3'h0;	// led<=4'b1100; dp<=4'b0001;
	parameter white_off=3'h1;  // led<=4'b0; dp<=4'b0011;
	parameter sun_on=3'h2;		// led<=4'b0110; dp<=4'b0101;
	parameter sun_off=3'h3;		// led<=4'b0; dp<=4'b1111;
	parameter yellow_on=3'h4;	//	led<=4'b0011;  dp<=4'b0100;
	parameter yellow_off=3'h5;	//	led<=4'b0;  dp<=4'b1100;
	parameter s_1=5000000;						//10hz									
	
	reg[2:0]now;						//灯的状态
	reg[2:0]next;
	reg [22:0]count;
	reg pan;								//判断计时器处于计时还是终止
				
	always@(posedge clk or negedge rst) 								//Mealy状态机的输入
	begin
		if (!rst) 								//初始化设置
		begin										//此处构建一个新的输入信号pan作为状态机的输入
			num<=8'h99;
			count<=0;
			pan<=0;
		end
		
		else
		begin
			if(sw[1]==1)								//如果总电源打开
			begin
				if(key==1)								//如果转换开关被按下
				begin
						if(pan==0)							//如果在判断计时器不改变，则更改为改变
						begin
							pan<=1;
							num<=8'h99;
							count<=0;
						end
						else
							pan<=0;							//如果判断计时器改变，则相反
				end
				
				else
				begin
					if(pan==1)
					begin
						if(count==s_1)							//如果过了0.1s
						begin
							count<=0;
							if(num[3:0]==0)					//num要换位
							begin
								if(num[7:4]!=0)
								begin
									num[7:4]<=num[7:4]-1;
									num[3:0]<=4'h9;
								end
							end
							
							else
								num[3:0]<=num[3:0]-1;
						end
						
						else
							count<=count+1;
					end
				end
			end
			
			else											//如果总电源没打开
			begin	
				num<=8'h99;
				count<=0;
				pan<=0;
			end
		end	
	end
	
	always@(posedge clk or negedge rst)			//第一个进程，同步时序always模块，格式化描述次态寄存器迁移到现态寄存器
	begin
		if(!rst)
		begin
			now<=yellow_off;
		end
		
		else
			now<=next;
	end
	
	
	always@(now)								//第二个进程，组合逻辑always模块，描述状态转移条件判断
		case(now)
		
			white_on:
						begin
							if(pan==0)
								next=white_on;
							else
								next=white_off;
						end
						
			sun_on:
						begin
							if(pan==0)
								next=sun_on;
							else
								next=sun_off;
						end
						
			yellow_on:
					begin
						if(pan==0)
							next=yellow_on;
						else
							next=yellow_off;
					end
					
			white_off:
					begin
						if(pan==1)
							next=white_off;
						else
							if(sw[0]==1)									//处于demo模式
								if(num==0)
									next=white_on;
								else
									next=sun_on;
							else												//处于run模式
								if(num[7:4]<9)
									next=white_on;
								else
									next=sun_on;
					end
					
			yellow_off:
					begin
						if(pan==1)
							next=yellow_off;
						else
							next=white_on;
					end
					
			sun_off:
					begin
						if(pan==1)
							next=sun_off;
						else
							if(sw[0]==1)									//处于demo模式
								if(num==0)
									next=white_on;
								else
									next=yellow_on;
							else												//处于run模式
								if(num[7:4]<9)
									next=white_on;
								else
									next=yellow_on;
					end
			default:
				next=white_on;
		endcase	
		
		
		
		always@(posedge clk)										//第三个进程，同步时序always模块，格式化描述次态寄存器输出
			if(sw[1]==1)
			case(now)
			
			white_on:
					begin
						led<=4'b1100;
						dp<=4'b0001;
					end
						
			yellow_on:
					begin
						led<=4'b0011;
						dp<=4'b0100;
					end
						
			sun_on:
					begin
						led<=4'b0110;
						dp<=4'b0101;
					end
					
			white_off:
					begin
						led<=4'b0;
						dp<=4'b0011;
					end
						
			yellow_off:
					begin
						led<=4'b0;
						dp<=4'b1100;
					end
						
			sun_off:
					begin
						led<=4'b0;
						dp<=4'b1111;
					end
		endcase
		
		else
			led<=4'b0;
			
endmodule

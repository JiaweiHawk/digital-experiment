`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:36:03 12/23/2018 
// Design Name: 
// Module Name:    pre_catch 
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
module pre_catch(clk,rst,data,pre,now,count,m_code);
	
	input clk;
	input rst;
	input data;
	parameter sta1=2'b00;							//准备接受12个低
	parameter sta2=2'b01;							//准备接受12个高
	parameter sta3=2'b10;							//准备接受有效曼切斯特码
	parameter sta4=2'b11;							//捕获状态
	
	output reg pre;
	output reg [1:0] now;
	output reg [3:0] count;
	output reg m_code;
	
	always@(posedge clk)
	begin
		if(!rst)
		begin
			now<=sta1;
			count<=0;
			pre<=0;
			m_code<=0;
		end
		
		else
		begin
			case (now)
			
			sta1:
				if(data==0)
				begin
					if(count==11)
					begin
						count<=0;
						now<=sta2;
					end
					
					else
						count<=count+1;
				end
				
				else
					count<=0;
			
			sta2:
				if(data==1)
				begin
					if(count==11)
					begin
						count<=0;
						now<=sta3;
					end
					
					else
						count<=count+1;
				end
				
				else
				begin
					now<=sta1;
					count<=0;
				end
				
			sta3:
				if(count==0)
				begin
					m_code<=data;
					count<=count+1;
				end
				
				else if(count<4)
				begin
					if(data==m_code)
						count<=count+1;
					else
					begin
						count<=0;
						now<=sta1;
					end
				end
				
				else if(count==7)
				begin
					if(data==~m_code)
						now<=sta4;
				end
				
				else
					if(data==~m_code)
						count<=count+1;
					else
					begin
						count<=0;
						now<=sta1;
					end
			
			sta4:
			begin
					pre<= 1;            //检测曼码
			end
			endcase
		end
	end
		

endmodule

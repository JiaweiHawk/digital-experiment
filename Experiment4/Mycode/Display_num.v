`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:06:40 12/26/2018 
// Design Name: 
// Module Name:    display 
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
module Display_num(clk,rst,sw,light,num,com);

		

		input clk;

		input rst;
		
		input [1:0]sw;

		input [7:0]num;


		

		output reg[1:0]com;

		output reg[6:0]light;

		reg [19:0] tim;  		

		reg [0:0]pan;


		

		always@(posedge clk or negedge rst)

		begin

			if(!rst)

			begin


				tim<=0;
				light<=7'b0;
				com<=2'b10;

			end

			

			else			

			begin

					

					if(tim==50) begin							//时间放少便于测试

						com<=2'b10;

						tim<=tim+1;

					end

					

					else if(tim==100) begin

						com<=2'b01;

						tim<=0;

					end

					

					else

						tim<=tim+1;

			end


		end	

		

			

		always@(com)		//显示二位数
				
				begin

				if(com[1]==1)

					begin

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


		

endmodule

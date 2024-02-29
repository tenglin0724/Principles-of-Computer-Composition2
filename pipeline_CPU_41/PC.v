//PC模块
module PC(
	input Clk,										//时钟信号
	input Bubble,									//Bubble气泡阻塞
	input Reset,									//复位信号
	input [31:0] NPC,								//下一条指令的值
	output reg [31:0] PC							//clk上升沿后PC=NPC
);

//初始化
initial begin
	PC<=32'h0000_3000;
end

//功能定义
always@(posedge Clk) begin

	if(!Reset)										//Reset为0，复位
		PC<=32'h0000_3000;
	else if(Bubble!==1)								//普通情况，PC=NPC			
		PC<=NPC;
	else
		PC<=NPC-4;
		
end

endmodule

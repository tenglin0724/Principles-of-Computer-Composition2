//寄存器堆模块
module Register(Clk,WE,Rw,Ra,Rb,busA,busB,busW);

//输入输出定义
input Clk;
input WE;
input [4:0] Rw;
input [4:0] Ra;
input [4:0] Rb;
input [31:0] busW;										//要写入的数据
output reg [31:0] busA;
output reg [31:0] busB;										

//定义寄存器堆
reg [31:0] regs[0:31];									//32个位宽为32的寄存器

//初始化寄存器
integer id;
initial begin											//零号寄存器的值始终等于0
	for(id=0;id<32;id=id+1)
		begin
			regs[id]<=0;
		end	
end

//前半个周期写入数据
always@(posedge Clk) begin
	if(WE&&Rw!==0)
		regs[Rw]<=busW;
end

//后半个周期读数据
always@(negedge Clk) begin
	if(Ra==Rw&&WE)
		busA<=busW;
	else
		busA<=regs[Ra];
		
	if(Rb==Rw&&WE)
		busB<=busW;
	else
		busB<=regs[Rb];
end

endmodule






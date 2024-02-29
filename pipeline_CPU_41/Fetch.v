//取指令单元：输出当前指令的地址和获取下一条指令的地址
module Fetch(
	input Clk,											//时钟信号
	input Bubble,										//阻塞信号
	input Reset,										//复位信号
	input Zero,											//0运算结果（beq和bne）
	input Jump,											//Jump指令信号
	input Branch_beq,									//是否为beq
	input Branch_bne,									//是否为bne指令
	input Bgez,											//是否为bgez指令
	input Bgtz,											//是否为bgtz指令
	input Blez,											//是否为blez指令
	input Bltz,											//是否为bltz指令
	input ZBgez,										//bgez是否符合跳转条件
	input ZBgtz,										//bgtz是否符合跳转条件
	input Jalr,											//是否为jalr指令
	input Jal,											//是否为jal指令
	input [25:0] Target,								//j型指令的Target
	input [31:0] BPC,									//跳转指令计算的PC值
	input [31:0] Result,								//Result，jalr指令需要的busA
	
	output [31:0] Instruction,							//取出的指令										
	output [31:0] PC									
);

//中间变量
wire [31:0] PPC;
wire [31:0] NPC;


assign PPC = PC+4;

//例化NPC
NPC npc(
	.Bubble(Bubble),
	.PPC(PPC),
	.BPC(BPC),
	.Target(Target),
	.Result(Result),
	.Branch_beq(Branch_beq),
	.Branch_bne(Branch_bne),
	.Bgez(Bgez),
	.Bgtz(Bgtz),
	.Blez(Blez),
	.Bltz(Bltz),
	.ZBgez(ZBgez),
	.ZBgtz(ZBgtz),
	.Jalr(Jalr),
	.Jal(Jal),
	.Zero(Zero),
	.Jump(Jump),
	.NPC(NPC)
);

//例化PC
PC pc(
	.NPC(NPC),
	.Clk(Clk),
	.Bubble(Bubble),
	.Reset(Reset),
	.PC(PC)
);

//例化IM
IM im(
	.Addr(PC),
	.Dout(Instruction)
);

endmodule

	
	
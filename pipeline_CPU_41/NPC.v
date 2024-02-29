//NPC模块，用来计算下地址
module NPC(
    input Bubble,
	input Branch_beq,
	input Branch_bne,
	input Bgez,											//是否为bgez指令
	input Bgtz,											//是否为bgtz指令
	input Blez,											//是否为blez指令
	input Bltz,											//是否为bltz指令
	input ZBgez,										//bgez是否符合跳转条件
	input ZBgtz,										//bgtz是否符合跳转条件
	input Jalr,											//是否为jalr指令
	input Jal,
	input Zero,
	input Jump,
	input [31:0] PPC,									//当前需要更新的指令地址
	input [31:0] BPC,									//分支指令计算得到的地址
	input [25:0] Target,								//j跳转指令用来计算下地址
	input [31:0] Result,								//jr,jalr需要用到
	
	output reg [31:0] NPC
);

wire [31:0] JumpNPC;									//JUMP指令的PC

assign JumpNPC={PPC[31:28],Target,2'b00}+32'h0000_3000;

//初始化
initial begin
	NPC<=32'h0000_3000;
end

//功能定义
always@(*) begin
	if(Jump||Jal)
		NPC<=JumpNPC;
	else if(Jalr)
		NPC<=Result;
	else if(Branch_beq&&Zero)
		NPC<=BPC;
	else if(Branch_bne&&!Zero)
		NPC<=BPC;
	else if(Bgez&&ZBgez)
		NPC<=BPC;
	else if(Bltz&&!ZBgez)
		NPC<=BPC;
	else if(Bgtz&&ZBgtz)
		NPC<=BPC;
	else if(Blez&&!ZBgtz)
		NPC<=BPC;
	else if(Bubble!==1)
		NPC<=PPC;
end
		
	
endmodule

	
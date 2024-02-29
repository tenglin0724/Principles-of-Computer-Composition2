//流水段寄存器：取值和译码之间
module IFIDReg(
	input Clk,
	input Bubble_from_ca,
	input Bubble_from_loaduse,	
	input [31:0] PC_in,														//输入的PC
	input [31:0] Instruction_in,												//输入的Instruction
	
	output reg [31:0] PC_out,												//计划输出的PC：传送到后面的IDEXReg
	output reg [31:0] Instruction_out										//计划输出的指令：传送到后面的译码阶段
);

//初始化
initial begin
	PC_out<=0;
	Instruction_out<=0;
end

always@(posedge Clk) begin
	//时钟上升沿且bubble为零才能传递给下个寄存器
	if(Bubble_from_ca==1) begin
		PC_out<=0;
		Instruction_out<=0;
	end
	else if(Bubble_from_loaduse!==1)begin
		PC_out<=PC_in;
		Instruction_out<=Instruction_in;
	end
end
endmodule

//指令译码ID段（包括了寄存器）
module InstructionDecoder(
	input Clk,														//时钟信号
	input WE,														//寄存器写使能信号
	input WEHI,														//HI寄存器写使能信号
	input WELO,														//LO寄存器写使能信号
	input [4:0] Rw,													//要输入寄存器的地址
	input [31:0] Instruction,										//输入的指令
	input [31:0] BusW,												//输入的要写入寄存器的内容
	input [31:0] HiRe,												//要写入Hi寄存器的内容
	input [31:0] LoRe,												//要写入Lo寄存器的内容
	
	

	output Branch_beq,												//下面是一些控制信号
	output Branch_bne,
	output Jump,
	output RegDst,
	output ALUSrc,
	output MemtoReg,
	output RegWr,
	output MemWr,
	output ExtOp,
	output MemRead,
	output Bgez,
	output Bgtz,
	output Blez,
	output Bltz,
	output Jalr,
	output Jal,
	output B,
	output LB,
	output MFLO,
	output MFHI,
	output MTLO,
	output MTHI,
	output [4:0] ALUCtr,
	output [4:0] Rt,												//两者选通作为Rw
	output [4:0] Rs,
	output [4:0] Rd,
	output [4:0] Shamt,												//移位数据
	output [5:0] Op,												//Op数据
	output [5:0] Funct,
	output [31:0] BusA,												//输出的寄存器值
	output [31:0] BusB,												//输出的寄存器值
	output [31:0] Hout,												//输出的Hi寄存器的值
	output [31:0] Lout,												//输出的Lo寄存器的值
	output [25:0] Target,											//用于前一阶段的j指令跳转
	output [15:0] Imm16												//16位立即数																
);

wire [4:0] Ra;
wire [4:0] Rb;
assign Ra=Rs;
assign Rb=Rt;

//例化译码器
Decoder decoder(
	.Instruction(Instruction),
	.Op(Op),
	.Funct(Funct),
	.Rs(Rs),
	.Rt(Rt),
	.Rd(Rd),
	.Imm(Imm16),
	.Shamt(Shamt),
	.Target(Target)
);

//寄存器例化
Register register(
	.Clk(Clk),
	.WE(WE),
	.Rw(Rw),
	.Ra(Ra),
	.Rb(Rb),
	.busW(BusW),
	.busB(BusB),
	.busA(BusA)
);

//Lo寄存器例化
LoReg loreg(
	.Clk(Clk),
	.WE(WELO),
	.Loin(LoRe),
	.Lout(Lout)
);

//Hi寄存器例化
HiReg hireg(
	.Clk(Clk),
	.WE(WEHI),
	.Hin(HiRe),
	.Hout(Hout)
);

//例化控制信号生成器
Control_signal cs(
	.Op(Op),
	.Funct(Funct),
	.Rt(Rt),
	.Jump(Jump),
	.Branch_beq(Branch_beq),
	.Branch_bne(Branch_bne),
	.Bgez(Bgez),
	.Bgtz(Bgtz),
	.Blez(Blez),
	.Bltz(Bltz),
	.Jarl(Jalr),
	.Jal(Jal),
	.RegDst(RegDst),
	.ALUSrc(ALUSrc),
	.MemtoReg(MemtoReg),
	.RegWrite(RegWr),
	.MemWrite(MemWr),
	.ExtOp(ExtOp),
	.MemRead(MemRead),
	.B(B),
	.LB(LB),
	.ALUCtr(ALUCtr),
	.MFLO(MFLO),
	.MFHI(MFHI),
	.MTLO(MTLO),
	.MTHI(MTHI)
);

endmodule

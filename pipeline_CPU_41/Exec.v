//Exec阶段，主要功能是计算地址，结果保存
module Exec(
	input Clk,
	input ALUSrc,
	input RegDst,
	input ExtOp,
	input MemWr,
	input [31:0] Lout,
	input [31:0] Hout,
	input [15:0] Imm16,
	input [31:0] BusA,										//从寄存器中取出的旧值
	input [31:0] BusB,
	input [31:0] Result_from_exmereg,						//ALU计算完成的结果
	input [31:0] BusW_from_wb,								//最终要写入目标寄存器的结果
	input [31:0] LoRe_from_exmereg,
	input [31:0] LoRe_from_memwbreg,
	input [31:0] HiRe_from_exmereg,
	input [31:0] HiRe_from_memwbreg,
	input [4:0] ALUCtr,
	input [4:0] Shamt,
	input [31:0] PC,
	input [4:0] Rd,
	input [4:0] Rt,
	input [1:0] ALUSrcA,
	input [1:0] ALUSrcB,
	input [1:0] ALUSrcH,
	input [1:0] ALUSrcL,
	
	output Zero,
	output Of,
	output ZBgez,
    output ZBgtz,
	output reg [4:0] Rw,
	output [31:0] Result,
	output [31:0] LoRe,
	output [31:0] HiRe,
	output [31:0] BPC,
	output reg [31:0] BusB_exe										//转发后的busB
	
);

wire [31:0] Ext_Imm;
reg [31:0] BusA_alu;
reg [31:0] BusB_alu;												//进入ALU中运算的数据
reg [31:0] Lout_alu;
reg [31:0] Hout_alu;

assign Ext_Imm= (ExtOp==1) ? {{16{Imm16[15]}},Imm16} : Imm16;
assign BPC= PC+{ {14{Imm16[15]}} ,Imm16 ,2'b00};


//根据控制信号选择进入寄存器的值
always@(*) begin

	if(MemWr)
		Rw<=0;													//设置成0，防止干扰
	else if(RegDst)
		Rw<=Rd;
	else
		Rw<=Rt;
		
		
	case(ALUSrcA)
		2'b00: BusA_alu<=BusA;
		2'b01: BusA_alu<=Result_from_exmereg;
		2'b10: BusA_alu<=BusW_from_wb;
		default: BusA_alu<=32'd0;
	endcase
	
	case(ALUSrcB)
		2'b00: BusB_exe<=BusB;
		2'b01: BusB_exe<=Result_from_exmereg;
		2'b10: BusB_exe<=BusW_from_wb;
		default: BusB_exe<=32'd0;
	endcase
	
	case(ALUSrcL)
		2'b00: Lout_alu<=Lout;
		2'b01: Lout_alu<=LoRe_from_exmereg;
		2'b10: Lout_alu<=LoRe_from_memwbreg;
		default: Lout_alu<=32'd0;
	endcase
	
	case(ALUSrcH)
		2'b00: Hout_alu<=Hout;
		2'b01: Hout_alu<=HiRe_from_exmereg;
		2'b10: Hout_alu<=HiRe_from_memwbreg;
		default: Hout_alu<=32'd0;
	endcase
	
	BusB_alu<= (ALUSrc==1) ? Ext_Imm:BusB_exe;
end


//例化通用ALU
ALU alu(
	.ALUCtr(ALUCtr),
	.busA(BusA_alu),
	.busB(BusB_alu),
	.Shamt(Shamt),
	.Imm(Imm16),
	.Of(Of),
	.Zero(Zero),
	.Result(Result),
	.ZBgez(ZBgez),
	.ZBgtz(ZBgtz),
	.LoRe(LoRe),
	.HiRe(HiRe),
	.Lout(Lout_alu),
	.Hout(Hout_alu)
);

endmodule

	
	
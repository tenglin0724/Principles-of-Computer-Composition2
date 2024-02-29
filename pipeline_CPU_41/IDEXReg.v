//流水段寄存器：取值译码与ALU计算之间的
module IDEXReg(
	input Clk,
	input Bubble,
	input Branch_beq_in,										//下面是一些控制信号
	input Branch_bne_in,
	input Jump_in,
	input RegDst_in,
	input ALUSrc_in,
	input MemtoReg_in,
	input RegWr_in,
	input MemWr_in,
	input ExtOp_in,
	input MemRead_in,
	input Bgez_in,
	input Bgtz_in,
	input Blez_in,
	input Bltz_in,
	input Jalr_in,
	input Jal_in,
	input B_in,
	input LB_in,
	input MFLO_in,
	input MFHI_in,
	input MTLO_in,
	input MTHI_in,
	input [4:0] ALUCtr_in,
	input [31:0] Lout_in,
	input [31:0] Hout_in,
	input [31:0] PC_in,
	input [25:0] Target_in,
	input [15:0] Imm16_in,
	input [31:0] BusA_in,
	input [31:0] BusB_in,
	input [4:0] Rs_in,
	input [4:0] Rt_in,											//用于后面Rw的确定
	input [4:0] Rd_in,
	input [4:0] Shamt_in,										//移位数据
	input [5:0] Op_in,											//Op数据
	input [5:0] Funct_in,
	

	output reg Branch_beq_out,										//下面是一些控制信号
	output reg Branch_bne_out,
	output reg Jump_out,
	output reg RegDst_out,
	output reg ALUSrc_out,
	output reg MemtoReg_out,
	output reg RegWr_out,
	output reg MemWr_out,
	output reg ExtOp_out,
	output reg MemRead_out,
	output reg Bgez_out,
	output reg Bgtz_out,
	output reg Blez_out,
	output reg Bltz_out,
	output reg Jalr_out,
	output reg Jal_out,
	output reg B_out,
	output reg LB_out,
	output reg MFLO_out,
	output reg MFHI_out,
	output reg MTLO_out,
	output reg MTHI_out,
	output reg [4:0] ALUCtr_out,
	output reg [31:0] Lout_out,
	output reg [31:0] Hout_out,
	output reg [31:0] PC_out,
	output reg [25:0] Target_out,
	output reg [15:0] Imm16_out,
	output reg [31:0] BusA_out,
	output reg [31:0] BusB_out,
	output reg [4:0] Rs_out,
	output reg [4:0] Rt_out,											//用于后面Rw的确定
	output reg [4:0] Rd_out,
	output reg [4:0] Shamt_out,										//移位数据
	output reg [5:0] Op_out,											//Op数据
	output reg [5:0] Funct_out
);
//初始化
initial begin
	PC_out<=0;
	Target_out<=0;
	Imm16_out<=0;
	BusA_out<=0;
	BusB_out<=0;
	Rs_out<=0;
	Rt_out<=0;												
	Rd_out<=0;
	Shamt_out<=0;										
	Op_out<=0;												
	Funct_out<=0;
	Branch_beq_out<=0;										
	Branch_bne_out<=0;
	Jump_out<=0;
	RegDst_out<=0;
	ALUSrc_out<=0;
	MemtoReg_out<=0;
	RegWr_out<=0;
	MemWr_out<=0;
	ExtOp_out<=0;
	ALUCtr_out<=0;
	MemRead_out<=0;
	Bgez_out<=0;
	Bgtz_out<=0;
	Blez_out<=0;
	Bltz_out<=0;
	Jalr_out<=0;
	Jal_out<=0;
	B_out<=0;
	LB_out<=0;
	MFLO_out<=0;
	MFHI_out<=0;
	MTLO_out<=0;
	MTHI_out<=0;
	Lout_out<=0;
	Hout_out<=0;
end

always@(posedge Clk) begin
	if(Bubble==1) begin
		PC_out<=0;
		Target_out<=0;
		Imm16_out<=0;
		BusA_out<=0;
		BusB_out<=0;
		Rs_out<=0;
		Rt_out<=0;												
		Rd_out<=0;
		Shamt_out<=0;										
		Op_out<=0;												
		Funct_out<=0;
		Branch_beq_out<=0;										
		Branch_bne_out<=0;
		Jump_out<=0;
		RegDst_out<=0;
		ALUSrc_out<=0;
		MemtoReg_out<=0;
		RegWr_out<=0;
		MemWr_out<=0;
		ExtOp_out<=0;
		ALUCtr_out<=0;
		MemRead_out<=0;
		Bgez_out<=0;
		Bgtz_out<=0;
		Blez_out<=0;
		Bltz_out<=0;
		Jalr_out<=0;
		Jal_out<=0;
		B_out<=0;
		LB_out<=0;
		MFLO_out<=0;
		MFHI_out<=0;
		MTLO_out<=0;
		MTHI_out<=0;
		Lout_out<=0;
		Hout_out<=0;
	end
	else begin																
		PC_out<=PC_in;
		Target_out<=Target_in;
		Imm16_out<=Imm16_in;
		BusA_out<=BusA_in;
		BusB_out<=BusB_in;
		Rs_out<=Rs_in;
		Rt_out<=Rt_in;												
		Rd_out<=Rd_in;
		Shamt_out<=Shamt_in;										
		Op_out<=Op_in;												
		Funct_out<=Funct_in;
		Branch_beq_out<=Branch_beq_in;										
		Branch_bne_out<=Branch_bne_in;
		Jump_out<=Jump_in;
		RegDst_out<=RegDst_in;
		ALUSrc_out<=ALUSrc_in;
		MemtoReg_out<=MemtoReg_in;
		RegWr_out<=RegWr_in;
		MemWr_out<=MemWr_in;
		ExtOp_out<=ExtOp_in;
		ALUCtr_out<=ALUCtr_in;
		MemRead_out<=MemRead_in;
		Bgez_out<=Bgez_in;
		Bgtz_out<=Bgtz_in;
		Blez_out<=Blez_in;
		Bltz_out<=Bltz_in;
		Jalr_out<=Jalr_in;
		Jal_out<=Jal_in;
		B_out<=B_in;
		LB_out<=LB_in;
		MFLO_out<=MFLO_in;
		MFHI_out<=MFHI_in;
		MTLO_out<=MTLO_in;
		MTHI_out<=MTHI_in;
		Lout_out<=Lout_in;
		Hout_out<=Hout_in;
	end
end
endmodule

	
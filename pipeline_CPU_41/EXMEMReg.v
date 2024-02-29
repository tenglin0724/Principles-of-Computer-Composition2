//流水段寄存器：在计算和访问内存之间
module EXMEMReg(
	input Clk,
	input Bubble,
	input Branch_beq_in,										//下面是一些控制信号
	input Branch_bne_in,
	input Jump_in,
	input MemtoReg_in,
	input RegWr_in,
	input MemWr_in,
	input MemRead_in,
	input Bgez_in,
	input Bgtz_in,
	input Blez_in,
	input Bltz_in,
	input Jalr_in,
	input Jal_in,
	input B_in,
	input LB_in,
	input Zero_in,
	input Of_in,
	input ZBgtz_in,
	input ZBgez_in,
	input MTLO_in,
	input MTHI_in,
	input [31:0] BPC_in,
	input [31:0] Result_in,
	input [31:0] BusA_in,
	input [31:0] BusB_in,
	input [4:0] Rw_in,
	input [25:0] Target_in,
	input [4:0]	Rt_in,
	input [31:0] PC_in,
	input [31:0] LoRe_in,
	input [31:0] HiRe_in,
	
	output reg Branch_beq_out,										//下面是一些控制信号
	output reg Branch_bne_out,
	output reg Jump_out,
	output reg MemtoReg_out,
	output reg RegWr_out,
	output reg MemWr_out,
	output reg MemRead_out,
	output reg Bgez_out,
	output reg Bgtz_out,
	output reg Blez_out,
	output reg Bltz_out,
	output reg Jalr_out,
	output reg Jal_out,
	output reg B_out,
	output reg LB_out,
	output reg Zero_out,
	output reg Of_out,
	output reg ZBgtz_out,
	output reg ZBgez_out,
	output reg MTLO_out,
	output reg MTHI_out,
	output reg [31:0] PC_out,
	output reg [31:0] BPC_out,
	output reg [31:0] Result_out,
	output reg [31:0] BusA_out,
	output reg [31:0] BusB_out,
	output reg [4:0] Rw_out,
	output reg [25:0] Target_out,
	output reg [4:0] Rt_out,
	output reg [31:0] LoRe_out,
	output reg [31:0] HiRe_out
);

//初始化
initial begin
	BPC_out<=0;
	Target_out<=0;
	BusA_out<=0;
	BusB_out<=0;
	Rt_out<=0;
	Rw_out<=0;																						
	Branch_beq_out<=0;										
	Branch_bne_out<=0;
	Jump_out<=0;
	MemtoReg_out<=0;
	RegWr_out<=0;
	MemWr_out<=0;
	MemRead_out<=0;
	Bgez_out<=0;
	Bgtz_out<=0;
	Blez_out<=0;
	Bltz_out<=0;
	Jalr_out<=0;
	Jal_out<=0;
	B_out<=0;
	LB_out<=0;
	ZBgez_out<=0;
	ZBgtz_out<=0;
	Zero_out<=0;
	Of_out<=0;
	Result_out<=0;
	PC_out<=0;
	MTLO_out<=0;
	MTHI_out<=0;
	LoRe_out<=0;
	HiRe_out<=0;
end

always@(posedge Clk)begin
	if(Bubble==1) begin
		BPC_out<=0;
		Target_out<=0;
		BusA_out<=0;
		BusB_out<=0;
		Rt_out<=0;
		Rw_out<=0;																						
		Branch_beq_out<=0;										
		Branch_bne_out<=0;
		Jump_out<=0;
		MemtoReg_out<=0;
		RegWr_out<=0;
		MemWr_out<=0;
		MemRead_out<=0;
		Bgez_out<=0;
		Bgtz_out<=0;
		Blez_out<=0;
		Bltz_out<=0;
		Jalr_out<=0;
		Jal_out<=0;
		B_out<=0;
		LB_out<=0;
		ZBgez_out<=0;
		ZBgtz_out<=0;
		Zero_out<=0;
		Of_out<=0;
		Result_out<=0;
		PC_out<=0;
		MTLO_out<=0;
		MTHI_out<=0;
		LoRe_out<=0;
		HiRe_out<=0;
	end
	else begin
		BPC_out<=BPC_in;
		Target_out<=Target_in;
		BusA_out<=BusA_in;
		BusB_out<=BusB_in;
		Rt_out<=Rt_in;
		Rw_out<=Rw_in;																						
		Branch_beq_out<=Branch_beq_in;										
		Branch_bne_out<=Branch_bne_in;
		Jump_out<=Jump_in;
		MemtoReg_out<=MemtoReg_in;
		RegWr_out<=RegWr_in;
		MemWr_out<=MemWr_in;
		MemRead_out<=MemRead_in;
		Bgez_out<=Bgez_in;
		Bgtz_out<=Bgtz_in;
		Blez_out<=Blez_in;
		Bltz_out<=Bltz_in;
		Jalr_out<=Jalr_in;
		Jal_out<=Jal_in;
		B_out<=B_in;
		LB_out<=LB_in;
		ZBgez_out<=ZBgez_in;
		ZBgtz_out<=ZBgtz_in;
		Zero_out<=Zero_in;
		Of_out<=Of_in;
		Result_out<=Result_in;
		PC_out<=PC_in;
		MTLO_out<=MTLO_in;
		MTHI_out<=MTHI_in;
		LoRe_out<=LoRe_in;
		HiRe_out<=HiRe_in;
	end
	
end

endmodule

	
	
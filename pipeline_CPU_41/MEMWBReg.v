//流水段寄存器，在访存和写回之间
module MEMWBReg(
	input Clk,
	input MemtoReg_in,
	input RegWr_in,
	input Of_in,
	input Jal_in,
	input MTLO_in,
	input MTHI_in,
	input [31:0] Dout_in,
	input [31:0] Result_in,
	input [4:0] Rw_in,
	input [31:0] PC_in,
	input [31:0] LoRe_in,
	input [31:0] HiRe_in,
	

	output reg MemtoReg_out,
	output reg RegWr_out,
	output reg Of_out,
	output reg Jal_out,
	output reg MTLO_out,
	output reg MTHI_out,
	output reg [31:0] PC_out,
	output reg [31:0] Dout_out,
	output reg [4:0] Rw_out,
	output reg [31:0] Result_out,
	output reg [31:0] LoRe_out,
	output reg [31:0] HiRe_out
);
//初始化
initial begin
	MemtoReg_out<=0;
	RegWr_out<=0;
	Of_out<=0;
	Dout_out<=0;
	Rw_out<=0;
	Result_out<=0;
	Jal_out<=0;
	PC_out<=0;
	MTLO_out<=0;
	MTHI_out<=0;
	LoRe_out<=0;
	HiRe_out<=0;
	
end

always@(posedge Clk) begin
	MemtoReg_out<=MemtoReg_in;
	RegWr_out<=RegWr_in;
	Of_out<=Of_in;
	Dout_out<=Dout_in;
	Rw_out<=Rw_in;
	Result_out<=Result_in;
	Jal_out<=Jal_in;
	PC_out<=PC_in;
	MTLO_out<=MTLO_in;
	MTHI_out<=MTHI_in;
	LoRe_out<=LoRe_in;
	HiRe_out<=HiRe_in;
end

endmodule

	
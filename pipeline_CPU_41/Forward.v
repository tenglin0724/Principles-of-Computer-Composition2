//转发模块
module Forward(
	input [4:0] Rs_from_idexreg,								//来自于译码结束的下一条指令的Rs			
	input [4:0] Rt_from_idexreg,
	
	input [4:0] Rw_from_exmemreg,								//来自前面指令的rw寄存器
	input [4:0] Rw_from_memwbreg,								//回写阶段的目标寄存器
	
	input MFHI_from_idexreg,
	input MFLO_from_idexreg,
	
	input MTLO_from_exmemreg,
	input MTHI_from_exmemreg,
	input MTLO_from_memwbreg,
	input MTHI_from_memwbreg,
	
	input RegWr_from_exmemreg,									//写使能信号，防止一些不写入寄存器但也符合条件的指令出现
	input RegWr_from_memwbreg,
	
	//input ALUSrc_from_idexreg,									//busB选择立即数
	
	output reg [1:0] ALUSrcA,										//控制busA的控制信号
	output reg [1:0] ALUSrcB,										//控制busB的控制信号
	output reg [1:0] ALUSrcL,
	output reg [1:0] ALUSrcH
);

//初始化
initial begin
	ALUSrcA<=0;
	ALUSrcB<=0;
	ALUSrcL<=0;
	ALUSrcH<=0;
end


always@(*) begin

	//得到ALUSrcA
	if(RegWr_from_exmemreg && (Rw_from_exmemreg!==0) && (Rw_from_exmemreg==Rs_from_idexreg))
		ALUSrcA<=2'b01;
	else if(RegWr_from_memwbreg && (Rw_from_memwbreg!==0) && (Rw_from_exmemreg!==Rs_from_idexreg) && (Rw_from_memwbreg==Rs_from_idexreg))
		ALUSrcA<=2'b10;
	else
		ALUSrcA<=0;
		
	
	//得到ALUSrcB
	if(RegWr_from_exmemreg && (Rw_from_exmemreg!==0) && (Rw_from_exmemreg==Rt_from_idexreg))
		ALUSrcB<=2'b01;
	else if(RegWr_from_memwbreg && (Rw_from_memwbreg!==0) && (Rw_from_exmemreg!==Rt_from_idexreg) && (Rw_from_memwbreg==Rt_from_idexreg))
		ALUSrcB<=2'b10;
	else 
		ALUSrcB<=0;
		
	//得到ALUSrcH
	if(MTHI_from_exmemreg==1&&MFHI_from_idexreg==1)
		ALUSrcH<=2'b01;
	else if(MTHI_from_exmemreg!==1&&MTHI_from_memwbreg==1&&MFHI_from_idexreg==1)
		ALUSrcH<=2'b10;
	else
		ALUSrcH<=0;
		
	//得到ALUSrcB
	if(MTLO_from_exmemreg==1&&MFLO_from_idexreg==1)
		ALUSrcL<=2'b01;
	else if(MTLO_from_exmemreg!==1&&MTLO_from_memwbreg==1&&MFLO_from_idexreg==1)
		ALUSrcL<=2'b10;
	else 
		ALUSrcL<=0;
		
end


endmodule

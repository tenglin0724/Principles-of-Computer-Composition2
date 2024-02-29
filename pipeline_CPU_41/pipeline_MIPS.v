//流水线CPU
module pipeline_MIPS(
	input Clk,													//时钟信号
	input Reset													//复位信号
);

wire Bubble_from_ca;
wire Bubble_from_loaduse;
//*****************************************************Fetch***********************************************//
//input
wire Zero_from_exmereg;																					
wire Jump_from_exmereg;											//Jump指令信号
wire Branch_beq_from_exmereg;									//是否为beq
wire Branch_bne_from_exmereg;									//是否为bne指令
wire Bgez_from_exmereg;											//是否为bgez指令
wire Bgtz_from_exmereg;											//是否为bgtz指令
wire Blez_from_exmereg;											//是否为blez指令
wire Bltz_from_exmereg;											//是否为bltz指令
wire ZBgez_from_exmereg;										//bgez是否符合跳转条件
wire ZBgtz_from_exmereg;										//bgtz是否符合跳转条件
wire Jalr_from_exmereg;											//是否为jalr指令
wire Jal_from_exmereg;											//是否为jal指令
wire [31:0] BPC_from_exmereg;									//跳转指令计算的PC值
wire [25:0] Target_from_exmereg;								//j型指令的Target
wire [31:0] Result_from_exmereg;
wire [31:0] BusA_from_exmereg;									//busA

//output
wire [31:0] Instruction_from_fetch;							//作为idifreg的输入
wire [31:0] PC_from_fetch;									//作为idifreg的输入

//例化取指令单元
Fetch fetch(
	.Clk(Clk),
	.Reset(Reset),
	.Bubble(Bubble_from_loaduse&(~Bubble_from_ca)),
	.Zero(Zero_from_exmereg),
	.Jump(Jump_from_exmereg),
	.Branch_beq(Branch_beq_from_exmereg),
	.Branch_bne(Branch_bne_from_exmereg),
	.Bgez(Bgez_from_exmereg),
	.Bgtz(Bgtz_from_exmereg),
	.Blez(Blez_from_exmereg),
	.Bltz(Bltz_from_exmereg),
	.ZBgez(ZBgez_from_exmereg),
	.ZBgtz(ZBgtz_from_exmereg),
	.Jalr(Jalr_from_exmereg),
	.Jal(Jal_from_exmereg),
	.BPC(BPC_from_exmereg),
	.Target(Target_from_exmereg),
	.Result(Result_from_exmereg),
	
	.Instruction(Instruction_from_fetch),
	.PC(PC_from_fetch)
);




//**************************************************IFIDReg*********************************************//


//output
wire [31:0] PC_from_ifidreg;												//计划输出的PC：传送到后面的IDEXReg
wire [31:0] Instruction_from_ifidreg;										//计划输出的指令：传送到后面的译码阶段


//例化取值/译码段寄存器
IFIDReg ifidreg(
	.Clk(Clk),
	.Bubble_from_ca(Bubble_from_ca),
	.Bubble_from_loaduse(Bubble_from_loaduse),
	.PC_in(PC_from_fetch),
	.Instruction_in(Instruction_from_fetch),
	
	.PC_out(PC_from_ifidreg),
	.Instruction_out(Instruction_from_ifidreg)
);


//*******************************************************InstructionDecoder********************************************//

//input
wire WE_from_wb;														//寄存器写使能
wire MTLO_from_memwbreg;
wire MTHI_from_memwbreg;
wire [4:0] Rw_from_wb;													//要写入目标寄存器的地址
wire [31:0] BusW_from_wb;												//要写入目标寄存器的内容
wire [31:0] LoRe_from_memwbreg;
wire [31:0] HiRe_from_memwbreg;




//ouput

wire Branch_beq_from_id;											//下面是一些控制信号
wire Branch_bne_from_id;
wire Jump_from_id;
wire RegDst_from_id;
wire ALUSrc_from_id;
wire MemtoReg_from_id;
wire RegWr_from_id;
wire MemWr_from_id;
wire ExtOp_from_id;
wire MemRead_from_id;
wire Bgez_from_id;
wire Bgtz_from_id;
wire Blez_from_id;
wire Bltz_from_id;
wire Jalr_from_id;
wire Jal_from_id;
wire B_from_id;
wire LB_from_id;
wire MFLO_from_id;
wire MFHI_from_id;
wire MTLO_from_id;
wire MTHI_from_id;
wire [4:0] ALUCtr_from_id;
wire [4:0] Rs_from_id;															
wire [4:0] Rt_from_id;												//两者选通作为Rw
wire [4:0] Rd_from_id;
wire [4:0] Shamt_from_id;											//移位数据
wire [5:0] Op_from_id;												//Op数据
wire [5:0] Funct_from_id;
wire [31:0] BusA_from_id;											//输出的寄存器值
wire [31:0] BusB_from_id;											//输出的寄存器值
wire [31:0] Hout_from_id;
wire [31:0] Lout_from_id;
wire [25:0] Target_from_id;											//用于前一阶段的j指令跳转
wire [15:0] Imm16_from_id;											//16位立即数	


//例化译码部分
InstructionDecoder id(
	.Clk(Clk),										
	.WE(WE_from_wb),
	.WEHI(MTHI_from_memwbreg),
	.WELO(MTLO_from_memwbreg),
	.Instruction(Instruction_from_ifidreg),
	.BusW(BusW_from_wb),
	.LoRe(LoRe_from_memwbreg),
	.HiRe(HiRe_from_memwbreg),
	.Rw(Rw_from_wb),
	
	.BusA(BusA_from_id),
	.BusB(BusB_from_id),
	.Lout(Lout_from_id),
	.Hout(Hout_from_id),
	.Target(Target_from_id),
	.Imm16(Imm16_from_id),
	.Rs(Rs_from_id),
	.Rt(Rt_from_id),
	.Rd(Rd_from_id),
	.Shamt(Shamt_from_id),
	.Op(Op_from_id),
	.Funct(Funct_from_id),
	.Branch_beq(Branch_beq_from_id),
	.Branch_bne(Branch_bne_from_id),
	.Jump(Jump_from_id),
	.RegDst(RegDst_from_id),
	.ALUSrc(ALUSrc_from_id),
	.ALUCtr(ALUCtr_from_id),
	.MemtoReg(MemtoReg_from_id),
	.RegWr(RegWr_from_id),
	.MemWr(MemWr_from_id),
	.ExtOp(ExtOp_from_id),
	.MemRead(MemRead_from_id),
	.Bgez(Bgez_from_id),
	.Bgtz(Bgtz_from_id),
	.Blez(Blez_from_id),
	.Bltz(Bltz_from_id),
	.Jalr(Jalr_from_id),
	.Jal(Jal_from_id),
	.B(B_from_id),
	.LB(LB_from_id),
	.MFLO(MFLO_from_id),
	.MFHI(MFHI_from_id),
	.MTLO(MTLO_from_id),
	.MTHI(MTHI_from_id)
);


//**********************************************************IDEXReg*************************************************//

//input

//ouput
wire Branch_beq_from_idexreg;										//下面是一些控制信号
wire Branch_bne_from_idexreg;
wire Jump_from_idexreg;
wire RegDst_from_idexreg;
wire ALUSrc_from_idexreg;
wire MemtoReg_from_idexreg;
wire RegWr_from_idexreg;
wire MemWr_from_idexreg;
wire ExtOp_from_idexreg;
wire [4:0] ALUCtr_from_idexreg;
wire MemRead_from_idexreg;
wire Bgez_from_idexreg;
wire Bgtz_from_idexreg;
wire Blez_from_idexreg;
wire Bltz_from_idexreg;
wire Jalr_from_idexreg;
wire Jal_from_idexreg;
wire B_from_idexreg;
wire LB_from_idexreg;
wire MFHI_from_idexreg;
wire MFLO_from_idexreg;
wire MTHI_from_idexreg;
wire MTLO_from_idexreg;
wire [31:0] Lout_from_idexreg;
wire [31:0] Hout_from_idexreg;
wire [31:0] PC_from_idexreg;
wire [25:0] Target_from_idexreg;
wire [15:0] Imm16_from_idexreg;
wire [31:0] BusA_from_idexreg;
wire [31:0] BusB_from_idexreg;
wire [4:0] Rs_from_idexreg;
wire [4:0] Rt_from_idexreg;											//用于后面Rw的确定
wire [4:0] Rd_from_idexreg;
wire [4:0] Shamt_from_idexreg;										//移位数据
wire [5:0] Op_from_idexreg;											//Op数据
wire [5:0] Funct_from_idexreg;

//例化译码/计算流水段寄存器
IDEXReg idexreg(
	.Clk(Clk),
	.Bubble(Bubble_from_loaduse||Bubble_from_ca),
	.PC_in(PC_from_ifidreg),
	.Target_in(Target_from_id),
	.Imm16_in(Imm16_from_id),
	.BusA_in(BusA_from_id),
	.BusB_in(BusB_from_id),
	.Rs_in(Rs_from_id),
	.Rt_in(Rt_from_id),											
	.Rd_in(Rd_from_id),
	.Shamt_in(Shamt_from_id),										
	.Op_in(Op_from_id),											
	.Funct_in(Funct_from_id),
	.Branch_beq_in(Branch_beq_from_id),									
	.Branch_bne_in(Branch_bne_from_id),
	.Jump_in(Jump_from_id),
	.RegDst_in(RegDst_from_id),
	.ALUSrc_in(ALUSrc_from_id),
	.MemtoReg_in(MemtoReg_from_id),
	.RegWr_in(RegWr_from_id),
	.MemWr_in(MemWr_from_id),
	.ExtOp_in(ExtOp_from_id),
	.ALUCtr_in(ALUCtr_from_id),
	.MemRead_in(MemRead_from_id),
	.Bgez_in(Bgez_from_id),
	.Bgtz_in(Bgtz_from_id),
	.Blez_in(Blez_from_id),
	.Bltz_in(Bltz_from_id),
	.Jalr_in(Jalr_from_id),
	.Jal_in(Jal_from_id),
	.B_in(B_from_id),
	.LB_in(LB_from_id),
	.MFLO_in(MFLO_from_id),
	.MFHI_in(MFHI_from_id),
	.MTLO_in(MTLO_from_id),
	.MTHI_in(MTHI_from_id),
	.Lout_in(Lout_from_id),
	.Hout_in(Hout_from_id),
	
	.PC_out(PC_from_idexreg),
	.Target_out(Target_from_idexreg),
	.Imm16_out(Imm16_from_idexreg),
	.BusA_out(BusA_from_idexreg),
	.BusB_out(BusB_from_idexreg),
	.Rs_out(Rs_from_idexreg),
	.Rt_out(Rt_from_idexreg),											//用于后面Rw的确定
	.Rd_out(Rd_from_idexreg),
	.Shamt_out(Shamt_from_idexreg),										//移位数据
	.Op_out(Op_from_idexreg),											//Op数据
	.Funct_out(Funct_from_idexreg),
	.Branch_beq_out(Branch_beq_from_idexreg),										//下面是一些控制信号
	.Branch_bne_out(Branch_bne_from_idexreg),
	.Jump_out(Jump_from_idexreg),
	.RegDst_out(RegDst_from_idexreg),
	.ALUSrc_out(ALUSrc_from_idexreg),
	.MemtoReg_out(MemtoReg_from_idexreg),
	.RegWr_out(RegWr_from_idexreg),
	.MemWr_out(MemWr_from_idexreg),
	.ExtOp_out(ExtOp_from_idexreg),
	.ALUCtr_out(ALUCtr_from_idexreg),
	.MemRead_out(MemRead_from_idexreg),
	.Bgez_out(Bgez_from_idexreg),
	.Bgtz_out(Bgtz_from_idexreg),
	.Blez_out(Blez_from_idexreg),
	.Bltz_out(Bltz_from_idexreg),
	.Jalr_out(Jalr_from_idexreg),
	.Jal_out(Jal_from_idexreg),
	.B_out(B_from_idexreg),
	.LB_out(LB_from_idexreg),
	.MFLO_out(MFLO_from_idexreg),
	.MFHI_out(MFHI_from_idexreg),
	.MTLO_out(MTLO_from_idexreg),
	.MTHI_out(MTHI_from_idexreg),
	.Lout_out(Lout_from_idexreg),
	.Hout_out(Hout_from_idexreg)
);


//*************************************************************Exec*****************************************************//

//input
wire [1:0] ALUSrcA_from_forward;
wire [1:0] ALUSrcB_from_forward;
wire [1:0] ALUSrcH_from_forward;
wire [1:0] ALUSrcL_from_forward;
wire [31:0] LoRe_from_exmereg;
wire [31:0] HiRe_from_exmereg;

//output
wire [4:0] Rw_from_exec;
wire Zero_from_exec;
wire Of_from_exec;
wire ZBgez_from_exec;
wire ZBgtz_from_exec;
wire [31:0] Result_from_exec;
wire [31:0] HiRe_from_exec;
wire [31:0] LoRe_from_exec;
wire [31:0] BPC_from_exec;
wire [31:0] BusB_exe;


//例化计算单元
Exec exec(
	.Clk(Clk),
	.Imm16(Imm16_from_idexreg),
	.BusA(BusA_from_idexreg),
	.BusB(BusB_from_idexreg),
	.Result_from_exmereg(Result_from_exmereg),
	.LoRe_from_exmereg(LoRe_from_exmereg),
	.LoRe_from_memwbreg(LoRe_from_memwbreg),
	.HiRe_from_exmereg(HiRe_from_exmereg),
	.HiRe_from_memwbreg(HiRe_from_memwbreg),
	.BusW_from_wb(BusW_from_wb),
	.ALUCtr(ALUCtr_from_idexreg),
	.Shamt(Shamt_from_idexreg),
	.PC(PC_from_idexreg),
	.Rd(Rd_from_idexreg),
	.Rt(Rt_from_idexreg),
	.RegDst(RegDst_from_idexreg),
	.ALUSrcA(ALUSrcA_from_forward),
	.ALUSrcB(ALUSrcB_from_forward),
	.ALUSrcH(ALUSrcH_from_forward),
	.ALUSrcL(ALUSrcL_from_forward),
	.ALUSrc(ALUSrc_from_idexreg),
	.ExtOp(ExtOp_from_idexreg),
	.MemWr(MemWr_from_idexreg),
	.Lout(Lout_from_idexreg),
	.Hout(Hout_from_idexreg),
	
	.Rw(Rw_from_exec),
	.Zero(Zero_from_exec),
	.Of(Of_from_exec),
	.ZBgez(ZBgez_from_exec),
    .ZBgtz(ZBgtz_from_exec),
	.Result(Result_from_exec),
	.HiRe(HiRe_from_exec),
	.LoRe(LoRe_from_exec),
	.BPC(BPC_from_exec),
	.BusB_exe(BusB_exe)
);

//*************************************************EXMEReg**********************************************************//

//input 
//output
wire Of_from_exmereg;
wire MemtoReg_from_exmereg;
wire RegWr_from_exmereg;
wire MemWr_from_exmereg;
wire MemRead_from_exmereg;
wire B_from_exmereg;
wire LB_from_exmereg;
wire MTLO_from_exmereg;
wire MTHI_from_exmereg;
wire [31:0] BusB_from_exmereg;
wire [4:0] Rw_from_exmereg;
wire [4:0] Rt_from_exmereg;
wire [31:0] PC_from_exmereg;


//例化计算/访存寄存器
EXMEMReg exmereg(
	.Clk(Clk),
	.Bubble(Bubble_from_ca),
	.Branch_beq_in(Branch_beq_from_idexreg),										//下面是一些控制信号
	.Branch_bne_in(Branch_bne_from_idexreg),
	.Jump_in(Jump_from_idexreg),
	.MemtoReg_in(MemtoReg_from_idexreg),
	.RegWr_in(RegWr_from_idexreg),
	.MemWr_in(MemWr_from_idexreg),
	.MemRead_in(MemRead_from_idexreg),
	.Bgez_in(Bgez_from_idexreg),
	.Bgtz_in(Bgtz_from_idexreg),
	.Blez_in(Blez_from_idexreg),
	.Bltz_in(Bltz_from_idexreg),
	.Jalr_in(Jalr_from_idexreg),
	.Jal_in(Jal_from_idexreg),
	.B_in(B_from_idexreg),
	.LB_in(LB_from_idexreg),
	.Zero_in(Zero_from_exec),
	.Of_in(Of_from_exec),
	.ZBgtz_in(ZBgtz_from_exec),
	.ZBgez_in(ZBgez_from_exec),
	.BPC_in(BPC_from_exec),
	.Result_in(Result_from_exec),
	.BusA_in(BusA_from_idexreg),
	.BusB_in(BusB_exe),
	.Rw_in(Rw_from_exec),
	.Target_in(Target_from_idexreg),
	.Rt_in(Rt_from_idexreg),
	.PC_in(PC_from_idexreg),
	.MTLO_in(MTLO_from_idexreg),
	.MTHI_in(MTHI_from_idexreg),
	.LoRe_in(LoRe_from_exec),
	.HiRe_in(HiRe_from_exec),
	
	.PC_out(PC_from_exmereg),
	.Branch_beq_out(Branch_beq_from_exmereg),										
	.Branch_bne_out(Branch_bne_from_exmereg),
	.Jump_out(Jump_from_exmereg),
	.MemtoReg_out(MemtoReg_from_exmereg),
	.RegWr_out(RegWr_from_exmereg),
	.MemWr_out(MemWr_from_exmereg),
	.MemRead_out(MemRead_from_exmereg),
	.Bgez_out(Bgez_from_exmereg),
	.Bgtz_out(Bgtz_from_exmereg),
	.Blez_out(Blez_from_exmereg),
	.Bltz_out(Bltz_from_exmereg),
	.Jalr_out(Jalr_from_exmereg),
	.Jal_out(Jal_from_exmereg),
	.B_out(B_from_exmereg),
	.LB_out(LB_from_exmereg),
	.Zero_out(Zero_from_exmereg),
	.Of_out(Of_from_exmereg),
	.ZBgtz_out(ZBgtz_from_exmereg),
	.ZBgez_out(ZBgez_from_exmereg),
	.BPC_out(BPC_from_exmereg),
	.Result_out(Result_from_exmereg),
	.BusA_out(BusA_from_exmereg),
	.BusB_out(BusB_from_exmereg),
	.Rw_out(Rw_from_exmereg),
	.Target_out(Target_from_exmereg),
	.Rt_out(Rt_from_exmereg),
	.MTLO_out(MTLO_from_exmereg),
	.MTHI_out(MTHI_from_exmereg),
	.LoRe_out(LoRe_from_exmereg),
	.HiRe_out(HiRe_from_exmereg)
);

//********************************************************MEM*********************************************************//

//input 

//output
wire [31:0] Dout_from_mem;


MEM mem(
	.Clk(Clk),
	.MemWr(MemWr_from_exmereg),
	.MemRead(MemRead_from_exmereg),
	.B(B_from_exmereg),
	.LB(LB_from_exmereg),
	.Result(Result_from_exmereg),
	.BusB(BusB_from_exmereg),
	
	.Dout(Dout_from_mem)
);


//**************************************************************MEMWBReg*******************************************//
//input

//output
wire MemtoReg_from_memwbreg;
wire RegWr_from_memwbreg;
wire Jal_from_memwbreg;
wire Of_from_memwbreg;
wire [4:0] Rw_from_memwbreg;
wire [31:0] Dout_from_memwbreg;
wire [31:0] Result_from_memwbreg;
wire [31:0] PC_from_memwbreg;
	
MEMWBReg memwbreg(
	.Clk(Clk),
	.MemtoReg_in(MemtoReg_from_exmereg),
	.RegWr_in(RegWr_from_exmereg),
	.Of_in(Of_from_exmereg),
	.Dout_in(Dout_from_mem),
	.Result_in(Result_from_exmereg),
	.Rw_in(Rw_from_exmereg),
	.Jal_in(Jal_from_exmereg||Jalr_from_exmereg),
	.PC_in(PC_from_exmereg),
	.MTLO_in(MTLO_from_exmereg),
	.MTHI_in(MTHI_from_exmereg),
	.LoRe_in(LoRe_from_exmereg),
	.HiRe_in(HiRe_from_exmereg),
	
	.PC_out(PC_from_memwbreg),
	.MemtoReg_out(MemtoReg_from_memwbreg),
	.RegWr_out(RegWr_from_memwbreg),
	.Of_out(Of_from_memwbreg),
	.Dout_out(Dout_from_memwbreg),
	.Rw_out(Rw_from_memwbreg),											//这里的Rw正是id模块需要的回写信号
	.Result_out(Result_from_memwbreg),
	.Jal_out(Jal_from_memwbreg),
	.MTLO_out(MTLO_from_memwbreg),
	.MTHI_out(MTHI_from_memwbreg),
	.LoRe_out(LoRe_from_memwbreg),
	.HiRe_out(HiRe_from_memwbreg)
);

//******************************************************WriteBack****************************************************//

WriteBack wb(
	.Dout(Dout_from_memwbreg),									//存储器中读取的数据
	.Result(Result_from_memwbreg),								//ALU运算结果
	.MemtoReg(MemtoReg_from_memwbreg),							//选通信号，
	.RegWr(RegWr_from_memwbreg),
	.Jal(Jal_from_memwbreg),
	.Rw(Rw_from_memwbreg),
	.Of(Of_from_memwbreg),
	.PC(PC_from_memwbreg),										//jalr指令需要选通PC+4作为寄存器写入值
	
	.BusW(BusW_from_wb),										//最终输入寄存器的数据
	.Rw_out(Rw_from_wb),
	.WE(WE_from_wb)												//生成的写使能信号
);



//*****************************************************forward*****************************************************//

//input

//output


Forward forward(
	.Rs_from_idexreg(Rs_from_idexreg),											
	.Rt_from_idexreg(Rt_from_idexreg),
	.Rw_from_exmemreg(Rw_from_exmereg),								
	.Rw_from_memwbreg(Rw_from_memwbreg),
    .MFHI_from_idexreg(MFHI_from_idexreg),
	.MFLO_from_idexreg(MFLO_from_idexreg),
	
	.MTLO_from_exmemreg(MTLO_from_exmereg),
	.MTHI_from_exmemreg(MTHI_from_exmereg),
	.MTLO_from_memwbreg(MTLO_from_memwbreg),
	.MTHI_from_memwbreg(MTHI_from_memwbreg),
	.RegWr_from_exmemreg(RegWr_from_exmereg),									
	.RegWr_from_memwbreg(RegWr_from_memwbreg),
	.ALUSrcA(ALUSrcA_from_forward),										
	.ALUSrcB(ALUSrcB_from_forward),
	.ALUSrcH(ALUSrcH_from_forward),
	.ALUSrcL(ALUSrcL_from_forward)
);

//*********************************************************LoadUse*************************************************//

//input

//output


Loaduse lu(
	.MemRead_from_idexreg(MemRead_from_idexreg),
	.Rs_from_id(Rs_from_id),
	.Rt_from_id(Rt_from_id),
	.Rt_from_idexreg(Rt_from_idexreg),						//lw类指令存入rt中
	
	.Bubble(Bubble_from_loaduse)
);


//******************************************************Controladventure********************************************//

Controladventure ca(
	.Bgez_from_exmereg(Bgez_from_exmereg),
	.Bgtz_from_exmereg(Bgtz_from_exmereg),
	.Blez_from_exmereg(Blez_from_exmereg),
	.Bltz_from_exmereg(Bltz_from_exmereg),
	.ZBgez_from_exmereg(ZBgez_from_exmereg),
	.ZBgtz_from_exmereg(ZBgtz_from_exmereg),
	.Jalr_from_exmereg(Jalr_from_exmereg),
	.Jal_from_exmereg(Jal_from_exmereg),
	.Zero_from_exmereg(Zero_from_exmereg),
	.Jump_from_exmereg(Jump_from_exmereg),
	.Branch_beq_from_exmereg(Branch_beq_from_exmereg),
	.Branch_bne_from_exmereg(Branch_bne_from_exmereg),
	
	.Bubble(Bubble_from_ca)									//产生的阻塞信号只要将regwr和memewr都改成0即可
);
endmodule


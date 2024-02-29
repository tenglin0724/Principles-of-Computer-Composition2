//回写阶段
module WriteBack(
	input MemtoReg,								//选通信号，
	input Of,
	input Jal,
	input RegWr,
	input [31:0] Dout,							//存储器中读取的数据
	input [31:0] Result,						//ALU运算结果
	input [4:0] Rw,
	input [31:0] PC,
	
	output WE,
	output reg [31:0] BusW,						//最终输入寄存器的数据
	output [4:0] Rw_out
);

assign WE= (~Of)&RegWr; 
assign Rw_out= (Jal==1) ? 5'd31:Rw;

always@(*) begin
	if(Jal)
		BusW<=PC+4;
	else if(MemtoReg)
		BusW<=Dout;
	else
		BusW<=Result;
end

endmodule

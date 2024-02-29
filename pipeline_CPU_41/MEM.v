//mem阶段，访问存储器,计算
module MEM(
	input Clk,
	input MemWr,
	input MemRead,
	input B,
	input LB,
	input [31:0] Result,
	input [31:0] BusB,
	
	output [31:0] Dout
);

//例化存储器
DM dm(Clk,MemWr,MemRead,Result,BusB,B,LB,Dout);

endmodule

	
	
	
`timescale 1ns/1ns
module test;

reg Clk;										//时钟信号
reg Reset;										//复位信号


pipeline_MIPS pm(Clk,Reset);

always begin
	#5 Clk<=~Clk;
end


initial begin
	Clk<=1;Reset<=0;
	#3;
	Reset<=1;
	#2000;
	$stop;
end

endmodule

	
	
//Hi寄存器
module HiReg(Clk,WE,Hin,Hout);

input Clk;
input WE;
input [31:0] Hin;
output [31:0] Hout;

reg [31:0] Hi;

//初始化
initial begin
	Hi<=32'd0;
end

//取数
assign Hout=Hi;

//存数
always@(posedge Clk) begin
	if(WE) begin
		Hi<=Hin;
	end
end

endmodule
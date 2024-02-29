//Lo寄存器
module LoReg(Clk,WE,Loin,Lout);

input Clk;
input WE;
input [31:0] Loin;
output [31:0] Lout;

reg [31:0] Lo;

//初始化
initial begin
	Lo<=32'd0;
end

//取数
assign Lout=Lo;

//存数
always@(posedge Clk) begin
	if(WE) begin
		Lo<=Loin;
	end
end

endmodule
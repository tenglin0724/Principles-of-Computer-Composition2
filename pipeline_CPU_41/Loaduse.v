//loaduse模块：解决loaduse数据冲突
module Loaduse(
	input MemRead_from_idexreg,
	input [4:0] Rs_from_id,
	input [4:0] Rt_from_id,
	input [4:0] Rt_from_idexreg,						//lw类指令存入rt中
	
	output reg Bubble
);

initial begin
	Bubble<=0;
end


always@(*) begin

	if(MemRead_from_idexreg&&(Rs_from_id==Rt_from_idexreg||Rt_from_id==Rt_from_idexreg))
		Bubble<=1;
	else
		Bubble<=0;
		
end

endmodule
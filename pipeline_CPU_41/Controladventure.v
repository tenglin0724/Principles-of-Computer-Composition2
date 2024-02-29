//由转移指令引起的控制冒险
module Controladventure(
	input Bgez_from_exmereg,
	input Bgtz_from_exmereg,
	input Blez_from_exmereg,
	input Bltz_from_exmereg,
	input ZBgez_from_exmereg,
	input ZBgtz_from_exmereg,
	input Jalr_from_exmereg,
	input Jal_from_exmereg,
	input Zero_from_exmereg,
	input Jump_from_exmereg,
	input Branch_beq_from_exmereg,
	input Branch_bne_from_exmereg,
	
	output reg Bubble									//产生的阻塞信号只要将regwr和memewr都改成0即可
);

//初始化
initial begin
	Bubble<=0;
end


always@(*)begin
		Bubble<=(Jump_from_exmereg||Jal_from_exmereg||Jalr_from_exmereg||(Branch_beq_from_exmereg&&Zero_from_exmereg)
				||(Branch_bne_from_exmereg&&!Zero_from_exmereg)||(Bgez_from_exmereg&&ZBgez_from_exmereg)||
				(Bltz_from_exmereg&&!ZBgez_from_exmereg)||(Bgtz_from_exmereg&&ZBgtz_from_exmereg)||
				(Blez_from_exmereg&&!ZBgtz_from_exmereg));
end

endmodule
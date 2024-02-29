//控制信号生成器
module Control_signal(
	input [5:0] Op,										
	input [5:0] Funct,
	input [4:0] Rt,
	
	output reg Jump,											//J型指令
	output reg Branch_beq,										
	output reg Branch_bne,
	output reg Bgez,
	output reg Bgtz,
	output reg Blez,
	output reg Bltz,
	output reg Jarl,
	output reg Jal,
	output reg RegDst,
	output reg ALUSrc,
	output reg MemtoReg,			
	output reg RegWrite,
	output reg MemWrite,
	output reg ExtOp,
	output reg MemRead,											//内存读取控制信号
	output reg B,												//是否对一个字节进行操作
	output reg LB,												//对一个字节操作时，是否符号扩展
	output reg MFLO,
	output reg MFHI,
	output reg MTLO,
	output reg MTHI,
	output reg [4:0] ALUCtr
);

always@(*) begin
	case(Op) 
		6'b000000: begin																	//R型指令
					B<=0;LB<=0;Jump<=0;Branch_beq<=0;Branch_bne<=0;Bgez<=0;Bgtz<=0;
					Blez<=0;Bltz<=0;MemRead<=0;Jal<=0;ExtOp<=0;MemWrite<=0;MemtoReg<=0;
					ALUSrc<=0;RegDst<=1;
					case(Funct)
						6'b100000: begin									//add指令
									Jarl<=0;ALUCtr<=5'b00001;RegWrite<=1;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
								   end
						6'b100001: begin									//addu指令
									Jarl<=0;ALUCtr<=5'b00000;RegWrite<=1;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
								   end
						6'b100010: begin									//sub指令
									Jarl<=0;ALUCtr<=5'b00100;RegWrite<=1;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
								   end
						6'b100011: begin									//subu指令
									Jarl<=0;ALUCtr<=5'b00011;RegWrite<=1;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
								   end
						6'b101010: begin									//slt指令(比较两个寄存器值的大小)
									Jarl<=0;ALUCtr<=5'b00101;RegWrite<=1;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
								   end
						6'b100100: begin									//and指令
									Jarl<=0;ALUCtr<=5'b00110;RegWrite<=1;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
								   end
						6'b100111: begin									//nor指令(按位或非)
									Jarl<=0;ALUCtr<=5'b00111;RegWrite<=1;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
								   end
						6'b100101: begin									//or指令(按位或)
									Jarl<=0;ALUCtr<=5'b01000;RegWrite<=1;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
								   end
						6'b100110: begin									//xor指令(按位异或)
									Jarl<=0;ALUCtr<=5'b01001;RegWrite<=1;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
								   end
						6'b000000: begin									//SLL指令(逻辑左移)
									Jarl<=0;ALUCtr<=5'b01010;RegWrite<=1;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
								   end
						6'b000010: begin									//SLL指令(逻辑右移)
									Jarl<=0;ALUCtr<=5'b01011;RegWrite<=1;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
								   end
						6'b101011: begin									//SLtu指令(无符号数比较置位)
									Jarl<=0;ALUCtr<=5'b01100;RegWrite<=1;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
								   end
						6'b001001: begin									//jalr指令
									Jarl<=1;ALUCtr<=5'b01101;RegWrite<=1;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
								   end
						6'b001000: begin									//jr指令
									Jarl<=1;ALUCtr<=5'b00000;RegWrite<=0;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
								   end
						6'b000100: begin									//SLLV指令(变量逻辑左移)
									Jarl<=0;ALUCtr<=5'b01111;RegWrite<=1;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
								   end
						6'b000011: begin									//Sra指令(算数右移)
									Jarl<=0;ALUCtr<=5'b10000;RegWrite<=1;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
								   end
						6'b000111: begin									//Srav指令(变量算数右移)
									Jarl<=0;ALUCtr<=5'b10001;RegWrite<=1;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
								   end
						6'b000110: begin									//Srlv指令(变量逻辑右移)
									Jarl<=0;ALUCtr<=5'b10010;RegWrite<=1;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
								   end
						6'b011000: begin									//MUTI
									Jarl<=0;ALUCtr<=5'b10110;RegWrite<=0;MFHI<=0;MFLO<=0;MTHI<=1;MTLO<=1;
								   end
						6'b010010: begin									//MFLO
									Jarl<=0;ALUCtr<=5'b11001;RegWrite<=1;MFHI<=0;MFLO<=1;MTHI<=0;MTLO<=0;
								   end
						6'b010000: begin									//MFHI
									Jarl<=0;ALUCtr<=5'b11010;RegWrite<=1;MFHI<=1;MFLO<=0;MTHI<=0;MTLO<=0;
								   end
						6'b010011: begin									//MTLO
									Jarl<=0;ALUCtr<=5'b10111;RegWrite<=0;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=1;
								   end
						6'b010001: begin									//MTHI
									Jarl<=0;ALUCtr<=5'b11000;RegWrite<=0;MFHI<=0;MFLO<=0;MTHI<=1;MTLO<=0;
								   end
						default:   begin
									Jarl<=0;ALUCtr<=5'b00000;RegWrite<=0;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
								   end
					endcase
				   end
		6'b001101: begin			//ori指令
					Jarl<=0;Jump<=0;RegDst<=0;ALUSrc<=1;MemtoReg<=0;RegWrite<=1;MemWrite<=0;ExtOp<=0;
					ALUCtr<=5'b00010;B<=0;LB<=0;Branch_beq<=0;Branch_bne<=0;Bgez<=0;Bgtz<=0;Blez<=0;
					Bltz<=0;MemRead<=0;Jal<=0;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
				   end
		6'b001000: begin			//addi指令
					Jarl<=0;Jump<=0;RegDst<=0;ALUSrc<=1;MemtoReg<=0;RegWrite<=1;MemWrite<=0;ExtOp<=1;
					ALUCtr<=5'b00001;B<=0;LB<=0;Branch_beq<=0;Branch_bne<=0;Bgez<=0;Bgtz<=0;Blez<=0;
					Bltz<=0;MemRead<=0;Jal<=0;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
				   end
		6'b100011: begin			//lw指令
					Jarl<=0;Jump<=0;RegDst<=0;ALUSrc<=1;MemtoReg<=1;RegWrite<=1;MemWrite<=0;ExtOp<=1;
					ALUCtr<=5'b00000;B<=0;LB<=0;Branch_beq<=0;Branch_bne<=0;Bgez<=0;Bgtz<=0;Blez<=0;
					Bltz<=0;MemRead<=1;Jal<=0;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
				   end
		6'b101011: begin			//sw指令
					Jarl<=0;Jump<=0;RegDst<=0;ALUSrc<=1;MemtoReg<=0;RegWrite<=0;MemWrite<=1;ExtOp<=1;
					ALUCtr<=5'b00000;B<=0;LB<=0;Branch_beq<=0;Branch_bne<=0;Bgez<=0;Bgtz<=0;Blez<=0;
					Bltz<=0;MemRead<=0;Jal<=0;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
				   end
		6'b000100: begin			//beq指令
					Jarl<=0;Jump<=0;RegDst<=0;ALUSrc<=0;MemtoReg<=0;RegWrite<=0;MemWrite<=0;ExtOp<=1;
					ALUCtr<=5'b00011;B<=0;LB<=0;Branch_beq<=1;Branch_bne<=0;Bgez<=0;Bgtz<=0;Blez<=0;
					Bltz<=0;MemRead<=0;Jal<=0;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
				   end
		6'b001001: begin			//addiu指令
					Jarl<=0;Jump<=0;RegDst<=0;ALUSrc<=1;MemtoReg<=0;RegWrite<=1;MemWrite<=0;ExtOp<=1;
					ALUCtr<=5'b00000;B<=0;LB<=0;Branch_beq<=0;Branch_bne<=0;Bgez<=0;Bgtz<=0;Blez<=0;
					Bltz<=0;MemRead<=0;Jal<=0;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
				   end
		6'b000101: begin			//bne指令
					Jarl<=0;Jump<=0;RegDst<=0;ALUSrc<=0;MemtoReg<=0;RegWrite<=0;MemWrite<=0;ExtOp<=1;
					ALUCtr<=5'b00011;B<=0;LB<=0;Branch_beq<=0;Branch_bne<=1;Bgez<=0;Bgtz<=0;Blez<=0;
					Bltz<=0;MemRead<=0;Jal<=0;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
				   end
		6'b001111: begin			//lui指令
					Jarl<=0;Jump<=0;RegDst<=0;ALUSrc<=1;MemtoReg<=0;RegWrite<=1;MemWrite<=0;ExtOp<=0;
					ALUCtr<=5'b10011; B<=0;LB<=0;Branch_beq<=0;Branch_bne<=0;Bgez<=0;Bgtz<=0;Blez<=0;
					Bltz<=0;MemRead<=0;Jal<=0;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
				   end
		6'b001010: begin			//slti指令
					Jarl<=0;Jump<=0;RegDst<=0;ALUSrc<=1;MemtoReg<=0;RegWrite<=1;MemWrite<=0;ExtOp<=1;
					ALUCtr<=5'b10100;B<=0;LB<=0;Branch_beq<=0;Branch_bne<=0;Bgez<=0;Bgtz<=0;Blez<=0;
					Bltz<=0;MemRead<=0;Jal<=0;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
				   end
		6'b001011: begin			//sltiu指令
					Jarl<=0;Jump<=0;RegDst<=0;ALUSrc<=1;MemtoReg<=0;RegWrite<=1;MemWrite<=0;ExtOp<=1;
					ALUCtr<=5'b10101; B<=0;LB<=0;Branch_beq<=0;Branch_bne<=0;Bgez<=0;Bgtz<=0;Blez<=0;
					Bltz<=0;MemRead<=0;Jal<=0;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
				   end
		6'b000001:  begin			//bgez指令或者bltz指令
					Jarl<=0;Jump<=0;RegDst<=0;ALUSrc<=0;MemtoReg<=0;RegWrite<=0;MemWrite<=0;ExtOp<=1;
					ALUCtr<=5'b00000;B<=0;LB<=0;Branch_beq<=0;Branch_bne<=0;Bgtz<=0;Blez<=0;MemRead<=0;Jal<=0;
					MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
						if(Rt==5'b00001)begin
							Bgez<=1;
							Bltz<=0;
						end
						else			begin
							Bgez<=0;
							Bltz<=1;
						end
				   end
		6'b000111:  begin			//bgtz指令
					Jarl<=0;Jump<=0;RegDst<=0;ALUSrc<=0;MemtoReg<=0;RegWrite<=0;MemWrite<=0;ExtOp<=1;
					ALUCtr<=5'b00000; B<=0;LB<=0;Branch_beq<=0;Branch_bne<=0;Bgez<=0;Bgtz<=1;Blez<=0;
					Bltz<=0;MemRead<=0;Jal<=0;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
				   end
		6'b000110:  begin			//blez指令
					Jarl<=0;Jump<=0;RegDst<=0;ALUSrc<=0;MemtoReg<=0;RegWrite<=0;MemWrite<=0;ExtOp<=1;
					ALUCtr<=5'b00000; B<=0;LB<=0;Branch_beq<=0;Branch_bne<=0;Bgez<=0;Bgtz<=0;Blez<=1;
					Bltz<=0;MemRead<=0;Jal<=0;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
				   end
		6'b001100:  begin			//andi指令
					Jarl<=0;Jump<=0;RegDst<=0;ALUSrc<=1;MemtoReg<=0;RegWrite<=1;MemWrite<=0;ExtOp<=0;
					ALUCtr<=5'b00110;B<=0;LB<=0;Branch_beq<=0;Branch_bne<=0;Bgez<=0;Bgtz<=0;Blez<=0;
					Bltz<=0;MemRead<=0;Jal<=0;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
				   end
		6'b001101:  begin			//ori指令
					Jarl<=0;Jump<=0;RegDst<=0;ALUSrc<=1;MemtoReg<=0;RegWrite<=1;MemWrite<=0;ExtOp<=0;
					ALUCtr<=5'b01000; B<=0;LB<=0;Branch_beq<=0;Branch_bne<=0;Bgez<=0;Bgtz<=0;Blez<=0;
					Bltz<=0;MemRead<=0;Jal<=0;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
				   end
		6'b001110:  begin			//xori指令
					Jarl<=0;Jump<=0;RegDst<=0;ALUSrc<=1;MemtoReg<=0;RegWrite<=1;MemWrite<=0;ExtOp<=0;
					ALUCtr<=5'b01001; B<=0;LB<=0;Branch_beq<=0;Branch_bne<=0;Bgez<=0;Bgtz<=0;Blez<=0;
					Bltz<=0;MemRead<=0;Jal<=0;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
				   end
		6'b000010:  begin			//j指令
					Jarl<=0;Jump<=1;RegDst<=0;ALUSrc<=0;MemtoReg<=0;RegWrite<=0;MemWrite<=0;ExtOp<=0;
					ALUCtr<=5'b00000; B<=0;LB<=0;Branch_beq<=0;Branch_bne<=0;Bgez<=0;Bgtz<=0;Blez<=0;
					Bltz<=0;MemRead<=0;Jal<=0;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
				   end	
		6'b000011:  begin			//jal指令
					Jarl<=0;Jump<=0;RegDst<=0;ALUSrc<=0;MemtoReg<=0;RegWrite<=1;MemWrite<=0;ExtOp<=0;
					ALUCtr<=5'b01101;B<=0;LB<=0;Branch_beq<=0;Branch_bne<=0;Bgez<=0;Bgtz<=0;Blez<=0;
					Bltz<=0;MemRead<=0;Jal<=1;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
				   end
		6'b100000:  begin			//lb指令(待完善)
					Jarl<=0;Jump<=0;RegDst<=0;ALUSrc<=1;MemtoReg<=1;RegWrite<=1;MemWrite<=0;ExtOp<=1;
					ALUCtr<=5'b00001;B<=1;LB<=1;Branch_beq<=0;Branch_bne<=0;Bgez<=0;Bgtz<=0;Blez<=0;
					Bltz<=0;MemRead<=1;Jal<=0;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
				   end
		6'b100100:  begin			//lbu指令(待完善)
					Jarl<=0;Jump<=0;RegDst<=0;ALUSrc<=1;MemtoReg<=1;RegWrite<=1;MemWrite<=0;ExtOp<=1;
					ALUCtr<=5'b00000;B<=1;LB<=0;Branch_beq<=0;Branch_bne<=0;Bgez<=0;Bgtz<=0;Blez<=0;
					Bltz<=0;MemRead<=1;Jal<=0;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
				   end
		6'b101000: begin			//sb指令(待完善)
					Jarl<=0;Jump<=0;RegDst<=0;ALUSrc<=1;MemtoReg<=0;RegWrite<=0;MemWrite<=1;ExtOp<=1;
					ALUCtr<=5'b00001;B<=1;LB<=0;Branch_beq<=0;Branch_bne<=0;Bgez<=0;Bgtz<=0;Blez<=0;
					Bltz<=0;MemRead<=0;Jal<=0;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
				   end
		default:   begin
					Jarl<=0;Jump<=0;RegDst<=0;ALUSrc<=0;MemtoReg<=0;RegWrite<=0;MemWrite<=0;ExtOp<=0;
					ALUCtr<=5'b00000;B<=0;LB<=0;Branch_beq<=0;Branch_bne<=0;Bgez<=0;Bgtz<=0;Blez<=0;
					Bltz<=0;MemRead<=0;Jal<=0;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
				   end
	endcase
end

endmodule
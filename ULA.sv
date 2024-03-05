module ULA (input [5:0] A,
				input [5:0] B,
				input [2:0] operacao,
				input rst,
				clk,
				modo,
				output [5:0] ula_out,
				output carry_out,
				zero);

	logic [6:0] aux;
	
	always_ff @ (posedge clk)
	begin
		if (rst)
		begin
			ula_out = 6'b0;
			carry_out = 1'b0;
			zero = 1'b0;
		end
		if (modo == 1) /* operações lógicas */
		begin
			case(operacao)
				3'b000: begin
						ula_out = A & B;
						zero = (ula_out == 6'b0);
					end
				3'b001: begin
						ula_out = ~A;
						zero = (ula_out == 6'b0);
					end
				3'b010: begin
						ula_out = ~B;
						zero = (ula_out == 6'b0);
					end
				3'b011: begin 
						ula_out = A | B;
						zero = (ula_out == 6'b0);
					end
				3'b100: begin 
						ula_out = A ^ B;
						zero = (ula_out == 6'b0);
					end
				3'b101: begin
						ula_out = A &~ B;
						zero = (ula_out == 6'b0);
					end
				3'b110: begin 
						ula_out = A;
						zero = (ula_out == 6'b0);
					end
				3'b111: begin
						ula_out = B;
						zero = (ula_out == 6'b0);
					end
				default: begin
						ula_out = 6'd0;
						zero = 1'b0;
						carry_out = 1'b0;
					end
			endcase
		end
		else /* operações aritméticas */
		begin
			case(operacao)
				3'b000: begin
						aux = A + B;
						ula_out = aux[5:0];
						carry_out = aux[6];
						zero = (ula_out == 6'b0);
					//ula_out = A + B;
					end
				3'b001: begin
						aux = A - B;
						ula_out = aux[5:0];
						carry_out = aux[6];
						zero = (ula_out == 6'b0);
					end
				3'b010: begin
						aux = A + (~B);
						ula_out = aux[5:0];
						carry_out = aux[6];
						zero = (ula_out == 6'b0);
					end
				3'b011: begin 
						aux = A - (~B);
						ula_out = aux[5:0];
						carry_out = aux[6];
						zero = (ula_out == 6'b0);
					end
				3'b100: begin
						aux = A + 1;
						ula_out = aux[5:0];
						carry_out = aux[6];
						zero = (ula_out == 6'b0);
					end
				3'b101: begin
						aux = A - 1;
						ula_out = aux[5:0];
						carry_out = aux[6];
						zero = (ula_out == 6'b0);
					end
				3'b110:  begin
						aux = B + 1;
						ula_out = aux[5:0];
						carry_out = aux[6];
						zero = (ula_out == 6'b0);
					end
				3'b111: begin 
						aux = B - 1;
						ula_out = aux[5:0];
						carry_out = aux[6];
						zero = (ula_out == 6'b0);
					end
				default: begin
						ula_out = 6'd0;
						zero = 1'b0;
						carry_out = 1'b0;
					end
			endcase
		end
	end
endmodule 
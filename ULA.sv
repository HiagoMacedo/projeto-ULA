/*module ULA (input [5:0] A,
				input [5:0] B,
				input [2:0] operacao,
				input reset,
				clk,
				modo,
				output logic [6:0] o_resultado,
				output logic o_overflow,
				o_zero);
*/
module ULA (input CLOCK_50, 
				input [17:0] SW,
				output logic [17:0] LEDR);
	logic [5:0] A;
	logic [5:0] B;
	logic [2:0] operacao;
	logic reset;
	logic modo;
	logic [6:0] o_resultado;
	logic o_overflow;
	logic o_zero;

	always_ff @ (posedge CLOCK_50)
	begin
		
		A <= SW[5:0];
		B <= SW[11:6];
		operacao <= SW[14:12];
		modo <= SW[16];
		reset <= SW[17];
		LEDR[5:0] <= o_resultado[5:0];
		LEDR[7] <= o_zero;
		LEDR[9] <= o_overflow;
		
		if (reset)
		begin
			o_resultado <= 6'b0;
			o_overflow <= 1'b0;
			o_zero <= 1'b0;
		end
		else 
		begin
			if (modo == 1) /* operacoes logicas */
			begin
				o_overflow <= 1'b0;
				case(operacao)
					3'b000: o_resultado <= A & B;
					3'b001: o_resultado <= ~A;
					3'b010: o_resultado <= ~B;
					3'b011: o_resultado <= A | B;
					3'b100: o_resultado <= A ^ B;
					3'b101: o_resultado <= ~(A & B);
					3'b110: o_resultado <= A;
					3'b111: o_resultado <= B;
				endcase
			end
			else /* operacoes aritmeticas */
			begin
				case(operacao)
					3'b000: begin
						o_resultado <= A + B;
						o_overflow <= o_resultado[6];
					end
					3'b001: begin
						o_resultado <= A - B;
						o_overflow <= o_resultado[6];
					end
					3'b010: begin
						o_resultado <= A + (~B);
						o_overflow <= ~o_resultado[6];
					end
					3'b011: begin
						o_resultado <= A - (~B);
						o_overflow <= ~o_resultado[6];
					end
					3'b100: begin
						o_resultado <= A + 1'b1;
						o_overflow <= o_resultado[6];
					end
					3'b101: begin
						o_resultado <= A - 1'b1;
						o_overflow <= o_resultado[6];
					end
					3'b110: begin
						o_resultado <= B + 1'b1;
						o_overflow <= o_resultado[6];
					end
					3'b111: begin
						o_resultado <= B - 1'b1;
						o_overflow <= o_resultado[6];
					end
				endcase
				// o_overflow <= o_resultado[6];
			end
			o_zero <= (o_resultado[5:0] == 6'b0);
		end
	end
endmodule 
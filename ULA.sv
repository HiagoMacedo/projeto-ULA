/*module ULA (input [5:0] A,
				input [5:0] B,
				input [2:0] operacao,
				input reset,
				clk,
				modo,
				output logic [5:0] o_resultado,
				output logic o_overflow,
				o_zero);
*/
module ULA (input CLOCK_50, 
				input [17:0] SW,
				output logic [17:0] LEDR);
	logic [6:0] aux;
	logic [5:0] A;
	logic [5:0] B;
	logic [2:0] operacao;
	logic reset;
	logic modo;
	logic [5:0] o_resultado;
	logic o_overflow;
	logic o_zero;
	
	 // always_comb begin
	always_ff @ (posedge CLOCK_50)
	begin
		aux <= 7'b0;
		A <= SW[5:0];
		B <= SW[11:6];
		modo <= SW[12];
		operacao <= SW[15:13];
		reset <= SW[17];
		LEDR[5:0] <= o_resultado[5:0];
		LEDR[7] <= o_zero;
		LEDR[9] <= o_overflow;
		
		if (reset)
		begin
			aux <= 7'b0;
			o_resultado <= 6'b0;
			o_overflow <= 1'b0;
			o_zero <= 1'b0;
		end
		else 
		begin
			if (modo == 1) /* operações lógicas */
			begin
				o_overflow <= 1'b0;
				case(operacao)
					3'b000: begin
						o_resultado <= A & B;
						o_zero <= (o_resultado == 6'b0);
					end
					3'b001: begin
						o_resultado <= ~A;
						o_zero <= (o_resultado == 6'b0);
					end
					3'b010: begin
						o_resultado <= ~B;
						o_zero <= (o_resultado == 6'b0);
					end
					3'b011: begin 
						o_resultado <= A | B;
						o_zero <= (o_resultado == 6'b0);
					end
					3'b100: begin 
						o_resultado <= A ^ B;
						o_zero <= (o_resultado == 6'b0);
					end
					3'b101: begin
						o_resultado <= ~(A & B);
						o_zero <= (o_resultado == 6'b0);
					end
					3'b110: begin 
						o_resultado <= A;
						o_zero <= (o_resultado == 6'b0);
					end
					3'b111: begin
						o_resultado <= B;
						o_zero <= (o_resultado == 6'b0);
					end
				endcase
			end
			else /* operações aritméticas */
			begin
				case(operacao)
					3'b000: begin
						aux <= A + B;
						o_resultado <= aux[5:0];
						o_overflow <= aux[6];
						o_zero <= (o_resultado == 6'b0);
					end
					3'b001: begin
						aux <= A - B;
						o_resultado <= aux[5:0];
						o_overflow <= aux[6];
						o_zero <= (o_resultado == 6'b0);
					end
					3'b010: begin
						aux <= A + (~B);
						o_resultado <= aux[5:0];
						o_overflow <= aux[6];
						o_zero <= (o_resultado == 6'b0);
					end
					3'b011: begin 
						aux <= A - (~B);
						o_resultado <= aux[5:0];
						o_overflow <= aux[6];
						o_zero <= (o_resultado == 6'b0);
					end
					3'b100: begin
						aux <= A + 1'b1;
						o_resultado <= aux[5:0];
						o_overflow <= aux[6];
						o_zero <= (o_resultado == 6'b0);
					end
					3'b101: begin
						aux <= A - 1'b1;
						o_resultado <= aux[5:0];
						o_overflow <= aux[6];
						o_zero <= (o_resultado == 6'b0);
					end
					3'b110:  begin
						aux <= B + 1'b1;
						o_resultado <= aux[5:0];
						o_overflow <= aux[6];
						o_zero <= (o_resultado == 6'b0);
					end
					3'b111: begin 
						aux <= B - 1'b1;
						o_resultado <= aux[5:0];
						o_overflow <= aux[6];
						o_zero <= (o_resultado == 6'b0);
					end
				endcase
			end
		end
	end
endmodule 
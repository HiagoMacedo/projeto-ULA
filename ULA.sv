/*module ULA (input [5:0] A,
				input [5:0] B,
				input [2:0] operacao,
				input reset,
				clk,
				modo,
				output logic [5:0] resultado,
				output logic carry_out,
				zero);
*/
module ULA (input CLOCK_50, 
				input [17:0] SW,
				output logic [17:0] LEDR);
	logic [5:0] A;
	logic [5:0] B;
	logic [2:0] operacao;
	logic reset;
	logic modo;
	logic [5:0] resultado;
	logic carry_out;
	logic zero;
	logic [6:0] aux;
	
	// always_comb begin
	always_ff @ (CLOCK_50)
	begin
	
		aux = 7'b0;
		A = SW[5:0];
		B = SW[11:6];
		modo = SW[12];
		operacao = SW[15:13];
		reset = SW[17];
		LEDR[5:0] = resultado[5:0];
		LEDR[15] = zero;
		LEDR[17] = carry_out;
		
		if (reset)
		begin
			resultado = 6'b0;
			carry_out = 1'b0;
			zero = 1'b0;
		end
		if (modo == 1) /* operações lógicas */
		begin
			carry_out = 1'b0;
			case(operacao)
				3'b000: begin
					resultado = A & B;
					// carry_out = 1'b0;
					zero = (resultado == 6'b0);
					end
				3'b001: begin
					resultado = ~A;
					// carry_out = 1'b0;
					zero = (resultado == 6'b0);
				end
				3'b010: begin
					resultado = ~B;
					// carry_out = 1'b0;
					zero = (resultado == 6'b0);
				end
				3'b011: begin 
					resultado = A | B;
					// carry_out = 1'b0;
					zero = (resultado == 6'b0);
				end
				3'b100: begin 
					resultado = A ^ B;
					// carry_out = 1'b0;
					zero = (resultado == 6'b0);
				end
				3'b101: begin
					resultado = A &~ B;
					// carry_out = 1'b0;
					zero = (resultado == 6'b0);
				end
				3'b110: begin 
					resultado = A;
					zero = (resultado == 6'b0);
					// carry_out = 1'b0;
				end
				3'b111: begin
					resultado = B;
					zero = (resultado == 6'b0);
					// carry_out = 1'b0;
				end
			endcase
		end
		else /* operações aritméticas */
		begin
			case(operacao)
				3'b000: begin
					aux = A + B;
					resultado = aux[5:0];
					carry_out = aux[6];
					zero = (resultado == 6'b0);
				end
				3'b001: begin
					aux = A - B;
					resultado = aux[5:0];
					carry_out = aux[6];
					zero = (resultado == 6'b0);
				end
				3'b010: begin
					aux = A + (~B);
					resultado = aux[5:0];
					carry_out = aux[6];
					zero = (resultado == 6'b0);
				end
				3'b011: begin 
					aux = A - (~B);
					resultado = aux[5:0];
					carry_out = aux[6];
					zero = (resultado == 6'b0);
				end
				3'b100: begin
					aux = A + 1;
					resultado = aux[5:0];
					carry_out = aux[6];
					zero = (resultado == 6'b0);
				end
				3'b101: begin
					aux = A - 1;
					resultado = aux[5:0];
					carry_out = aux[6];
					zero = (resultado == 6'b0);
				end
				3'b110:  begin
					aux = B + 1;
					resultado = aux[5:0];
					carry_out = aux[6];
					zero = (resultado == 6'b0);
				end
				3'b111: begin 
					aux = B - 1;
					resultado = aux[5:0];
					carry_out = aux[6];
					zero = (resultado == 6'b0);
				end
			endcase
		end
	end
endmodule 
/*
module ula_casca (input CLOCK_50, input [17:0] SW, output logic [6:0] HEX0, output logic [17:0] LEDR);
logic [5:0] A;
logic [5:0] B;
logic [6:0] out_ula ;
logic o_zero;
logic i_modo;
logic reset;
logic [2:0] operacao;

always_comb begin
        A <= SW[5:0];
		  B <= SW[11:6];
		  i_modo <= SW[12];
		  operacao <= SW[15:13];
		  reset <= SW[17];
		  // out_ula <= A + B;
		  LEDR[5:0] <= out_ula[5:0];
		  LEDR[15] <= o_zero;
		  LEDR[17] <= out_ula[6];
end
endmodule 
*/
module FSM
#(
	parameter s_width = 2,
			  A = 2'b00,
			  B = 2'b01,
			  C = 2'b10
)

(
  input In1,
  input RST,
  input CLK, 
  output reg Out1
);
reg [(s_width - 1):0] currentState, nextState;

always@ (currentState or In1)
begin : combinational
	case (currentState)
		A:
			if(In1 == 1) begin
				nextState <= B;
				Out1 <= 0;
			end else begin
				nextState = A;
				Out1 <= 0;
			end
		B:
			if(In1 == 1) begin
				nextState <= B;
				Out1 <= 0;
			end else begin
				nextState <= C;
				Out1 <= 1;
			end
		C:
			if(In1 == 1) begin
				nextState <= A;
				Out1 <= 0;
			end else begin
				nextState <= C;
				Out1 <= 1;
			end
		default : 
			begin
				nextState <= A;
				Out1 <= 1'b0;
			end
	endcase
end : combinational

always @(posedge CLK or negedge RST) 
begin : synch
	if(~RST) begin
		currentState <= A;
		Out1 = 0;
	end else begin
		 currentState <= nextState;
	end
end : synch
endmodule : FSM

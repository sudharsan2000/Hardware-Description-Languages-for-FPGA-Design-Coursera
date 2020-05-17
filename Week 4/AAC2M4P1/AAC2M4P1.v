module LS161a(
    input [3:0] D,        // Parallel Input
    input CLK,            // Clock
    input CLR_n,          // Active Low Asynchronous Reset
    input LOAD_n,         // Enable Parallel Input
    input ENP,            // Count Enable Parallel
    input ENT,            // Count Enable Trickle
    output reg [3:0]Q,        // Parallel Output 	
    output reg RCO            // Ripple Carry Output (Terminal Count)
); 

always @(posedge CLK or negedge CLR_n) begin 
	if(~CLR_n) begin
		 Q <= 0;
	end 
	else if (~LOAD_n) begin
		Q <= D;
	end
	else if (ENP && ENT) begin
		Q <= Q + 1;
		if(Q == 4'b1111)
			RCO <= ENT;
	end
	else
		Q <= Q;
end

endmodule : LS161a
`timescale 1ns / 1ps

module data_MEM(
	input clk,
	input rst_n,
	input [2:0] read_addr,
	input [2:0] write_addr,
	input [31:0] write_data,
	input read_enable,
	input write_enable,
	
	output reg [31:0] read_data
    );
    
	// Internal registers
    reg [31:0] data [7:0];
	reg [31:0] data_next [7:0];

	// Loop variables
	integer i, j, k;

	// Sequential logic
    always @(posedge clk) begin
		if (~rst_n) begin
			for (i = 0; i < 8; i = i + 1) begin
				data[i] <= i + 1;
			end
		end
		else begin
			for (j = 0; j < 8; j = j + 1) begin
				data[j] <= data_next[j];
			end
		end
    end

	// Combinational logic of mem write
	always @(*) begin
		for (k = 0; k < 8; k = k + 1) begin
			data_next[k] = data[k];
		end
		if (write_enable) begin
			data_next[write_addr[2:0]] = write_data;
		end
	end
    
	// Combinational logic of mem read
	always @(*) begin
		if (read_enable) begin
			read_data = data[read_addr[2:0]];
		end
		else begin
			read_data = 32'h00000000;
		end
	end

endmodule

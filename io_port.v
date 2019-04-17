module io_port
(
	input wire 	      clk,
	input wire 	      resetb,
	/* verilator lint_off UNUSED */
	input wire [7:0]   io_addr/*verilator public*/,
	input wire 	      io_en/*verilator public*/,
	/* verilator lint_on UNUSED */
	input wire 	      io_we/*verilator public*/,
	input wire [31:0]  io_data_write/*verilator public*/,
	output reg [31:0] io_data_read,
		output wire 	      irq_mtimecmp,
		output reg [7:0] output0,
		input wire [7:0] input0,
		output reg [7:0] dir0
	);

	wire 	      mtime_we;
	wire [31:0] 	      mtime_dout;

	assign mtime_we = io_addr[7:4] == 4'b0001 ? io_we : 1'b0;

	//assign io_data_read = io_addr[7:4] == 4'b0001 ? mtime_dout : 32'bX;
	integer i;
	always @ (*) begin
		io_data_read = 32'bX;
		case (io_addr)
			8'h00: begin
				for (i=0; i<8; i=i+1) begin
					io_data_read[i] = dir0[i] ? output0[i] : input0_p[i];
				end
			end
			8'h01: begin
				io_data_read[15:8] = dir0;
			end
			8'h10: io_data_read = mtime_dout;
			default: begin
			end
		endcase
	end

	// GPIO0 is at 0x80000000, the same address as testbench commands.
	// DIR0 is at 0x80000001
	reg [7:0]   input0_p;
	always @ (posedge clk) begin : GPIO0
		if (!resetb) begin
			input0_p <= 8'b0;
			output0 <= 8'b0;
			dir0 <= 8'b0;
		end
		else if (clk) begin
			input0_p <= input0;
			if (io_we) begin
				case (io_addr[7:0])
					8'b0: output0 <= io_data_write[7:0];
					8'b1: dir0 <= io_data_write[15:8];
					default: begin
					end
				endcase
			end
		end
	end

	timer TIMER0
	(
		.clk(clk), .resetb(resetb),
		.io_addr_3_2(io_addr[3:2]), .io_we(mtime_we), .io_din(io_data_write),
		.io_dout(mtime_dout), .irq_mtimecmp(irq_mtimecmp)
	);

	endmodule

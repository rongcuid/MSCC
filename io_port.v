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
		inout wire [7:0]   io_gpio0
	);

	wire 	      mtime_we;
	wire [31:0] 	      mtime_dout;

	assign mtime_we = io_addr[7:4] == 4'b0001 ? io_we : 1'b0;

	//assign io_data_read = io_addr[7:4] == 4'b0001 ? mtime_dout : 32'bX;
	integer i;
	always @ (*) begin
		case (io_addr)
			8'h00: begin
				for (i=0; i<8; i=i+1) begin
					io_data_read[i] = dir0[i] ? gpio0[i] : input0[i];
				end
			end
			8'h10: io_data_read = mtime_dout;
			default: begin
				io_data_read = 32'bX;
			end
		endcase
	end

	assign io_gpio0[0] = dir0[0] ? gpio0[0] : 1'bz;
	assign io_gpio0[1] = dir0[1] ? gpio0[1] : 1'bz;
	assign io_gpio0[2] = dir0[2] ? gpio0[2] : 1'bz;
	assign io_gpio0[3] = dir0[3] ? gpio0[3] : 1'bz;
	assign io_gpio0[4] = dir0[4] ? gpio0[4] : 1'bz;
	assign io_gpio0[5] = dir0[5] ? gpio0[5] : 1'bz;
	assign io_gpio0[6] = dir0[6] ? gpio0[6] : 1'bz;
	assign io_gpio0[7] = dir0[7] ? gpio0[7] : 1'bz;

	// GPIO0 is at 0x80000000, the same address as testbench commands.
	// DIR0 is at 0x80000001
	reg [7:0]   dir0, gpio0, input0;
	always @ (posedge clk) begin : GPIO0
		if (!resetb) begin
			input0 <= 8'b0;
			gpio0 <= 8'b0;
			dir0 <= 8'b0;
		end
		else if (clk) begin
			input0 <= io_gpio0;
			if (io_we) begin
				case (io_addr[7:0])
					8'b0: gpio0 <= io_data_write[7:0];
					8'b1: dir0 <= io_data_write[7:0];
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

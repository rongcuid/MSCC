/*
* The top level module, meant to be synthesized
*/
module cpu_top
(
	input wire clk,
	input wire resetb,
	inout wire [7:0] gpio0
);

wire [7:0] io_addr;
wire       io_en, io_we;
wire [31:0] io_data_read;
wire [31:0] io_data_write;
wire        irq_mtimecmp;

/* verilator lint_off UNUSED */
wire [31:2] ram_iaddr;
wire [31:0] ram_irdata;
wire [31:2] ram_addr;
wire [3:0] ram_wstrb;
wire [31:0] ram_rdata;
wire [31:0] ram_wdata;
/* verilator lint_on UNUSED */

wire [7:0] input0, output0, dir0;

generate
	genvar i;
	for (i=0; i<8; i=i+1) begin
		assign gpio0[i] = dir0[i] ? output0[i] : 1'bZ;
		assign input0[i] = gpio0[i];
	end
endgenerate

bram_dpstrobe RAM0
(
	.clk(clk), 
	.addra(ram_iaddr[15:2]), .addrb(ram_addr[15:2]),
	.dina(32'bX), .dinb(ram_wdata),
	.wea(4'b0), .web(ram_wstrb),
	.douta(ram_irdata), .doutb(ram_rdata)
);

core_top CT0 
(
	.clk(clk), .resetb(resetb),
	.ram_iaddr(ram_iaddr), .ram_irdata(ram_irdata), 
	.ram_addr(ram_addr), .ram_wstrb(ram_wstrb), 
	.ram_rdata(ram_rdata), .ram_wdata(ram_wdata),
	.io_addr(io_addr), .io_en(io_en), .io_we(io_we),
	.io_data_read(io_data_read), .io_data_write(io_data_write),
	.irq_mtimecmp(irq_mtimecmp)
);

io_port IO0
(
	.clk(clk), .resetb(resetb),
	.io_addr(io_addr), .io_en(io_en), .io_we(io_we),
	.io_data_read(io_data_read), .io_data_write(io_data_write),
	.irq_mtimecmp(irq_mtimecmp),
	.output0(output0), .input0(input0), .dir0(dir0)
);


endmodule

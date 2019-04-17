/*
Top module of CPU core. Connects the core and MMU
*/
module core_top
(
  input wire 	      clk, 
  input wire 	      resetb,
  /* verilator lint_off UNDRIVEN */
  output wire [31:2] ram_iaddr,
  input wire [31:0] ram_irdata,
  output wire [31:2] ram_addr,
  output wire [3:0] ram_wstrb,
  input wire [31:0] ram_rdata,
  output wire [31:0] ram_wdata,
  /* verilator lint_on UNDRIVEN */
  output wire [7:0]  io_addr,
  output wire 	      io_en, 
  output wire 	      io_we, 
  input wire [31:0]  io_data_read, 
  output wire [31:0] io_data_write,
  input wire irq_mtimecmp
  //input wire mtime_we,
  //output wire [31:0] mtime_dout
);

wire 	      dm_we;
wire [31:0] 	      im_addr;
wire [31:0] 	      im_do;
wire [31:0] 	      dm_addr;
wire [31:0] 	      dm_di;
wire [31:0] 	      dm_do;
wire [3:0] 	      dm_be;
wire 	      dm_is_signed;

core CPU0
(
  .clk(clk), .resetb(resetb),
  .dm_we(dm_we), .im_addr(im_addr), .im_do(im_do),
  .dm_addr(dm_addr), .dm_di(dm_di), .dm_do(dm_do),
  .dm_be(dm_be), .dm_is_signed(dm_is_signed),
  .irq_mtimecmp(irq_mtimecmp)
);

mmu MMU0
(
  .clk(clk), .resetb(resetb),
  .dm_we(dm_we),
  .im_addr(im_addr), .im_do(im_do),
  .dm_addr(dm_addr), .dm_di(dm_di), .dm_do(dm_do),
  .dm_be(dm_be), .is_signed(dm_is_signed),
  .ram_iaddr(ram_iaddr[15:2]), .ram_irdata(ram_irdata), 
  .ram_addr(ram_addr[15:2]), .ram_wstrb(ram_wstrb), 
  .ram_rdata(ram_rdata), .ram_wdata(ram_wdata),
  //.im_addr_out(rom_addr), .im_data(rom_data),
  //.im_addr_out_2(rom_addr_2), .im_data_2(rom_data_2),
  .io_addr(io_addr), .io_en(io_en), .io_we(io_we),
  .io_data_read(io_data_read), .io_data_write(io_data_write)
);


endmodule

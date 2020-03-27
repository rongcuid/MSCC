/**
    This module is the Memory Management Unit (MMU).

    The MMU's task is to handle instruction and data memory requests in Virtual Memory,
    maps to appropriate physical devices, and performs memory operation.
    The MMU does not handle banks of memory directly.

    Data memory is in the MEM stage of core pipeline, and thus has average latency of 1.
    The BRAM would be registered, so data/address in and out are shadowed.
    Memory data use Ready-Valid protocol, and may stall pipeline.

    IO unit is a separate module handled by MMU.

    Currently Virtual Address = Physical Address

    Currently the MMU can raise the following exceptions:
    * 0 - Instruction address misaligned
    * 1 - Instruction access fault
    * -4- - (Never) Load address misaligned 
    * 5 - Load access fault
    * -6- - (Never) Store/AMO address misaligned
    * 7 - Store/AMO access fault
 */
module MMU #(
    parameter RAM_ADDR_BASE = 0,
    parameter RAM_ADDR_WIDTH = 16, // 64K by default
    parameter IO_ADDR_BASE = 'hF0000000,
    parameter IO_ADDR_WIDTH = 8 // 256 by default
) (
    /* Essential.*/
    input wire i_clk,
    input wire i_rst,
    /* Core Ports.*/
    /* Instruction Port.*/
    // Request
    input wire i_iaddr_v,
    output wire o_iaddr_r,
    input wire [31:0] i_iaddr,
    // Response
    input wire i_irdata_r,
    output wire o_irdata_v,
    output wire [31:0] o_irdata,
    // Exceptions
    output wire o_im_x,
    output wire o_im_x_misaligned,
    output wire o_im_x_access,
    /* Data Port.*/
    // Request
    input wire i_addr_v,
    output wire o_addr_r,
    input wire [31:0] i_addr,
    input wire [3:0] i_wstrb,
    output wire [31:0] o_dm_wdata,
    // Response
    input wire [31:0] i_rdata_v,
    output wire [31:0] o_rdata_r,
    input wire [31:0] i_rdata,
    // Exceptions
    output wire o_dm_x,
    output wire o_dm_x_load_storen,
    output wire o_dm_x_access,
    /* Peripheral Ports.*/
    /* To RAM Controller.*/
    // Instruction Request
    input wire i_ram_iaddr_r,
    output wire o_ram_iaddr_v,
    output wire [RAM_ADDR_WIDTH-1:0] o_ram_iaddr,
    // Instruction Response
    input wire i_ram_idata_v,
    output wire o_ram_idata_r,
    input wire [31:0] i_ram_irdata,
    // Data Request
    input wire i_ram_addr_r,
    output wire o_ram_addr_v,
    output wire [RAM_ADDR_WIDTH-1:0] o_ram_addr,
    output wire [3:0] o_ram_wstrb,
    output wire [31:0] o_ram_wdata,
    // Data Response
    input wire i_ram_rdata_v,
    output wire o_ram_rdata_r,
    input wire [31:0] i_ram_rdata,
    /* To IO Port.*/
    // Request
    input wire i_io_addr_r,
    output wire o_io_addr_v,
    output wire o_io_addr,
    output wire [31:0] o_io_wdata
    output wire [3:0] o_io_rstrb,
    output wire [3:0] o_io_wstrb,
    // Response
    input wire i_io_rdata_v,
    output wire o_io_rdata_r,
    input wire [31:0] i_io_rdata
);

endmodule;
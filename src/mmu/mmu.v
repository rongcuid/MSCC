/**
    This module is the Memory Management Unit (MMU).

    The MMU's task is to handle instruction and data memory requests in Virtual Memory,
    maps to appropriate physical devices, and performs memory operation.

    Data memory is in the MEM stage of core pipeline, and thus has average latency of 1.
    The BRAM would be registered, so data/address in and out are shadowed.
    Memory data use Ready-Valid protocol, and may stall pipeline.

    IO unit is a separate module handled by MMU.

    Currently Virtual Address = Physical Address

    Currently the MMU can raise the following exceptions:
    * 0 - Instruction address misaligned
    * 1 - Instruction access fault
    * 4 - Load address misaligned
    * 5 - Load access fault
    * 6 - Store/AMO address misaligned
    * 7 - Store/AMO access fault
 */
module (
    /* Essential.*/
    input wire i_clk,
    input wire i_rst,
    /* Ports.*/
    /* Instruction Port.*/
    input wire i_im_a_v,
    output wire o_im_a_r,
    input wire [31:0] i_im_a,
    //
    input wire i_im_d_r,
    output wire o_im_d_v,
    output wire [31:0] o_im_d,
    //
    output wire o_im_x,
    output wire o_im_x_misaligned,
    output wire o_im_x_access,
    /* Data Port.*/
    input wire i_dm_a_v,
    output wire o_dm_a_r,
    input wire [31:0] i_dm_a,
    //
    input wire [3:0] i_dm_ben,
    input wire i_dm_wen,
    //
    input wire i_dm_d_r,
    output wire i_dm_d_v,
    output wire [31:0] o_dm_d,
    //
    output wire o_dm_x,
    output wire o_dm_x_load_storen,
    output wire o_dm_x_misaligned,
    output wire o_dm_x_access,
    /* To IO Port.*/
    input wire i_gpio_a_r,
    output wire o_gpio_a_v,
    output wire o_gpio_a,
    //
    output wire [3:0] o_io_ben,
    output wire o_io_wen,
    //
    input wire i_io_d_r,
    output wire o_io_d_v,
    output wire [31:0] o_io_d
);

endmodule;
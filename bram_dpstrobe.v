module bram_dpstrobe(
	clk,
	addra, addrb,
	dina, dinb,
	wea, web,
	douta, doutb
);

//  Xilinx True Dual Port RAM Byte Write, Write First Single Clock RAM
//  This code implements a parameterizable true dual port memory (both ports can read and write).
//  The behavior of this RAM is when data is written, the new memory contents at the write
//  address are presented on the output port.

  parameter NB_COL = 4;                       // Specify number of columns (number of bytes)
  parameter COL_WIDTH = 8;                  // Specify column width (byte width, typically 8 or 9)
  parameter RAM_DEPTH = 16384;                  // Specify RAM depth (number of entries)
  parameter INIT_FILE = "";                       // Specify name/location of RAM initialization file if using one (leave blank if not)

  input wire [clogb2(RAM_DEPTH-1)-1:0] addra;  // Port A address bus, width determined from RAM_DEPTH
  input wire [clogb2(RAM_DEPTH-1)-1:0] addrb;  // Port B address bus, width determined from RAM_DEPTH
  input wire [(NB_COL*COL_WIDTH)-1:0] dina;  // Port A RAM input data
  input wire [(NB_COL*COL_WIDTH)-1:0] dinb;  // Port B RAM input data
  input wire clk;                           // Clock
  input wire [NB_COL-1:0] wea;               // Port A write enable
  input wire [NB_COL-1:0] web;		  // Port B write enable
  output wire [(NB_COL*COL_WIDTH)-1:0] douta; // Port A RAM output data
  output wire [(NB_COL*COL_WIDTH)-1:0] doutb; // Port B RAM output data

  reg [(NB_COL*COL_WIDTH)-1:0] ram [RAM_DEPTH-1:0] /* verilator public */;
  reg [(NB_COL*COL_WIDTH)-1:0] ram_data_a = {(NB_COL*COL_WIDTH){1'b0}};
  reg [(NB_COL*COL_WIDTH)-1:0] ram_data_b = {(NB_COL*COL_WIDTH){1'b0}};

  // The following code either initializes the memory values to a specified file or to all zeros to match hardware
  generate
    if (INIT_FILE != "") begin: use_init_file
      initial
        $readmemh(INIT_FILE, ram, 0, RAM_DEPTH-1);
    end else begin: init_bram_to_zero
      integer ram_index;
      initial
        for (ram_index = 0; ram_index < RAM_DEPTH; ram_index = ram_index + 1)
          ram[ram_index] = {(NB_COL*COL_WIDTH){1'b0}};
    end
  endgenerate

  generate
	  genvar i;
	  for (i = 0; i < NB_COL; i = i+1) begin: byte_write
		  always @(posedge clk) begin
			  if (wea[i]) begin
				  ram[addra][(i+1)*COL_WIDTH-1:i*COL_WIDTH] <= dina[(i+1)*COL_WIDTH-1:i*COL_WIDTH];
				  ram_data_a[(i+1)*COL_WIDTH-1:i*COL_WIDTH] <= dina[(i+1)*COL_WIDTH-1:i*COL_WIDTH];
			  end else begin
				  ram_data_a[(i+1)*COL_WIDTH-1:i*COL_WIDTH] <= ram[addra][(i+1)*COL_WIDTH-1:i*COL_WIDTH];
			  end
		  end

		  always @(posedge clk) begin
			  if (web[i]) begin
				  ram[addrb][(i+1)*COL_WIDTH-1:i*COL_WIDTH] <= dinb[(i+1)*COL_WIDTH-1:i*COL_WIDTH];
				  ram_data_b[(i+1)*COL_WIDTH-1:i*COL_WIDTH] <= dinb[(i+1)*COL_WIDTH-1:i*COL_WIDTH];
			  end else begin
				  ram_data_b[(i+1)*COL_WIDTH-1:i*COL_WIDTH] <= ram[addrb][(i+1)*COL_WIDTH-1:i*COL_WIDTH];
			  end
		  end
	  end
  endgenerate

  // The following is a 1 clock cycle read latency at the cost of a longer clock-to-out timing
  assign douta = ram_data_a;
  assign doutb = ram_data_b;

  //  The following function calculates the address width based on specified RAM depth
  function integer clogb2;
	  input integer depth;
	  for (clogb2=0; depth>0; clogb2=clogb2+1)
		  depth = depth >> 1;
  endfunction

  endmodule

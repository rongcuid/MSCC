`ifndef _csr_list_vh_
 `define _csr_list_vh_

// User level. Use a trap?
 // `define CSR_CYCLE 12'hC00
 // `define CSR_TIME 12'hC01
 // `define CSR_INSTRET 12'hC02
 // `define CSR_CYCLEH 12'hC80
 // `define CSR_TIMEH 12'hC81
 // `define CSR_INSTRETH 12'hC82

// Machine level
 `define CSR_MVENDORID 12'hF11
 `define CSR_MARCHID 12'hF12
 `define CSR_MIMPID 12'hF13
 `define CSR_MHARTID 12'hF14
 `define CSR_MSTATUS 12'h300
 `define CSR_MISA 12'h301
 `define CSR_MTVEC 12'h305
 `define CSR_MSCRATCH 12'h340
 `define CSR_MEPC 12'h341
 `define CSR_MCAUSE 12'h342
 `define CSR_MTVAL 12'h343
 `define CSR_MCYCLE 12'hB00
 `define CSR_MINSTRET 12'hB02
`define CSR_MHPMCOUNTER3 12'hB03
`define CSR_MHPMCOUNTER4 12'hB04
`define CSR_MHPMCOUNTER5 12'hB05
`define CSR_MHPMCOUNTER6 12'hB06
`define CSR_MHPMCOUNTER7 12'hB07
`define CSR_MHPMCOUNTER8 12'hB08
`define CSR_MHPMCOUNTER9 12'hB09
`define CSR_MHPMCOUNTER10 12'hB0A
`define CSR_MHPMCOUNTER11 12'hB0B
`define CSR_MHPMCOUNTER12 12'hB0C
`define CSR_MHPMCOUNTER13 12'hB0D
`define CSR_MHPMCOUNTER14 12'hB0E
`define CSR_MHPMCOUNTER15 12'hB0F
`define CSR_MHPMCOUNTER16 12'hB10
`define CSR_MHPMCOUNTER17 12'hB11
`define CSR_MHPMCOUNTER18 12'hB12
`define CSR_MHPMCOUNTER19 12'hB13
`define CSR_MHPMCOUNTER20 12'hB14
`define CSR_MHPMCOUNTER21 12'hB15
`define CSR_MHPMCOUNTER22 12'hB16
`define CSR_MHPMCOUNTER23 12'hB17
`define CSR_MHPMCOUNTER24 12'hB18
`define CSR_MHPMCOUNTER25 12'hB19
`define CSR_MHPMCOUNTER26 12'hB1A
`define CSR_MHPMCOUNTER27 12'hB1B
`define CSR_MHPMCOUNTER28 12'hB1C
`define CSR_MHPMCOUNTER29 12'hB1D
`define CSR_MHPMCOUNTER30 12'hB1E
`define CSR_MHPMCOUNTER31 12'hB1F
`define CSR_MCYCLEH 12'hB80
`define CSR_MINSTRETH 12'hB82
`define CSR_MHPMCOUNTERH3 12'hB83
`define CSR_MHPMCOUNTERH4 12'hB84
`define CSR_MHPMCOUNTERH5 12'hB85
`define CSR_MHPMCOUNTERH6 12'hB86
`define CSR_MHPMCOUNTERH7 12'hB87
`define CSR_MHPMCOUNTERH8 12'hB88
`define CSR_MHPMCOUNTERH9 12'hB89
`define CSR_MHPMCOUNTERH10 12'hB8A
`define CSR_MHPMCOUNTERH11 12'hB8B
`define CSR_MHPMCOUNTERH12 12'hB8C
`define CSR_MHPMCOUNTERH13 12'hB8D
`define CSR_MHPMCOUNTERH14 12'hB8E
`define CSR_MHPMCOUNTERH15 12'hB8F
`define CSR_MHPMCOUNTERH16 12'hB90
`define CSR_MHPMCOUNTERH17 12'hB91
`define CSR_MHPMCOUNTERH18 12'hB92
`define CSR_MHPMCOUNTERH19 12'hB93
`define CSR_MHPMCOUNTERH20 12'hB94
`define CSR_MHPMCOUNTERH21 12'hB95
`define CSR_MHPMCOUNTERH22 12'hB96
`define CSR_MHPMCOUNTERH23 12'hB97
`define CSR_MHPMCOUNTERH24 12'hB98
`define CSR_MHPMCOUNTERH25 12'hB99
`define CSR_MHPMCOUNTERH26 12'hB9A
`define CSR_MHPMCOUNTERH27 12'hB9B
`define CSR_MHPMCOUNTERH28 12'hB9C
`define CSR_MHPMCOUNTERH29 12'hB9D
`define CSR_MHPMCOUNTERH30 12'hB9E
`define CSR_MHPMCOUNTERH31 12'hB9F
`define CSR_MHPMEVENT3 12'h323
`define CSR_MHPMEVENT4 12'h324
`define CSR_MHPMEVENT5 12'h325
`define CSR_MHPMEVENT6 12'h326
`define CSR_MHPMEVENT7 12'h327
`define CSR_MHPMEVENT8 12'h328
`define CSR_MHPMEVENT9 12'h329
`define CSR_MHPMEVENT10 12'h32A
`define CSR_MHPMEVENT11 12'h32B
`define CSR_MHPMEVENT12 12'h32C
`define CSR_MHPMEVENT13 12'h32D
`define CSR_MHPMEVENT14 12'h32E
`define CSR_MHPMEVENT15 12'h32F
`define CSR_MHPMEVENT16 12'h330
`define CSR_MHPMEVENT17 12'h331
`define CSR_MHPMEVENT18 12'h332
`define CSR_MHPMEVENT19 12'h333
`define CSR_MHPMEVENT20 12'h334
`define CSR_MHPMEVENT21 12'h335
`define CSR_MHPMEVENT22 12'h336
`define CSR_MHPMEVENT23 12'h337
`define CSR_MHPMEVENT24 12'h338
`define CSR_MHPMEVENT25 12'h339
`define CSR_MHPMEVENT26 12'h33A
`define CSR_MHPMEVENT27 12'h33B
`define CSR_MHPMEVENT28 12'h33C
`define CSR_MHPMEVENT29 12'h33D
`define CSR_MHPMEVENT30 12'h33E
`define CSR_MHPMEVENT31 12'h33F


`endif

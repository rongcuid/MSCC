# The Mad Scientist Carl's Core

A RISCV 32-bit softcore, started as a challenge, then went through 2018 RISC-V Contest sprint,
and will be (hopefully) maintained forever.

# Update (2019-05-15)

Today, I release the v0.2 version.
Now the GPIO is bidirectional with `DIR0` as direction selection. 
In addition, the core has successfully printed Hello World using a bare metal C program over software UART on an Artix-7 FPGA.
The code for that will be released later.

This update, and subsequent updates carrying the v0.x tags, are intended for a reference core for another project.
After the project finishes, the v0.x version will reach its end of life.
I also use this as a bootloader core to boot up another, more powerful CPU, by streaming programs from UART port.

The major change is splitting memory banks from mmu, and instead allow them to exist on the same level as
core_top and io_port (see <cpu_top.v>).

The memory bank interface contains the following ports:

```
ram_iaddr  : instruction port address
ram_irdata : instruction read data
ram_addr   : data port address
ram_wstrb  : data write strobe, each bit enables one column of 8-bit
ram_wdata  : data port write data
```

The memory bank itself is implemented using a strobed, one-clock two-port block ram with no output register.
It has 32-bit word width and 8-bit strobe.

Currently, the CPU implements a 16Kx32 memory, and it is not easy to change due to bad code style.
I do not intend to maintain this version, and I will definitely rewrite the entire thing.

Also, now _instruction memory is read-write_, as the dedicated ROM is removed.
The entire main memory is mapped on `0x00000000-0x7FFFFFFFF`, while IO mapping is still on `0x80000000-0x800000FF`.

Due to the change, the compliance test suite no longer needs to copy the `.data` section, 
and only needs to zero `.bss`.

# 2018 Contest Summary

The contest objective has failed: I could not fit the CPU into the FPGA. <del>However,
riscv-compliance tests pass for all except `FENCE.I`, which is optional. </del>
<del>Base integer instruction set v2.1 no longer requires `FENCE.I`, so this core is compliant! Yay!</del>
This update makes both version compliant! Which means, `RV32I` v2.0, or `RV32Izicsr_zifenci` v2.1.

# Introduction

A RISCV RV32Izicsr_zifencei softcore, with all essential instructions, memory mapped IO port, and precise exception.

# Run the tests

First, prerequisites must be installed. I used Ubuntu 18.04 LTS to develop:

```
$ apt-get install build-essential verilator cmake
```

Then, SystemC 2.3.3 must be installed, and environmental variable `SYSTEMC_INCLUDE`
and `SYSTEMC_LIBDIR` need to be set properly for verilator to work.

Next, the Zephyr RISCV32 toolchain needs to be installed, and environment
variable `RISCV_PREFIX` need to be set:

```
export RISCV_PREFIX="riscv32-zephyr-elf-"
```

Or, if you prefer absolute path, this is one example:

```
export RISCV_PREFIX=/opt/zephyr-sdk/sysroots/x86_64-pokysdk-linux/usr/bin/riscv32-zephyr-
```

Clone the repo. Then in the repo, clone the riscv-compliance submodule:


```
$ git submodule update --init -- riscv-compliance
```

To run the riscv-compliance test, run:

```
$ make
```

Subarch tests are used to test incomplete CPU implementation. Each test
depends only on instructions tested by previous tests.
To run subarch test, run:

```
$ make run_cpu_top_tb
```

# Architecture

RISC-V RV32I two stage pipeline, early branch, CSR and exception in XB
stage. All essential instructions are implemented, except `FENCE.I`. Certain CSR
registers such as performance counters are not implemented.

# Interrupts

System timer compare interrupt

# Exceptions

Precise exceptions are implemented. Illegal Instruction Exception,
Instruction/Memory Address Misaligned Exception, ECALL, and EBREAK
 are supported.

# Vectors

- Reset: 0x00000000

- Trap vector: 0x00000004, can be changed by writing mtvec

# I/O

- Memory mapped on 0x80000000-0x800000FF
- GPIO0: 0x80000000, 8-bits wide. The same port is also used to communicate with
  test bench
- DIR0: 0x80000001, 8-bits wide. Direction selection
- System timer `mtime` is on 0x80000010, `mtimecmp` is on 0x80000018. Both are 64-bit

# Memory

- Main Memory on 0x00000000-0x7FFFFFFF

- IO on 0x80000000-0x800000FF

# Compliance

<del>Since instruction memory is read only, _FENCE.I_ test cannot pass. All other tests
of riscv-compliance pass.</del>

The compliance suite has following modifications:

1. Linker script is modified to use specified address range
2. EXTRA\_INIT is defined to zero `.bss` region
3. At the end of init, a command is sent through 0x80000000 
  to prompt the test bench to scan memory
4. `.data` region begins with word 0xdeadc0de
5. `.data` region ends with word 0xdeaddead
6. During scanning, testbench finds `0xdeaddead` from highest address.
  Then, it finds the first entry which is not `0xffffffff`, marking it
  as the base result address
7. At the end of the test, another command is sent through 0x80000000
  to halt the test bench

# Zephyr

Theoretically, Zephyr should work because all components it use work. However,
it is too large to fit into my FPGA, so I could not test it.


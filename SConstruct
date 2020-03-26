import os


Help("""
scons # build the core
scons subarch # run sub-architecture tests
scons fullarch # run full-architecture tests
scons compliance # run riscv-compliacne tests
scons benchmark # run benchmarks
""")


bld_verilator_mk = Builder(action = "verilator -Wall -Iinclude --Mdir ${TARGET.dir} --cc --exe $SOURCES")
bld_verilator_exe = Builder(action = "make -C ${SOURCE.dir} -f ${SOURCE.file}")

env = Environment(BUILDERS = {"Vmk" : bld_verilator_mk
                              , "Vexe" : bld_verilator_exe})

def create_verilator_targets(top_name, verilog_list, main_source, cxx_list = []):
    """
    Quickly create Verilator targets.

    Compiles executable into obj_dir_${top_name}/V${top_name}.

    Arguments:
        top_name: Verilog top module name
        verilog_list: Verilog source list
        main_source: Main C++ source file
        cxx_list: Additional C++ files

    Returns:
        (s1, s2): s1 is the Verilator stage; s2 is the final executable stage
    """
    obj_dir = "obj_dir_" + top_name + "/"
    mk = obj_dir + "V" + top_name + ".mk"
    base = obj_dir + "V" + top_name
    exe = base
    # Define targets
    s1 = env.Vmk(mk, verilog_list + cxx_list + [main_source])
    s2 = env.Vexe(exe, mk)
    Depends(s2, s1)
    # Define cleans
    Clean(s1, obj_dir)
    Clean(s2, obj_dir)
    return (s1, s2)


# Verilator test, Hello world to show verilator working
test_s1, test_s2 = create_verilator_targets("our", ["test/verilator/our.v"], "test/verilator/sim_main.cpp")

# Verilator test, blinker to do some I/O
ts00_s1, ts00_s2 = create_verilator_targets("blinker", ["test/blinker/blinker.v"], "test/blinker/sim_main.cpp")

## Test Stage 0: MMU-GPIO test. Ensure vertical stack from simulation to deployment works
#ts00_vs = []
#ts00_vs += ["test/00-mmu-gpio/tb_mmu_gpio.v"]
#ts00_vs += ["src/gpio.v", "src/mmu.v"]
#ts00_s1, ts00_s2 = create_verilator_targets("tb_mmu_gpio", ts00_vs, "test/00-mmu-gpio/sim_main.cpp")

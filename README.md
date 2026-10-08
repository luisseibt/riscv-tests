riscv-tests
================

About
-----------

This repository hosts unit tests for RISC-V processors.


Building from repository
-----------------------------
    $ git clone https://github.com/riscv/riscv-tests
    $ cd riscv-tests
    $ git submodule update --init --recursive
    $ ./run_docker.sh build

Dhrystone Benchmark
-----------------------------
Singlecore:
        building it:
                benchmarks/dhrystone.riscv
                This elf can be executed on the vcml-pydrofoil virtual prototype with one core 

        Configuration file:
                vcml-pydrofoil/benchmark/dhrystone/dhrystone.cfg
                please put the .elf (dhrystone.riscv) in the build folder located at vcml-pydrofoil/benchmark/dhrystone/build


Multicore (1, 2, 4 or 8 cores):
        building it
                benchmarks/dhrystone_core0.riscv ... benchmarks/dhrystone_core7.riscv
                Every core runs its own instance of Dhrystone from its own elf. All of
                them are built from benchmarks/dhrystone_mc/, the Makefile links
                dhrystone_core<i>.riscv to its own 64K slice of the RAM at 0x800<i>0000
                (-Wl,--defsym=RAM_ORIGIN=..., see benchmarks/dhrystone_mc/linker.ld).

        Configuration file:
                vcml-pydrofoil/benchmark/dhrystone_multicore/dhrystone.cfg
                please put the elfs (dhrystone_core<i>.riscv) in the build folder located at
                vcml-pydrofoil/benchmark/dhrystone_multicore/build
                The number of cores is set by system.ncores in the configuration file.



Multicore_simdev (0x1C203000):
        Gives multicore software an exit point
        write core_id to SIMDEV_CORE_DONE to signal that core: core_id has finished execution

        Output of core 0 and core 1 goes to SIMDEV_SOUT_CORE0 / SIMDEV_SOUT_CORE1, the
        other cores print nothing (print_char() in benchmarks/dhrystone_mc/dhrystone.c).
        system.multicore_simdev.write_to_file = true -> logs for core_0 are written to logs/core0_output.txt
                                                     -> logs for core_1 are written to logs/core1_output.txt
        system.multicore_simdev.write_to_file = false -> both go to stdout


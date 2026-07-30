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


Mutlicore:
        building it 
                benchmarks/dhrystone_core0.riscv
                This elf is supposed to be executed on core0 of the virtual prototype with 2 core
                
                benchmarks/dhrystone_core1.riscv
                This elf is supposed to be executed on core1 of the virtual prototype with 2 cores
        
        Configuration file:
                vcml-pydrofoil/benchmark/dhrystone_2cores/dhrystone.cfg
                please put the .elf(s) (dhrystone.riscv) in the build folder located at vcml-pydrofoil/benchmark/dhrystone_2cores/build



Multicore_simdev:
        Gives multicore software an exit point
        write core_id to SIMDEV_CORE_DONE to signal that core: core_id has finished execution

        system.multicore_simdev.write_to_file = true -> logs for core_0 are written to logs/core0_output.txt
                                                     -> logs for core_1 are written to logs/core1_output.txt
        if logs are supposed to be disabled, please uncomment:
                SIMDEV_SOUT_CORE0 = c; 
                        in print_char() in:
                        - /home/seibt/thesis/riscv-tests/benchmarks/dhrystone_core0/dhrystone.c
                        - /home/seibt/thesis/riscv-tests/benchmarks/dhrystone_core1/dhrystone.c


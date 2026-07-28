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
benchmarks/dhrystone.riscv
        This elf can be executed on the vcml-pydrofoil virtual prototype with one core 
        please find the correponding config in the vcml-pydrofoil repository under benchmarks/dhrystone   

benchmarks/dhrystone_core0.riscv
        This elf is supposed to be executed on core0 of the virtual prototype with 2 core
        please find the correponding config in the vcml-pydrofoil repository under benchmarks/dhrystone_2cores

benchmarks/dhrystone_core0.riscv
        This elf is supposed to be executed on core1 of the virtual prototype with 2 cores
        please find the correponding config in the vcml-pydrofoil repository under benchmarks/dhrystone_2cores

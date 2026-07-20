#!/bin/bash
set -euo pipefail

# Make sure we are in the mounted directory
cd /app

if [ "$1" == "build" ]; then
    echo "=== Starting riscv-tests build ==="
    
    # Step 1: Generate the configure script if it doesn't exist
    if [ ! -f "./configure" ]; then
        echo "Generating configure script..."
        autoconf
    fi
    
    # Step 2: Run configure (we skip --prefix since we aren't installing to the system)
    if [ ! -f "./Makefile" ]; then
        echo "Configuring build system..."
        ./configure
    fi
    
    # Step 3: Compile benchmarks and ISA tests
    echo "Compiling tests..."
    make

elif [ "$1" == "clean" ]; then
    echo "=== Cleaning build files ==="
    # Only run make clean if the Makefile actually exists
    if [ -f "./Makefile" ]; then
        make clean
    else
        echo "Nothing to clean."
    fi
else
    echo "Error: Unsupported argument. Use 'build' or 'clean'."
    exit 1
fi
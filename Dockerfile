FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Install build tools, autoconf, and wget to download the toolchain
RUN apt-get update && apt-get -y install \
    build-essential \
    autoconf \
    wget \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt

# Download and extract the official SiFive RISC-V bare-metal toolchain
RUN wget "https://static.dev.sifive.com/dev-tools/freedom-tools/v2020.12/riscv64-unknown-elf-toolchain-10.2.0-2020.12.8-x86_64-linux-ubuntu14.tar.gz"
RUN tar -xzf riscv64-unknown-elf-toolchain-10.2.0-2020.12.8-x86_64-linux-ubuntu14.tar.gz \
    && rm riscv64-unknown-elf-toolchain-10.2.0-2020.12.8-x86_64-linux-ubuntu14.tar.gz

# Add the pre-built toolchain to the system PATH
ENV PATH="/opt/riscv64-unknown-elf-toolchain-10.2.0-2020.12.8-x86_64-linux-ubuntu14/bin:${PATH}"

# The riscv-tests makefile requires the RISCV variable to know where the toolchain is
ENV RISCV="/opt/riscv64-unknown-elf-toolchain-10.2.0-2020.12.8-x86_64-linux-ubuntu14"

WORKDIR /app

ENTRYPOINT ["/app/docker_entrypoint.sh"]
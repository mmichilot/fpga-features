#!/usr/bin/env bash

# Install necessary packages
apt-get update
packages=("git" "build-essential" "device-tree-compiler" "libboost-regex-dev" "libboost-system-dev")
for package in "${packages[@]}"; do
    if ! dpkg -s "${package}" >/dev/null 2>&1; then
        echo "${package} not found, installing..." 
        DEBIAN_FRONTEND=noninteractive apt-get install -y "${package}"
    fi
done


# Build spike
mkdir -p ${SPIKE_DIR}

git clone https://github.com/riscv-software-src/riscv-isa-sim && cd riscv-isa-sim
mkdir build && cd build
../configure --prefix=${SPIKE_DIR} && make -j$(nproc) install


# Update PATH
echo -e "export PATH=\${PATH}:${SPIKE_DIR}/bin" >> /etc/bash.bashrc
#!/usr/bin/env bash

echo "$(getent passwd $(id -un))"

source dev-container-features-test-lib

check "check riscv-none-elf-gcc" riscv-none-elf-gcc --version

reportResults
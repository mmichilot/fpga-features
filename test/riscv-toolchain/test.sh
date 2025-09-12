#!/bin/bash

source dev-container-features-test-lib

check "check riscv-none-elf-gcc" riscv-none-elf-gcc --version

reportResults
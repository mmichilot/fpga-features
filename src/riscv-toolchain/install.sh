#!/usr/bin/env bash

ARCHIVE_URL=$(curl -L https://api.github.com/repos/xpack-dev-tools/riscv-none-elf-gcc-xpack/releases/latest | \
    jq -r '.assets[] | select(.name | contains("linux-x64") and (contains("sha") | not)) | .browser_download_url')

mkdir -p ${TOOLCHAIN_DIR}

wget ${ARCHIVE_URL} -O riscv-toolchain.tgz \
&& tar -xvf riscv-toolchain.tgz -C ${TOOLCHAIN_DIR} --strip-components=1

echo -e "export PATH=\${PATH}:${TOOLCHAIN_DIR}/bin" >> /etc/bash.bashrc
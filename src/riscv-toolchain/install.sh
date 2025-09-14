#!/usr/bin/env bash

# Install necessary packages
apt-get update
packages=("curl" "jq")
for package in "${packages[@]}"; do
    if ! command -v "${package}" >/dev/null 2>&1; then
        echo "${package} not found, installing..." 
        apt-get install -y "${package}"
    fi
done


# Download and extract archive
archive_url=$(curl -sL https://api.github.com/repos/xpack-dev-tools/riscv-none-elf-gcc-xpack/releases/latest | \
    jq -r '.assets[] | select(.name | contains("linux-x64") and (contains("sha") | not)) | .browser_download_url')

mkdir -p ${TOOLCHAIN_DIR}
curl -sLo - "${archive_url}" | tar -xzf - -C ${TOOLCHAIN_DIR} --strip-components=1


# Update $PATH
echo -e "export PATH=\${PATH}:${TOOLCHAIN_DIR}/bin" >> /etc/bash.bashrc
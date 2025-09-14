#!/usr/bin/env bash

# Download and extract OSS CAD Suite
archive_url=$(curl -sL https://api.github.com/repos/YosysHQ/oss-cad-suite-build/releases/latest | \
    jq -r '.assets[] | select(.name | contains("linux-x64")) | .browser_download_url')

curl -sLo - "${archive_url}" | tar -xzf - -C "${HOME}"


# Update .bashrc
suite_dir=${HOME}/oss-cad-suite

cat << EOF >> "${HOME}/.bashrc"

# OSS CAD Suite Environment
export SUITE_DIR="${suite_dir}"

if [ "${AUTOACTIVATE}" = "true" ]; then
    source ${suite_dir}/environment
else
    cat << 'END'
    #
    # To activate the OSS CAD Suite environment, use
    #
    #     $ source \${SUITE_DIR}/environment
    #
END
fi

EOF
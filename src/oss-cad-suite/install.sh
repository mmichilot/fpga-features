#!/usr/bin/env bash

# Get OSS CAD Suite
ARCHIVE_URL=$(curl -L https://api.github.com/repos/YosysHQ/oss-cad-suite-build/releases/latest | \
    jq -r '.assets[] | select(.name | startswith("oss-cad-suite-linux-x64")) | .browser_download_url')

wget ${ARCHIVE_URL} -O oss-cad-suite.tgz \
&& tar -xvf oss-cad-suite.tgz -C $(dirname "${SUITE_DIR}")


# Activate suite environment on login, if selected, otherwise offer a MOTD
# describing how to activate the environment
if [ "${ACTIVATEONLOGIN}" = "true" ]; then
    echo "Updating /etc/bash.bashrc"
    echo -e "source ${SUITE_DIR}/environment" >> /etc/bash.bashrc
else
    echo "Adding custom MOTD"
    tee /etc/update-motd.d/00-activate-suite > /dev/null \
    <<'EOF'
    #!/bin/sh

    echo "To activate OSS CAD Suite:"
    echo "$ source ${SUITE_DIR}/environment"
EOF
fi
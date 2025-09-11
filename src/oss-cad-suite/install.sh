#!/usr/bin/env bash

ARCHIVE_URL=$(curl -L https://api.github.com/repos/YosysHQ/oss-cad-suite-build/releases/latest | \
    jq -r '.assets[] | select(.name | startswith("oss-cad-suite-linux-x64")) | .browser_download_url')

wget ${ARCHIVE_URL} -O oss-cad-suite.tgz \
&& tar -xvf oss-cad-suite.tgz -C $(dirname "${SUITE_DIR}")

echo -e "export AUTOACTIVATE=${AUTOACTIVATE}" >> /etc/bash.bashrc

cp ./start.sh ${SUITE_DIR}
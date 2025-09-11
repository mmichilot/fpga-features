#!/usr/bin/env bash

source_cmd="source ${SUITE_DIR}/environment"

echo -e "alias activate-suite=\"${source_cmd}\"" >> ${HOME}/.bashrc

cat <<EOF
#
# To activate the OSS CAD Suite environment, use
#
#     $ activate-suite
#
# To deactivate, use
#
#     $ deactivate
EOF

if [ "${AUTOACTIVATE}" = "true" ]; then
    echo -e ${source_cmd} >> ${HOME}/.bashrc
fi
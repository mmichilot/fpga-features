#!/usr/bin/env bash

SUITE_DIR=${SUITE_DIR}
AUTOACTIVATE=${AUTOACTIVATE}
USERNAME="${USERNAME:-"${_REMOTE_USER:-"automatic"}"}"

# Determine the appropriate non-root user
# Copied from https://github.com/devcontainers/features/blob/main/src/anaconda/install.sh
if [ "${USERNAME}" = "auto" ] || [ "${USERNAME}" = "automatic" ]; then
    USERNAME=""
    POSSIBLE_USERS=("vscode" "node" "codespace" "$(awk -v val=1000 -F ":" '$3==val{print $1}' /etc/passwd)")
    for CURRENT_USER in "${POSSIBLE_USERS[@]}"; do
        if id -u "${CURRENT_USER}" > /dev/null 2>&1; then
            USERNAME="${CURRENT_USER}"
            break
        fi
    done
    if [ "${USERNAME}" = "" ]; then
        USERNAME=root
    fi
elif [ "${USERNAME}" = "none" ] || ! id -u ${USERNAME} > /dev/null 2>&1; then
    USERNAME=root
fi
echo "Username: ${USERNAME}"


# Download and extract OSS CAD Suite
archive_url=$(curl -sL https://api.github.com/repos/YosysHQ/oss-cad-suite-build/releases/latest | \
    jq -r '.assets[] | select(.name | contains("linux-x64")) | .browser_download_url')

wget -qO - "${archive_url}" | tar -xzf - -C "$(dirname ${SUITE_DIR})"


# Activate environment, if needed
bashrc="/home/${USERNAME}/.bashrc"
source_cmd="source ${SUITE_DIR}/environment"

if [ "${AUTOACTIVATE}" = "true" ]; then
    echo ${source_cmd} >> "${bashrc}"
fi


# Add notice on how to activate environment
cat <<'EOF' > "${SUITE_DIR}/activate.txt"
#
# To activate the OSS CAD Suite environment manually, use
#
#     $ source \${SUITE_DIR}/environment
#
# To deactivate, use
#
#     $ deactivate
EOF

echo "cat ${SUITE_DIR}/activate.txt" >> "${bashrc}"


# Make the suite directory accessible to user
chown -R "${USERNAME}:${USERNAME}" "${SUITE_DIR}"
chmod -R u=rwx,go=rx "${SUITE_DIR}"
stat -c "%U:%G ${SUITE_DIR}" ${SUITE_DIR}
exit 1
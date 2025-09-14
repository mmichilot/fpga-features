#!/usr/bin/env bash

AUTOACTIVATE=${AUTOACTIVATE}
USERNAME="${USERNAME:-"${_REMOTE_USER:-"automatic"}"}"

# Install necessary packages
apt-get update
packages=("curl" "jq")
for package in "${packages[@]}"; do
    if ! command -v "${package}" >/dev/null 2>&1; then
        echo "${package} not found, installing..." 
        apt-get install -y "${package}"
    fi
done


# Determine the appropriate non-root user
# https://github.com/devcontainers/features/blob/main/src/anaconda/install.sh
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


# Complete install in user context
echo "Completing install as ${USERNAME}"
su "${USERNAME}" -c "/bin/bash ./install_user.sh"
#!/bin/bash

source dev-container-features-test-lib

check "oss-cad-suite environment is not activated" bash -c "[[ -z '${VIRTUAL_ENV_PROMPT}' ]]"
check "motd exists" bash -c "[[ -f '/etc/update-motd.d/00-activate-suite' ]]"

reportResults
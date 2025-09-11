#!/bin/bash

source dev-container-features-test-lib

check "oss-cad-suite environment is not activated" bash -c "[[ -z '${VIRTUAL_ENV_PROMPT}' ]]"
check "check activate-suite alias" alias | grep 'activate-suite'

reportResults
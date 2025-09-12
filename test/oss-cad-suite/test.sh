#!/bin/bash

source dev-container-features-test-lib

check "oss-cad-suite environment is not activated" bash -c "[[ -z '${VIRTUAL_ENV_PROMPT}' ]]"
check "oss-cad-suite is user accessible" bash -c "stat -c "%U:%G" ${SUITE_DIR} | grep '${USER}:${USER}'"
check "oss-cad-suite environment is sourceable" bash -c "source ${SUITE_DIR}/environment"

reportResults
#!/bin/bash

env

source dev-container-features-test-lib

check "oss-cad-suite environment is activated" bash -c "[[ '${VIRTUAL_ENV_PROMPT}' == 'OSS CAD Suite' ]]"
check "oss-cad-suite is user accessible" bash -c "stat -c "%U:%G" ${SUITE_DIR} | grep '${USER}:${USER}'"
check "tools are accessible" bash -c "verilator --version && yosys --version"
check "tabbypip can install packages" bash -c "tabbypip install riscof"

reportResults
#!/bin/bash

source dev-container-features-test-lib

check "oss-cad-suite environment is activated" bash -c "[[ '${VIRTUAL_ENV_PROMPT}' == 'OSS CAD Suite' ]]"

reportResults
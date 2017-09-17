#!/usr/bin/env bash

set -e
set -u
set -o pipefail

"$(yarn bin)/pjl-cli"

shellcheck --shell bash src/*.bash

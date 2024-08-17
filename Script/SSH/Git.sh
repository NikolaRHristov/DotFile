#!/bin/sh

# shellcheck disable=SC1090
# shellcheck disable=SC3046
source ~/.alias
source ~/.functions

sshagent_init

exec ssh-agent ssh "$@"

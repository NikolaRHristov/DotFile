#!/usr/env/bin bash

if [ -f ~/.keychain/"$(hostname)"-sh ]; then
    # shellcheck disable=SC1090
    . ~/.keychain/"$(hostname)"-sh
fi

# shellcheck disable=SC1090
# shellcheck disable=SC3010
[[ -f ~/.bashrc ]] && . ~/.bashrc

. "/Volumes/CORSAIR/Tool/macOS/rust/cargo/env"

export GIT_DISCOVERY_ACROSS_FILESYSTEM=1

#!/usr/env/bin bash

if [ -f ~/.keychain/"$(hostname)"-sh ]; then
    # shellcheck disable=SC1090
    . ~/.keychain/"$(hostname)"-sh
fi

# shellcheck disable=SC1090
# shellcheck disable=SC3010
[[ -f ~/.bashrc ]] && . ~/.bashrc

<<<<<<< HEAD
# shellcheck disable=SC1091
=======
>>>>>>> df8efd04ba696a59fd2b12ab29f76ecf64258306
. "/Volumes/CORSAIR/Tool/macOS/rust/cargo/env"

export GIT_DISCOVERY_ACROSS_FILESYSTEM=1

#!/bin/bash

if [ -f ~/.keychain/"$(hostname)"-sh ]; then
  # shellcheck disable=SC1090
  . ~/.keychain/"$(hostname)"-sh
fi

# shellcheck disable=SC1090
# shellcheck disable=SC3010
[[ -f ~/.bashrc ]] && . ~/.bashrc

# shellcheck disable=SC1091
[[ -f $HOME/.nix-profile/etc/profile.d/nix.sh ]] && . "$HOME"/.nix-profile/etc/profile.d/nix.sh

# shellcheck disable=SC1091
. "$HOME/.cargo/env"

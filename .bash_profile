#!/bin/bash

# shellcheck disable=SC1090
# shellcheck disable=SC3010
[[ -f ~/.bashrc ]] && . ~/.bashrc

# shellcheck disable=SC1091
[[ -f $HOME/.nix-profile/etc/profile.d/nix.sh ]] && . "$HOME"/.nix-profile/etc/profile.d/nix.sh

# shellcheck disable=SC2088
[ -d "$HOME/Tool/Bin/PNPM" ] && export PATH="$HOME"/Tool/Bin/PNPM:"$PATH"

# shellcheck disable=SC1091
[ -d "$HOME/.grit/bin/env" ] && . "$HOME/.grit/bin/env"

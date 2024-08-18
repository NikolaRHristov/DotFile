#!/bin/sh

# shellcheck disable=SC1090
# shellcheck disable=SC3010
[[ -f ~/.bashrc ]] && . ~/.bashrc

# shellcheck disable=SC3010
# shellcheck disable=SC1091
[[ -f $HOME/.nix-profile/etc/profile.d/nix.sh ]] && . "$HOME"/.nix-profile/etc/profile.d/nix.sh

[ -d "/d/Developer" ] && cd /d/Developer || cd ~/ || exit

# shellcheck disable=SC2088
[ -d "$HOME/Tool/Bin/PNPM" ] && export PATH="$HOME"/Tool/Bin/PNPM:"$PATH"

# shellcheck disable=SC1091
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

. "$HOME/.grit/bin/env"

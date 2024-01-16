#!/bin/sh

# shellcheck disable=SC1090
# shellcheck disable=SC3010
[[ -f ~/.bashrc ]] && . ~/.bashrc

# shellcheck disable=SC3010
# shellcheck disable=SC1091
[[ -f /home/nikola/.nix-profile/etc/profile.d/nix.sh ]] && . /home/nikola/.nix-profile/etc/profile.d/nix.sh

[ -d "/d/Developer" ] && cd /d/Developer || cd ~/ || exit

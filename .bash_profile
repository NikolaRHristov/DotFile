#!/bin/sh
if [ -f ~/.bashrc ]; then
	# shellcheck source=/dev/null
	. ~/.bashrc
fi

if [ -e /home/nikola/.nix-profile/etc/profile.d/nix.sh ]; then . /home/nikola/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

[ -d "/f/Developer" ] && cd /f/Developer || cd ~/ || exit

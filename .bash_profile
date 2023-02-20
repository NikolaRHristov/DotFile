#!/bin/sh
if [ -f ~/.bashrc ]; then
	# shellcheck source=/dev/null
	. ~/.bashrc
fi

if [ -e /home/nhris/.nix-profile/etc/profile.d/nix.sh ]; then . /home/nhris/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

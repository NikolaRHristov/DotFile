#!/usr/env/bin bash

if [ -f ~/.keychain/"$(hostname)"-sh ]; then
	# shellcheck disable=SC1090
	. ~/.keychain/"$(hostname)"-sh
fi

# shellcheck disable=SC1090
# shellcheck disable=SC3010
[[ -f ~/.bashrc ]] && . ~/.bashrc

# shellcheck disable=SC1091
. "/Volumes/CORSAIR/Tool/macOS/rust/cargo/env"

export GIT_DISCOVERY_ACROSS_FILESYSTEM=1
export HOMEBREW_NO_ANALYTICS=1
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export POWERSHELL_TELEMETRY_OPTOUT=1

# Added by Actual Computer installer
export PATH="$HOME/.actual/bin:$PATH"

# Added by Antigravity CLI installer
export PATH="/Users/nikola/.local/bin:$PATH"
. "$HOME/.cargo/env"

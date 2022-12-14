#!/bin/bash
case $- in
*i*) ;;
*) return ;;
esac

if [ -f ${WSLENV+} ]; then
	export PATH="$PATH:$HOME/.config/xclip"
fi

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
export DO_NOT_TRACK=1
GPG_TTY=$(tty)
export GPG_TTY
export PATH=$PATH:/usr/local/go/bin
export OSH=~/.oh-my-bash

# shellcheck disable=SC2034
OSH_THEME="powerline-multiline"
# shellcheck disable=SC2034
CASE_SENSITIVE="true"
# HYPHEN_INSENSITIVE="true"
# DISABLE_AUTO_UPDATE="true"
# export UPDATE_OSH_DAYS=13
# shellcheck disable=SC2034
DISABLE_LS_COLORS="true"
# shellcheck disable=SC2034
DISABLE_AUTO_TITLE="true"
# shellcheck disable=SC2034
ENABLE_CORRECTION="true"
# shellcheck disable=SC2034
COMPLETION_WAITING_DOTS="true"
# shellcheck disable=SC2034
DISABLE_UNTRACKED_FILES_DIRTY="true"
# shellcheck disable=SC2034
HIST_STAMPS="mm/dd/yyyy"
# OMB_DEFAULT_ALIASES="check"
# OSH_CUSTOM=/path/to/new-custom-folder
# OMB_USE_SUDO=true

# shellcheck disable=SC2034
completions=(
	composer
	defaults
	dirs
	docker
	docker-compose
	gh
	git
	npm
	pip
	pip3
	ssh
	terraform
)

# shellcheck disable=SC2034
aliases=(
	general
)

# shellcheck disable=SC2034
plugins=(
	git
	bashmarks
	npm
	progress
)

#  if [ "$DISPLAY" ] || [ "$SSH" ]; then
#      plugins+=(tmux-autoattach)
#  fi

# shellcheck source=/dev/null
source "$OSH"/oh-my-bash.sh

# export MANPATH="/usr/local/man:$MANPATH"
export LANG=en_US.UTF-8

export EDITOR="nano"
export ARCHFLAGS="-arch x86_64"

# pnpm
if [ -z ${WSLENV+} ]; then
	export PNPM_HOME="$HOME/.local/share/pnpm"
	export PATH="$PNPM_HOME:$PATH"
fi
# pnpm end

if [[ $PS1 && -f ~/.config/bash-completion/bash_completion ]]; then
	# shellcheck source=/dev/null
	. ~/.config/bash-completion/bash_completion
fi

if [[ $PS1 && -f /usr/share/bash-completion/bash_completion ]]; then
	# shellcheck source=/dev/null
	. /usr/share/bash-completion/bash_completion
fi

if [ -f "$HOME/.cargo/env" ]; then
	# shellcheck source=/dev/null
	. "$HOME/.cargo/env"
fi

export PATH="$PATH:$HOME/.cargo/bin"

if [ -f "$NVM_DIR/nvm.sh" ]; then
	# shellcheck source=/dev/null
	. "$NVM_DIR/nvm.sh"
fi

if [ -f "$NVM_DIR/bash_completion" ]; then
	# shellcheck source=/dev/null
	. "$NVM_DIR/bash_completion"
fi

if [ -f ~/.aliases ]; then
	# shellcheck source=/dev/null
	. ~/.aliases
fi

if [ -f ~/.functions ]; then
	# shellcheck source=/dev/null
	. ~/.functions
fi

export PATH="$PATH:/c/Users/nhris/.bin"
export AWS_CLI_AUTO_PROMPT=on-partial

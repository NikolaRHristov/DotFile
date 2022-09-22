case $- in
*i*) ;;
*) return ;;
esac

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
export DO_NOT_TRACK=1
export GPG_TTY=$(tty)
export PATH=$PATH:/usr/local/go/bin
export OSH=~/.oh-my-bash

OSH_THEME="powerline-multiline"
CASE_SENSITIVE="true"
# HYPHEN_INSENSITIVE="true"
# DISABLE_AUTO_UPDATE="true"
# export UPDATE_OSH_DAYS=13
DISABLE_LS_COLORS="true"
DISABLE_AUTO_TITLE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="mm/dd/yyyy"
# OMB_DEFAULT_ALIASES="check"
# OSH_CUSTOM=/path/to/new-custom-folder
# OMB_USE_SUDO=true
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
aliases=(
	general
)
plugins=(
	git
	bashmarks
	npm
	progress
)

#  if [ "$DISPLAY" ] || [ "$SSH" ]; then
#      plugins+=(tmux-autoattach)
#  fi

source "$OSH"/oh-my-bash.sh

# export MANPATH="/usr/local/man:$MANPATH"
export LANG=en_US.UTF-8

export EDITOR='nano'
export ARCHFLAGS="-arch x86_64"

# pnpm
if [ -z $WSLENV ]; then
	export PNPM_HOME="$HOME/.local/share/pnpm"
	export PATH="$PNPM_HOME:$PATH"
fi
# pnpm end

if [[ $PS1 && -f ~/.config/bash-completion/bash_completion ]]; then
	. ~/.config/bash-completion/bash_completion
fi

if [[ $PS1 && -f /usr/share/bash-completion/bash_completion ]]; then
	. /usr/share/bash-completion/bash_completion
fi

if [ -f "$HOME/.cargo/env" ]; then
	. "$HOME/.cargo/env"
fi

export PATH="$PATH:$HOME/.cargo/bin"

if [ -f "$NVM_DIR/nvm.sh" ]; then
	. "$NVM_DIR/nvm.sh"
fi

if [ -f "$NVM_DIR/bash_completion" ]; then
	. "$NVM_DIR/bash_completion"
fi

if [ -f ~/.aliases ]; then
	. ~/.aliases
fi

if [ -f ~/.functions ]; then
	. ~/.functions
fi

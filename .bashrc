case $- in
*i*) ;;
*) return ;;
esac

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

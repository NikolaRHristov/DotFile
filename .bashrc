#!/bin/bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

colors() {
	local fgc bgc vals seq0

	# shellcheck disable=SC2016
	printf "Color escapes are %s\n" '\e[${value};...;${value}m'

	printf "Values 30..37 are \e[33mforeground colors\e[m\n"

	printf "Values 40..47 are \e[43mbackground colors\e[m\n"

	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	# foreground colors
	for fgc in {30..37}; do
		# background colors
		for bgc in {40..47}; do
			fgc=${fgc#37} # white
			bgc=${bgc#40} # black

			vals="${fgc:+$fgc;}${bgc}"

			vals=${vals%%;}

			seq0="${vals:+\e[${vals}m}"

			printf "  %-9s" "${seq0:-(default)}"

			# shellcheck disable=SC2059
			printf " ${seq0}TEXT\e[m"

			# shellcheck disable=SC2059
			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"

		done
		echo
		echo
	done
}

# shellcheck disable=SC1091
[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Change the window title of X terminals
case ${TERM} in

xterm* | rxvt* | Eterm* | aterm | kterm | gnome* | interix | konsole*)
	PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'

	;;
screen*)
	PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'

	;;
esac

use_color=true

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?} # sanitize TERM
match_lhs=""

[[ -f ~/.dir_colors ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"

[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"

[[ -z ${match_lhs} ]] &&
	type -P dircolors >/dev/null &&
	match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if ${use_color}; then

	# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
	if type -P dircolors >/dev/null; then

		if [[ -f ~/.dir_colors ]]; then

			# shellcheck disable=SC2046
			eval $(dircolors -b ~/.dir_colors)
		elif [[ -f /etc/DIR_COLORS ]]; then

			# shellcheck disable=SC2046
			eval $(dircolors -b /etc/DIR_COLORS)
		fi
	fi

	if [[ ${EUID} == 0 ]]; then

		PS1='\[\033[01;31m\][\h\[\033[01;36m\] \W\[\033[01;31m\]]\$\[\033[00m\] '

	else
		PS1='\[\033[01;32m\][\u@\h\[\033[01;37m\] \W\[\033[01;32m\]]\$\[\033[00m\] '

	fi

	alias ls='ls --color=auto'

	alias grep='grep --colour=auto'

	alias egrep='egrep --colour=auto'

	alias fgrep='fgrep --colour=auto'

else
	if [[ ${EUID} == 0 ]]; then

		# show root@ when we don't have colors
		PS1='\u@\h \W \$ '

	else
		PS1='\u@\h \w \$ '

	fi
fi

unset use_color safe_term match_lhs sh

#alias cp="cp -i"                          # confirm before overwriting something
#alias df='df -h'                          # human-readable sizes
#alias free='free -m'                      # show sizes in MB
#alias np='nano -w PKGBUILD'

#alias more=less

xhost +local:root >/dev/null 2>&1

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when

# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

shopt -s expand_aliases

# export QT_SELECT=4

# Enable history appending instead of overwriting.  #139609
shopt -s histappend

case $- in

*i*) ;;
*) return ;;
esac

[[ -f ${WSLENV+} ]] && export PATH="$PATH:$HOME/.config/xclip"

export BUN_INSTALL="$HOME/.bun"

export PATH="$BUN_INSTALL/bin:$PATH"

export NVM_DIR="$HOME/.nvm"

export DO_NOT_TRACK=1
export PATH=$PATH:/usr/local/go/bin

export OSH=~/Bash

# shellcheck disable=SC2034
OSH_THEME="half-life"

# shellcheck disable=SC2034
# CASE_SENSITIVE="true"

# HYPHEN_INSENSITIVE="true"

# shellcheck disable=SC2034
DISABLE_AUTO_UPDATE="true"

# export UPDATE_OSH_DAYS=13
# shellcheck disable=SC2034
DISABLE_LS_COLORS="false"

# shellcheck disable=SC2034
DISABLE_AUTO_TITLE="false"

# shellcheck disable=SC2034
ENABLE_CORRECTION="false"

# shellcheck disable=SC2034
COMPLETION_WAITING_DOTS="false"

# shellcheck disable=SC2034
DISABLE_UNTRACKED_FILES_DIRTY="false"

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
[[ -f "$OSH/oh-my-bash.sh" ]] && . "$OSH/oh-my-bash.sh"

# export MANPATH="/usr/local/man:$MANPATH"

# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then

	export EDITOR='nano'

else
	export EDITOR='nano'

fi

export ARCHFLAGS="-arch x86_64"

if [[ $PS1 && -f ~/.config/Completion/bash_completion ]]; then

	# shellcheck source=/dev/null
	. ~/.config/Completion/bash_completion

fi

if [[ $PS1 && -f /usr/share/Completion/bash_completion ]]; then

	# shellcheck source=/dev/null
	. /usr/share/Completion/bash_completion

fi

# shellcheck source=/dev/null
[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"

export PATH="$PATH:$HOME/.cargo/bin"

# shellcheck source=/dev/null
[[ -f "$NVM_DIR/nvm.sh" ]] && . "$NVM_DIR/nvm.sh"

# shellcheck source=/dev/null
[[ -f "$NVM_DIR/bash_completion" ]] && . "$NVM_DIR/bash_completion"

# shellcheck source=/dev/null
[[ -f ~/.aliases ]] && . ~/.aliases

# shellcheck source=/dev/null
[[ -f ~/.functions ]] && . ~/.functions

export PATH="$HOME/.bin:$PATH"

export AWS_CLI_AUTO_PROMPT=on-partial

# Telemetry
export ADBLOCK=true
export TELEMETRY_DISABLED=1
export ASTRO_TELEMETRY_DISABLED=1
export AUTOMATEDLAB_TELEMETRY_OPTOUT=1
export AZURE_CORE_COLLECT_TELEMETRY=0
export CHOOSENIM_NO_ANALYTICS=1
export DIEZ_DO_NOT_TRACK=1
export DO_NOT_TRACK=1
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export DOTNET_INTERACTIVE_CLI_TELEMETRY_OPTOUT=1
export ET_NO_TELEMETRY=1
export GATSBY_TELEMETRY_DISABLED=1
export GATSBY_TELEMETRY_OPT_OUT=1
export GATSBY_TELEMETRY_OPTOUT=1
export HASURA_GRAPHQL_ENABLE_TELEMETRY=false
export HINT_TELEMETRY=off
export HOMEBREW_NO_ANALYTICS=1
export INFLUXD_REPORTING_DISABLED=true
export ITERATIVE_DO_NOT_TRACK=1
export NEXT_TELEMETRY_DEBUG=1
export NEXT_TELEMETRY_DISABLED=1
export NG_CLI_ANALYTICS=false
export NUXT_TELEMETRY_DISABLED=1
export PIN_DO_NOT_TRACK=1
export POWERSHELL_TELEMETRY_OPTOUT=1
export SAM_CLI_TELEMETRY=0
export STNOUPGRADE=1
export STRIPE_CLI_TELEMETRY_OPTOUT=1
export TERRAFORM_TELEMETRY=0
export VCPKG_DISABLE_METRICS=1

# Turso
export PATH="$HOME/.turso:$PATH"

export RUSTC_WRAPPER=sccache

shopt -s histappend
HISTFILE="$HOME/.bash_history_shared"

HISTSIZE=1000
HISTFILESIZE=10000
# shellcheck disable=SC2034
SAVEHIST=1000

# shellcheck disable=SC1090
[[ -f ~/.bash-preexec.sh ]] && . ~/.bash-preexec.sh

set +o noclobber

# shellcheck disable=SC1091
[ -f "$HOME/.grit/bin/env" ] && . "$HOME/.grit/bin/env"

export PATH="/var/lib/snapd/snap/bin:$PATH"

# GPG_TTY=$(tty)

# export GPG_TTY

# gpgconf --launch gpg-agent

# export GPG_AGENT_INFO

# Cargo
export CARGO_NET_GIT_FETCH_WITH_CLI=true

# pnpm
export PNPM_HOME="/home/nikola/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

export BASH_SILENCE_DEPRECATION_WARNING=1
source '/opt/homebrew/opt/autoenv/activate.sh'

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

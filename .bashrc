#!/bin/bash
# shellcheck disable=SC2148

# ==============================================================================
#                                                                              #
#              ██████╗ ██╗  ██╗██╗   ██╗███████╗██╗  ██╗████████╗               #
#              ██╔══██╗██║  ██║╚██╗ ██╔╝██╔════╝██║  ██║╚══██╔══╝               #
#              ██████╔╝███████║ ╚████╔╝ ███████╗███████║   ██║                  #
#              ██╔══██╗██╔══██║  ╚██╔╝  ╚════██║██╔══██║   ██║                  #
#              ██████╔╝██║  ██║   ██║   ███████║██║  ██║   ██║                  #
#              ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚══════╝╚═╝  ╚═╝   ╚═╝                  #
#                                                                              #
# ==============================================================================
#
# ~/.bashrc: Executed by bash(1) for non-login shells.
#
# This script is designed to be idempotent and modular. You can safely source
# it multiple times without causing issues. It's also organized into sections
# to make it easier to maintain and understand.
#
# For more information on configuring your shell, see the following resources:
#   - Bash Reference Manual: https://www.gnu.org/software/bash/manual/
#   - ShellCheck (for static analysis): https://www.shellcheck.net/
#
# ------------------------------------------------------------------------------
# TODO
# ------------------------------------------------------------------------------
#
# - [ ] **Explore modern alternatives:**
#   - **`zoxide`**: A smarter `cd` command that learns your habits.
#   - **`fzf`**: A command-line fuzzy finder for interactive filtering.
#   - **`thefuck`**: Corrects errors in previous console commands.
#   - **`eza`**: A modern replacement for `ls`.
#
# - [ ] **Improve alias management:**
#   - Group aliases by context (e.g., git, docker, system).
#   - Consider using a dedicated alias file (e.g., `~/.bash_aliases`).
#
# - [ ] **Enhance prompt:**
#   - Look into modern prompt frameworks like Starship or Powerlevel10k.
#   - Add more context to the prompt (e.g., Git branch, Kubernetes context).
#
# - [ ] **Security audit:**
#   - Review `xhost +local:root` and consider more secure alternatives.
#   - Ensure that `GPG_TTY` is set correctly for GPG agent integration.
#
# ==============================================================================
#                                                                              #
#                         INITIALIZATION & GUARDS                                #
#                                                                              #
# ==============================================================================

# If not running interactively, don't do anything. This prevents the script
# from running in non-interactive environments (e.g., scripts).
[[ $- != *i* ]] && return

# Enable history appending instead of overwriting. This is useful for keeping
# a consistent history across multiple shell sessions.
shopt -s histappend

# Set the location of the shared history file. This allows all your shell
# sessions to share the same command history.
export HISTFILE="$HOME/.bash_history_shared"
export HISTSIZE=1000
export HISTFILESIZE=10000
export SAVEHIST=1000

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable `checkwinsize` so that bash will check the terminal size when it
# regains control.
shopt -s checkwinsize

# Expand aliases for non-interactive shells.
shopt -s expand_aliases

# Disable file overwriting on redirect. Use `>` to overwrite.
set -o noclobber

# ==============================================================================
#                                                                              #
#                              ENVIRONMENT VARIABLES                             #
#                                                                              #
# ==============================================================================

# ------------------------------------------------------------------------------
# Path Configuration
# ------------------------------------------------------------------------------
#
# We use a helper function to add directories to the PATH only if they exist
# and are not already in the PATH. This keeps the PATH clean and efficient.

_add_to_path() {
	if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
		export PATH="$1:$PATH"
	fi
}

_add_to_path_suffix() {
	if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
		export PATH="$PATH:$1"
	fi
}

# Core utilities and user-specific bins
_add_to_path "$HOME/.bin"
_add_to_path "$HOME/.local/bin"
_add_to_path "/usr/local/go/bin"
_add_to_path "/var/lib/snapd/snap/bin"

# Bun
export BUN_INSTALL="$HOME/.bun"
_add_to_path "$BUN_INSTALL/bin"

# NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
	# shellcheck source=/dev/null
	. "$NVM_DIR/nvm.sh"
fi

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
_add_to_path "$PNPM_HOME"

# Rust/Cargo
if [ -f "$HOME/.cargo/env" ]; then
	# shellcheck source=/dev/null
	. "$HOME/.cargo/env"
	_add_to_path "$HOME/.cargo/bin"
fi

# Turso
_add_to_path "$HOME/.turso"

# Nix
if [ -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
	# shellcheck source=/dev/null
	. "$HOME/.nix-profile/etc/profile.d/nix.sh"
fi

# Homebrew (macOS)
if [[ "$(uname)" == "Darwin" ]] && [ -x "/opt/homebrew/bin/brew" ]; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# ------------------------------------------------------------------------------
# Editor Configuration
# ------------------------------------------------------------------------------

# Set the preferred editor for local and remote sessions.
if [[ -n $SSH_CONNECTION ]]; then
	export EDITOR='nano'
else
	export EDITOR='nano'
fi

# ------------------------------------------------------------------------------
# Telemetry and Analytics Opt-Out
# ------------------------------------------------------------------------------
#
# This section disables telemetry and data collection for a wide range of
# command-line tools and services.

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

# ------------------------------------------------------------------------------
# Miscellaneous Environment Variables
# ------------------------------------------------------------------------------

export AWS_CLI_AUTO_PROMPT=on-partial
export ARCHFLAGS="-arch x86_64"
export BASH_SILENCE_DEPRECATION_WARNING=1

# ==============================================================================
#                                                                              #
#                         ALIASES AND FUNCTIONS                                  #
#                                                                              #
# ==============================================================================

# ------------------------------------------------------------------------------
# General Aliases
# ------------------------------------------------------------------------------

alias ls='ls --color=auto'
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'
alias cp='cp -i'
alias df='df -h'
alias free='free -m'
alias more='less'
alias gs='git status'
alias ecommit='git commit -m "chore: minor changes"'
alias sync='git pull && git push'

# ------------------------------------------------------------------------------
# Utility Functions
# ------------------------------------------------------------------------------

colors() {
	local fgc bgc vals seq0
	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"
	for fgc in {30..37}; do
		for bgc in {40..47}; do
			fgc=${fgc#37}
			bgc=${bgc#40}
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

# ==============================================================================
#                                                                              #
#                                PROMPT & APPEARANCE                             #
#                                                                              #
# ==============================================================================

# ------------------------------------------------------------------------------
# Window Title
# ------------------------------------------------------------------------------

case ${TERM} in
xterm* | rxvt* | Eterm* | aterm | kterm | gnome* | interix | konsole*)
	PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
	;;
screen*)
	PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
	;;
esac

# ------------------------------------------------------------------------------
# Colorized Prompt (PS1)
# ------------------------------------------------------------------------------

use_color=true
safe_term=${TERM//[^[:alnum:]]/?}
match_lhs=""
if [ -f ~/.dir_colors ]; then
	match_lhs="${match_lhs}$(<~/.dir_colors)"
fi
if [ -f /etc/DIR_COLORS ]; then
	match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
fi
if [ -z "${match_lhs}" ] && type -P dircolors >/dev/null; then
	match_lhs=$(dircolors --print-database)
fi
if [[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]]; then
	use_color=true
fi

if ${use_color}; then
	if type -P dircolors >/dev/null; then
		if [ -f ~/.dir_colors ]; then
			# shellcheck disable=SC2046
			eval "$(dircolors -b ~/.dir_colors)"
		elif [ -f /etc/DIR_COLORS ]; then
			# shellcheck disable=SC2046
			eval "$(dircolors -b /etc/DIR_COLORS)"
		fi
	fi
	if [[ ${EUID} == 0 ]]; then
		PS1='\[\033[01;31m\][\h\[\033[01;36m\] \W\[\033[01;31m\]]\$\[\033[00m\] '
	else
		PS1='\[\033[01;32m\][\u@\h\[\033[01;37m\] \W\[\033[01;32m\]]\$\[\033[00m\] '
	fi
else
	if [[ ${EUID} == 0 ]]; then
		PS1='\u@\h \W \$ '
	else
		PS1='\u@\h \w \$ '
	fi
fi
unset use_color safe_term match_lhs

# ==============================================================================
#                                                                              #
#                           FRAMEWORKS & PLUGINS                                 #
#                                                                              #
# ==============================================================================

# ------------------------------------------------------------------------------
# Oh My Bash
# ------------------------------------------------------------------------------

export OSH=~/Bash
if [ -d "$OSH" ]; then
	# shellcheck disable=SC2034
	OSH_THEME="half-life"
	# shellcheck disable=SC2034
	DISABLE_AUTO_UPDATE="true"
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
	# shellcheck disable=SC2034
	completions=(composer defaults dirs docker docker-compose gh git npm pip pip3 ssh terraform)
	# shellcheck disable=SC2034
	aliases=(general)
	# shellcheck disable=SC2034
	plugins=(git bashmarks npm progress)
	if [ -f "$OSH/oh-my-bash.sh" ]; then
		# shellcheck source=/dev/null
		. "$OSH/oh-my-bash.sh"
	fi
fi

# ------------------------------------------------------------------------------
# Bash Completion
# ------------------------------------------------------------------------------

if [ -f /usr/share/bash-completion/bash_completion ]; then
	# shellcheck source=/dev/null
	. /usr/share/bash-completion/bash_completion
fi
if [ -f "$HOME/.config/Completion/bash_completion" ]; then
	# shellcheck source=/dev/null
	. "$HOME/.config/Completion/bash_completion"
fi
if [ -f "$NVM_DIR/bash_completion" ]; then
	# shellcheck source=/dev/null
	. "$NVM_DIR/bash_completion"
fi

# ------------------------------------------------------------------------------
# Other Tools
# ------------------------------------------------------------------------------

# envman
if [ -s "$HOME/.config/envman/load.sh" ]; then
	# shellcheck source=/dev/null
	source "$HOME/.config/envman/load.sh"
fi

# fzf
if [ -f ~/.fzf.bash ]; then
	# shellcheck source=/dev/null
	source ~/.fzf.bash
fi

# ==============================================================================
#                                                                              #
#                         CUSTOM & LOCAL CONFIGURATIONS                          #
#                                                                              #
# ==============================================================================

# Source custom aliases and functions if they exist.
if [ -f ~/.aliases ]; then
	# shellcheck source=/dev/null
	. ~/.aliases
fi
if [ -f ~/.functions ]; then
	# shellcheck source=/dev/null
	. ~/.functions
fi

# ------------------------------------------------------------------------------
# Miscellaneous & Final Touches
# ------------------------------------------------------------------------------

# Allow `xhost` to connect from local root. Be cautious with this setting.
xhost +local:root >/dev/null 2>&1

# Pre-execution hooks for bash
if [ -f ~/.bash-preexec.sh ]; then
	# shellcheck source=/dev/null
	. ~/.bash-preexec.sh
fi

# Grit
if [ -f "$HOME/.grit/bin/env" ]; then
	# shellcheck source=/dev/null
	. "$HOME/.grit/bin/env"
fi

# macOS Specific
if [[ "$(uname)" == "Darwin" ]]; then
	if [ -f "/Volumes/CORSAIR/Tool/macOS/rust/cargo/env" ]; then
		# shellcheck source=/dev/null
		. "/Volumes/CORSAIR/Tool/macOS/rust/cargo/env"
	fi
	_add_to_path "/Volumes/CORSAIR/Tool/macOS/rust/cargo/bin"
fi

# shellcheck disable=SC1090
[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path bash)"

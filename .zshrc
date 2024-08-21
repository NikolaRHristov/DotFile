if [ -f ${WSLENV+} ]; then
	export PATH="$PATH:$HOME/.config/xclip"
fi

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
export DO_NOT_TRACK=1
export PATH=$PATH:/usr/local/go/bin

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

export ZSH="$HOME/ZSH"
ZSH_THEME="half-life"

HYPHEN_INSENSITIVE="true"

zstyle ':omz:update' mode auto # update automatically without asking

zstyle ':omz:update' frequency 1

ENABLE_CORRECTION="true"

COMPLETION_WAITING_DOTS="true"

plugins=(
	composer
	docker
	docker-compose
	gh
	git
	npm
	pip
)

source $ZSH/oh-my-zsh.sh

export MANPATH="/usr/local/man:$MANPATH"
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
	export EDITOR='nano'
else
	export EDITOR='nano'
fi

export ARCHFLAGS="-arch x86_64"

# shellcheck disable=SC1091
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

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

# Turso
export PATH="$HOME/.turso:$PATH"
GPG_TTY=$(tty)
export GPG_TTY
export GPG_AGENT_INFO

export RUSTC_WRAPPER=sccache

# shopt -s histappend
HISTFILESIZE=10000

# Set history file
HISTFILE="$HOME/.zsh_history_shared"

# Set history size
HISTSIZE=10000
SAVEHIST=10000

# Share history across multiple zsh sessions
setopt SHARE_HISTORY

# Append to history
setopt APPEND_HISTORY

# Add commands as they are typed, don't wait until shell exits
setopt INC_APPEND_HISTORY

# Expire duplicate entries first when trimming history
setopt HIST_EXPIRE_DUPS_FIRST

# Don't record an entry that was just recorded again
setopt HIST_IGNORE_DUPS

# Delete old recorded entry if new entry is a duplicate
setopt HIST_IGNORE_ALL_DUPS

# Don't record an entry starting with a space
setopt HIST_IGNORE_SPACE

# Don't write duplicate entries in the history file
setopt HIST_SAVE_NO_DUPS

# Remove superfluous blanks before recording entry
setopt HIST_REDUCE_BLANKS

unsetopt correct
unsetopt correct_all

# shellcheck disable=SC1091
[ -f "$HOME/.grit/bin/env" ] && . "$HOME/.grit/bin/env"

export PATH="/var/lib/snapd/snap/bin:$PATH"
export PATH="$HOME/Tool/Global/PNPM:$PATH"

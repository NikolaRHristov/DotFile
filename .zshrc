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
HISTFILE="$HOME/.zsh_history_shared"
HISTSIZE=1000
HISTFILESIZE=10000
SAVEHIST=1000

# eval "$(atuin init zsh)"

unsetopt correct
unsetopt correct_all

. "$HOME/.grit/bin/env"

export PATH="/var/lib/snapd/snap/bin:$PATH"
export PATH="$HOME/Tool/Global/PNPM:$PATH"

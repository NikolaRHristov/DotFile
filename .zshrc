# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/nikola/.zshrc'

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
    terraform
)

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='nvim'
else
    export EDITOR='nvim'
fi

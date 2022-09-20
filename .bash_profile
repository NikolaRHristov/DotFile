#!/usr/bin/env bash

if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

export DO_NOT_TRACK=1
export GPG_TTY=$(tty)
export PATH=$PATH:/usr/local/go/bin

if [[ $PS1 && -f ~/.config/bash-completion/bash_completion ]]; then
	. ~/.config/bash-completion/bash_completion
fi

if [[ $PS1 && -f /usr/share/bash-completion/bash_completion ]]; then
	. /usr/share/bash-completion/bash_completion
fi

if [ -f ~/.aliases ]; then
	. ~/.aliases
fi

if [ -f ~/.functions ]; then
	. ~/.functions
fi

if [ -f "$HOME/.cargo/env" ]; then
	. "$HOME/.cargo/env"
fi

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export NVM_DIR="$HOME/.nvm"

if [ -f "$NVM_DIR/nvm.sh" ]; then
	. "$NVM_DIR/nvm.sh"
fi

if [ -f "$NVM_DIR/bash_completion" ]; then
	. "$NVM_DIR/bash_completion"
fi

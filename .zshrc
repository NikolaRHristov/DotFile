# ~/.zshrc
#
# A restructured and well-documented Zsh configuration file.
# This file handles environment variables, path management, aliases, plugins,
# and shell behavior for a powerful and productive command-line experience.

#==============================================================================
# SECTION 1: ENVIRONMENT & PATH CONFIGURATION
#==============================================================================

# --- Core PATH Definitions ---
export BUN_INSTALL="$HOME/.bun"
export PNPM_HOME="$HOME/Library/pnpm"
export NVM_DIR="$HOME/.nvm"
export CARGO_HOME="$HOME/.cargo"

# Prepend tool paths to the system PATH. Order is important.
export PATH="$CARGO_HOME/bin:$HOME/.bin:$BUN_INSTALL/bin:$PNPM_HOME:$HOME/.turso:$PATH"
export PATH="$PATH:/usr/local/go/bin"
export PATH="/var/lib/snapd/snap/bin:$PATH"

# --- Essential Environment Variables ---
export LANG="en_US.UTF-8"
export EDITOR='nano'
export ZSH="$HOME/ZSH" # Your Oh My Zsh installation directory
export GPG_TTY=$(tty)
export RUSTC_WRAPPER=sccache
export AWS_CLI_AUTO_PROMPT=on-partial

# --- Telemetry Opt-Out ---
# A comprehensive list to disable data collection from various CLI tools.
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

#==============================================================================
# SECTION 2: OH MY ZSH (OMZ) FRAMEWORK
#==============================================================================

ZSH_THEME="half-life"
zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 1
HYPHEN_INSENSITIVE="true"

# --- OMZ Plugins ---
plugins=(
    git gh brew zoxide fzf sudo thefuck history-substring-search vi-mode aliases
    mise
    composer pip rust node npm yarn bun deno
    docker docker-compose kubectl helm terraform aws
    eza httpie vscode
)

# --- Source Oh My Zsh ---
source "$ZSH/oh-my-zsh.sh"

#==============================================================================
# SECTION 3: SHELL BEHAVIOR & KEYBINDINGS
#==============================================================================

# --- Keybinding Fix for Word-Wise Navigation ---
bindkey '^[b' backward-word
bindkey '^[f' forward-word
bindkey '^[[1;5C' forward-word  # For CTRL+Right
bindkey '^[[1;5D' backward-word # For CTRL+Left

# --- History Configuration ---
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY APPEND_HISTORY INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS HIST_IGNORE_ALL_DUPS HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_SPACE HIST_REDUCE_BLANKS

# --- Disable Zsh's default auto-correction ---
unsetopt correct
unsetopt correct_all

#==============================================================================
# SECTION 4: TOOL, COMPLETION & PLUGIN INITIALIZATION
#==============================================================================

# --- Homebrew-managed Zsh Extensions ---
if type brew &>/dev/null; then
    FPATH="$(brew --prefix)/share/zsh-completions:$FPATH"
fi
FPATH="$HOME/.docker/completions:$FPATH"

if [ -f "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
    source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi
if [ -f "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
    source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# --- Other Tool Initializations ---
[[ -s "$NVM_DIR/nvm.sh" ]] && . "$NVM_DIR/nvm.sh"
eval "$(mise activate zsh)"
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
[ -f "$HOME/.grit/bin/env" ] && . "$HOME/.grit/bin/env"
source '/opt/homebrew/opt/autoenv/activate.sh'

#==============================================================================
# SECTION 5: COMPLETION SYSTEM & CUSTOM SCRIPTS
#==============================================================================

# --- Initialize Completion System ---
# This block must come after all FPATH modifications.
# The `-u` and `-i` flags prevent insecure directory warnings.
if [[ -z "$__COMPINIT_DONE" ]]; then
    autoload -Uz compinit
    compinit -u -i
    __COMPINIT_DONE=1
fi

# --- Load Custom User Scripts ---
[[ -f ~/.aliases ]] && . ~/.aliases
[[ -f ~/.functions ]] && . ~/.functions

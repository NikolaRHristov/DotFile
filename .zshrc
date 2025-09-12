# ==============================================================================
#
#              ███████╗███████╗██╗  ██╗██████╗  ██████╗███████╗
#              ╚══███╔╝██╔════╝██║  ██║██╔══██╗██╔════╝██╔════╝
#                ███╔╝ ███████╗███████║██████╔╝██║     ███████╗
#               ███╔╝  ╚════██║██╔══██║██╔══██╗██║     ╚════██║
#              ███████╗███████║██║  ██║██║  ██║╚██████╗███████║
#              ╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚══════╝
#
# ~/.zshrc: Executed by zsh(1) for interactive shells.
#
# This configuration file is structured to be modular, readable, and efficient.
# It handles environment variables, path management, aliases, plugins, and
# shell behavior for a powerful and productive command-line experience.
#
# ==============================================================================
#
#                           TODO: Future Improvements
#
# ==============================================================================
#
# - [ ] **Plugin Management:** For even faster startup times, consider a
#       plugin manager like `zinit` or `sheldon` that supports lazy-loading.
#
# - [ ] **Explore Modern Tools:**
#   - **`atuin`**: A powerful replacement for shell history (`Ctrl+R`).
#   - **`starship`**: A minimal, fast, and highly customizable prompt.
#
# - [ ] **Review Aliases:** Periodically review and prune aliases defined in
#       `~/.aliases` to keep them relevant to your current workflow.
#
# ==============================================================================
#
#                    SECTION 1: ENVIRONMENT & PATH CONFIGURATION
#
# ==============================================================================

# --- Tool-Specific Environment Variables ---
# Define home directories for various development tools first.
export NVM_DIR="$HOME/.nvm"
export BUN_INSTALL="$HOME/.bun"
export CARGO_HOME="$HOME/.cargo"
export PNPM_HOME="$HOME/Library/pnpm" # As per pnpm's default on macOS
export ZSH="$HOME/ZSH"                # Oh My Zsh installation directory

# --- General Environment Variables ---
export LANG="en_US.UTF-8"
export EDITOR='nano'
export GPG_TTY=$(tty)
export RUSTC_WRAPPER="sccache"
export AWS_CLI_AUTO_PROMPT="on-partial"

# --- macOS & Homebrew Specifics ---
# Set custom Homebrew Cask directories based on your history.
export HOMEBREW_CASK_OPTS="--appdir=/Volumes/CORSAIR/Application --caskroom=/Volumes/CORSAIR/Room/Cask"

# --- PATH Management ---
# Use Zsh's `path` array for cleaner and safer PATH management.
# This automatically prevents duplicate entries.
# Note: Oh My Zsh and other tools may further modify the path.
typeset -U path
path=(
	# User-specific binaries
	"$HOME/.bin"
	"$HOME/.local/bin"

	# Tool binaries (order can matter)
	"$CARGO_HOME/bin"
	"$BUN_INSTALL/bin"
	"$PNPM_HOME"
	"$HOME/.turso"

	# System-level binaries
	"/usr/local/go/bin"
	"/var/lib/snapd/snap/bin"

	# Existing system path
	$path
)

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

# ==============================================================================
#
#                       SECTION 2: OH MY ZSH FRAMEWORK
#
# ==============================================================================

# --- Oh My Zsh Configuration ---
# Set theme, update settings, and other OMZ-specific variables.
ZSH_THEME="half-life"
zstyle ':omz:update' mode auto   # Enable auto-updates
zstyle ':omz:update' frequency 1 # Check for updates daily
HYPHEN_INSENSITIVE="true"        # Treat hyphens and underscores as equivalent

# --- Oh My Zsh Plugins ---
# List all the plugins you want to load.
plugins=(
	# Core & Productivity
	git
	gh
	brew
	zoxide
	fzf
	sudo
	thefuck
	history-substring-search
	aliases # Enables the 'aliases' command to list all active aliases

	# Language & Version Managers
	mise
	composer
	pip
	rust
	node
	npm
	yarn
	bun
	deno

	# DevOps & Cloud
	docker
	docker-compose
	kubectl
	helm
	terraform
	aws

	# Utilities & Tools
	eza
	httpie
	vscode
)

# --- Source Oh My Zsh ---
# This line must be present to load the framework.
if [ -f "$ZSH/oh-my-zsh.sh" ]; then
	source "$ZSH/oh-my-zsh.sh"
else
	echo "Error: Oh My Zsh not found at '$ZSH'"
fi

# ==============================================================================
#
#                     SECTION 3: SHELL BEHAVIOR & OPTIONS
#
# ==============================================================================

# --- History Configuration ---
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY         # Append to history file, don't overwrite
setopt SHARE_HISTORY          # Share history between all sessions
setopt INC_APPEND_HISTORY     # Append commands to history immediately
setopt HIST_IGNORE_DUPS       # Don't record duplicate commands
setopt HIST_IGNORE_ALL_DUPS   # If a new command is a duplicate, remove the older one
setopt HIST_EXPIRE_DUPS_FIRST # Prioritize expiring duplicate entries
setopt HIST_IGNORE_SPACE      # Don't record commands starting with a space
setopt HIST_REDUCE_BLANKS     # Remove superfluous blanks from commands

# --- Keybindings ---
# Fix for word-wise navigation (Ctrl + Left/Right Arrow).
bindkey '^[b' backward-word
bindkey '^[f' forward-word
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

# --- Disable Zsh's default auto-correction ---
unsetopt correct
unsetopt correct_all

# ==============================================================================
#
#                SECTION 4: TOOL, COMPLETION & PLUGIN INITIALIZATION
#
# ==============================================================================

# --- Tool Initializations ---
# Load scripts and activate environments for specific command-line tools.

# NVM (Node Version Manager) - Load it lazily for better performance.
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# mise (polyglot version manager)
eval "$(mise activate zsh)"

# zoxide (smarter cd)
eval "$(zoxide init zsh)"

# thefuck (corrects previous command)
eval "$(thefuck --alias)"

# autoenv (directory-based environments)
if [ -f "$(brew --prefix autoenv)/activate.sh" ]; then
	source "$(brew --prefix autoenv)/activate.sh"
fi

# fzf (fuzzy finder) - Keybindings and completions.
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# --- Third-Party Completions & Plugins ---
# These are managed by Homebrew and sourced manually if not handled by a plugin manager.

if type brew &>/dev/null; then
	# Add Homebrew's completion directory to FPATH.
	FPATH="$(brew --prefix)/share/zsh-completions:$FPATH"

	# zsh-autosuggestions
	if [ -f "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
		source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
	fi

	# zsh-syntax-highlighting
	if [ -f "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
		source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
	fi
fi

# Add Docker's completion directory to FPATH.
FPATH="$HOME/.docker/completions:$FPATH"

# ==============================================================================
#
#                   SECTION 5: COMPLETION SYSTEM & CUSTOM SCRIPTS
#
# ==============================================================================

# --- Initialize Zsh Completion System ---
# This block must come *after* all FPATH modifications have been made.
# The `-u` and `-i` flags prevent insecure directory warnings.
autoload -Uz compinit
compinit -u -i

# --- Load Custom User Scripts ---
# Source personal aliases, functions, and environment variables last
# to ensure they take precedence.
[[ -f ~/.aliases ]] && . ~/.aliases
[[ -f ~/.functions ]] && . ~/.functions
if [ -f "$HOME/.local/bin/env" ]; then
	. "$HOME/.local/bin/env"
fi

# --- Load envman ---
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# --- Load Grit ---
[ -f "$HOME/.grit/bin/env" ] && . "$HOME/.grit/bin/env"

# --- Load ZSH Profile ---
[ -f "$HOME/.zsh_profile" ] && . "$HOME/.zsh_profile"

# --- Load ENV ---
[ -f "$HOME/.envsh" ] && . "$HOME/.envsh"

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
# - [ ] **Plugin Management:** Consider `zinit` or `sheldon` for lazy-loading.
# - [ ] **Explore Modern Tools:** `atuin` for history, `starship` for prompt.
# - [ ] **Review Aliases:** Periodically prune `~/.aliases`.
#
# ==============================================================================
#
#                    SECTION 0: FAST EXIT FOR PROGRAMMATIC SHELLS
#
# ==============================================================================
# When apps like PostHog Code, VS Code, or any program call `zsh -ilc '...'`
# to resolve the shell environment, they only need PATH and env vars — not OMZ,
# plugins, completions, thefuck, NVM, etc. Loading the full config takes >5s
# and causes a recursive zombie process chain (fixPath.ts timeout → orphans).
#
# Detection: if no TTY is attached, this is a programmatic invocation.
# We load only env vars + PATH and return immediately.

if [[ ! -o interactive ]] || [[ ! -t 0 ]]; then
	# Load env vars and PATH only
	[ -f "$HOME/.envsh" ] && . "$HOME/.envsh"
	[ -f "$HOME/.privateenvsh" ] && . "$HOME/.privateenvsh"

	# Minimal PATH setup (no brew shellenv — it's slow)
	typeset -U path
	path=(
		"$HOME/.bin"
		"$HOME/.local/bin"
		"$CARGO_HOME/bin"
		"$BUN_INSTALL/bin"
		"$PNPM_HOME"
		"/opt/homebrew/bin"
		"/opt/homebrew/sbin"
		"/usr/local/bin"
		$path
	)

	# NVM — export dir but don't load the full script (it runs node -v)
	export NVM_DIR="/Volumes/CORSAIR/Tool/NVM"
	[ -d "$NVM_DIR/versions/node" ] && {
		# Find the default node version directory and add it to PATH directly
		local default_node="$NVM_DIR/alias/default"
		if [ -f "$default_node" ]; then
			local ver=$(cat "$default_node")
			[ -d "$NVM_DIR/versions/node/v$ver/bin" ] && path=("$NVM_DIR/versions/node/v$ver/bin" $path)
		fi
		# Fallback: use the latest installed version
		local latest=$(ls -v "$NVM_DIR/versions/node/" 2>/dev/null | tail -1)
		[ -d "$NVM_DIR/versions/node/$latest/bin" ] && path=("$NVM_DIR/versions/node/$latest/bin" $path)
	}

	export PNPM_HOME="/Volumes/CORSAIR/Tool/macOS/pnpm/global"
	export GIT_DISCOVERY_ACROSS_FILESYSTEM=1
	export PATH="$HOME/.composer/vendor/bin:$HOME/.antigravity/antigravity/bin:$HOME/.actual/bin:$PATH"
	export CEF_PATH="$HOME/.local/share/cef"

	return 0
fi

# ==============================================================================
#
#                    SECTION 1: ENVIRONMENT & PATH CONFIGURATION
#
# ==============================================================================

# --- Load Custom Environment Variables ---
# This sets all our base paths (like $CORSAIR, $HOMEBREW_PREFIX) BEFORE any
# tools are initialized. This is the most important step.
[ -f "$HOME/.envsh" ] && . "$HOME/.envsh"
[ -f "$HOME/.privateenvsh" ] && . "$HOME/.privateenvsh"

# --- Initialize Homebrew Environment ---
# If Homebrew is installed at a custom location (as defined by $HOMEBREW_PREFIX),
# this is the OFFICIAL and safest way to add it to the shell's environment.
# This command sets the PATH and other variables needed for Homebrew to work.
if [ -f "${HOMEBREW_PREFIX}/bin/brew" ]; then
	eval "$(${HOMEBREW_PREFIX}/bin/brew shellenv)"
fi

# --- PATH Management ---
# Use Zsh's `path` array to prevent duplicate entries.
# We no longer manually define the whole path here. Instead, we let tools like
# Homebrew (above) add their own paths.
typeset -U path
path=(
	# Add your personal/local bin directories first to give them priority.
	"$HOME/.bin"
	"$HOME/.local/bin"

	# Add paths from our custom variables defined in .envsh
	"$CARGO_HOME/bin"
	"$BUN_INSTALL/bin"
	"$PNPM_HOME"

	# Keep the existing system path
	$path
)

# --- Telemetry Opt-Out ---
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

# Dynamically set the theme based on the WEZTERM_THEME environment variable
# passed by the WezTerm configuration.
if [[ "$WEZTERM_THEME" == "light" ]]; then
	# Use a theme that is highly readable on light backgrounds.
	ZSH_THEME="ys"
else
	# Use the preferred theme for dark backgrounds.
	ZSH_THEME="ys"
fi

zstyle ':omz:update' mode auto   # Enable auto-updates
zstyle ':omz:update' frequency 1 # Check for updates daily
HYPHEN_INSENSITIVE="true"        # Treat hyphens and underscores as equivalent

# --- Oh My Zsh Plugins ---
# RECONFIGURATION NOTE:
# Removed 'node', 'npm', 'yarn', 'bun', and 'deno' plugins. The 'mise' plugin
# is a modern version manager that handles all of them, so the others were
# redundant and could cause conflicts.
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
	composer
	pip
	rust

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

	node
	npm
	yarn
	bun
	deno
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
setopt APPEND_HISTORY SHARE_HISTORY INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS HIST_IGNORE_ALL_DUPS HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_SPACE HIST_REDUCE_BLANKS

# --- Keybindings ---
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
# The order matters: initialize the version manager first.

# zoxide (smarter cd)
eval "$(zoxide init zsh)"

# thefuck (corrects previous command)
eval "$(thefuck --alias)"

# autoenv (directory-based environments)
[ -f "$(brew --prefix autoenv)/activate.sh" ] && source "$(brew --prefix autoenv)/activate.sh"

# fzf (fuzzy finder) - Keybindings and completions.
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# RECONFIGURATION NOTE: Removed NVM loader. `mise` is now the primary tool
# for managing Node.js versions. Keeping NVM would lead to conflicts.

# --- Third-Party Completions & Plugins ---
# These are managed by Homebrew and sourced manually if not handled by a plugin manager.
if type brew &>/dev/null; then
	FPATH="$(brew --prefix)/share/zsh-completions:$FPATH"

	# zsh-autosuggestions
	[ -f "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ] &&
		source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

	# zsh-syntax-highlighting
	[ -f "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] &&
		source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# Add Docker's completion directory to FPATH.
[ -d "$HOME/.docker/completions" ] && FPATH="$HOME/.docker/completions:$FPATH"

# ==============================================================================
#
#                   SECTION 5: COMPLETION SYSTEM & CUSTOM SCRIPTS
#
# ==============================================================================

# --- Initialize Zsh Completion System ---
# Must come *after* all FPATH modifications have been made.
autoload -Uz compinit
compinit -u -i

# --- Load Custom User Scripts ---
# Source personal aliases, functions, etc., last to ensure they take precedence.
[[ -f ~/.aliases ]] && . ~/.aliases
[[ -f ~/.functions ]] && . ~/.functions
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# --- Load Grit ---
[ -f "$HOME/.grit/bin/env" ] && . "$HOME/.grit/bin/env"

# --- Load ZSH Profile ---
[ -f "$HOME/.zsh_profile" ] && . "$HOME/.zsh_profile"

# --- Load ENV ---
[ -f "$HOME/.envsh" ] && . "$HOME/.envsh"
[ -f "$HOME/.privateenvsh" ] && . "$HOME/.privateenvsh"
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/nikola/.docker/completions $fpath)
autoload -Uz compinit
compinit -u
# End of Docker CLI completions

# Daytona completion (commented out until file exists)
# source /Users/nikola/.daytona.completion_script.zsh

[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code-insiders --locate-shell-integration-path zsh)"

# CEF Configuration for Tauri (added by setup-cef.sh)
export CEF_PATH="$HOME/.local/share/cef"
export DYLD_FALLBACK_LIBRARY_PATH="$DYLD_FALLBACK_LIBRARY_PATH:$CEF_PATH:$CEF_PATH/Chromium Embedded Framework.framework/Libraries"

# pnpm
export PNPM_HOME="/Volumes/CORSAIR/Tool/macOS/pnpm/global"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

export GIT_DISCOVERY_ACROSS_FILESYSTEM=1

export NVM_DIR="/Volumes/CORSAIR/Tool/NVM"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$HOME/.composer/vendor/bin:$PATH"
# export PATH="/Volumes/CORSAIR/Tool/Android/sdk/platform-tools:$PATH"

# Added by Antigravity
export PATH="/Users/nikola/.antigravity/antigravity/bin:$PATH"

# Added by Actual Computer installer
export PATH="$HOME/.actual/bin:$PATH"

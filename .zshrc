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
		# The alias file may contain just a major (e.g. "24") — resolve to full version
		local _nvm_resolved=""
		if [ -f "$NVM_DIR/alias/default" ]; then
			local _alias=$(cat "$NVM_DIR/alias/default")
			# Try exact match first (e.g. "24.13.0" → v24.13.0)
			if [ -d "$NVM_DIR/versions/node/v${_alias}/bin" ]; then
				_nvm_resolved="v${_alias}"
			else
				# Partial match: find latest version starting with this prefix
				_nvm_resolved=$(ls -1 "$NVM_DIR/versions/node/" 2>/dev/null | grep "^v${_alias}" | sed 's/^v//' | sort -t. -k1,1n -k2,2n -k3,3n | tail -1 | sed 's/^/v/')
			fi
		fi
		# Fallback: use the latest installed version (proper semver sort)
		[ -z "$_nvm_resolved" ] && \
			_nvm_resolved=$(ls -1 "$NVM_DIR/versions/node/" 2>/dev/null | sed 's/^v//' | sort -t. -k1,1n -k2,2n -k3,3n | tail -1 | sed 's/^/v/')
		[ -d "$NVM_DIR/versions/node/${_nvm_resolved}/bin" ] && path=("$NVM_DIR/versions/node/${_nvm_resolved}/bin" $path)
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
[ -f "$HOME/.envsh" ] && . "$HOME/.envsh"
[ -f "$HOME/.privateenvsh" ] && . "$HOME/.privateenvsh"

# --- Initialize Homebrew Environment ---
# Cache brew prefix to avoid repeated subprocess calls (~200ms each)
if [ -f "${HOMEBREW_PREFIX:-/opt/homebrew}/bin/brew" ]; then
	eval "$(${HOMEBREW_PREFIX:-/opt/homebrew}/bin/brew shellenv)"
fi

# Cache the brew prefix for later use (avoid repeated $(brew --prefix) calls)
_BREW_PREFIX="${HOMEBREW_PREFIX:-/opt/homebrew}"

# --- PATH Management ---
typeset -U path
path=(
	"$HOME/.bin"
	"$HOME/.local/bin"
	"$CARGO_HOME/bin"
	"$BUN_INSTALL/bin"
	"$PNPM_HOME"
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

# Theme
if [[ "$WEZTERM_THEME" == "light" ]]; then
	ZSH_THEME="ys"
else
	ZSH_THEME="ys"
fi

zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 1
HYPHEN_INSENSITIVE="true"

# --- Oh My Zsh Plugins ---
# NOTE: node/npm/yarn/bun/deno removed — they conflict with NVM/mise
# and spawn subshells that contribute to zombie chains.
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
	aliases

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
)

# --- Source Oh My Zsh ---
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

# zoxide (smarter cd)
eval "$(zoxide init zsh)"

# thefuck (corrects previous command)
eval "$(thefuck --alias)"

# autoenv (directory-based environments) — use cached prefix
[ -f "$_BREW_PREFIX/opt/autoenv/activate.sh" ] && source "$_BREW_PREFIX/opt/autoenv/activate.sh"

# fzf (fuzzy finder)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# --- Third-Party Completions & Plugins (using cached brew prefix) ---
FPATH="$_BREW_PREFIX/share/zsh-completions:$FPATH"

[ -f "$_BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ] &&
	source "$_BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

[ -f "$_BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] &&
	source "$_BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# Docker completions
[ -d "$HOME/.docker/completions" ] && FPATH="$HOME/.docker/completions:$FPATH"

# ==============================================================================
#
#                   SECTION 5: COMPLETION SYSTEM & CUSTOM SCRIPTS
#
# ==============================================================================

# --- Initialize Zsh Completion System ---
# Called ONCE after all FPATH modifications.
autoload -Uz compinit
compinit -u -i

# --- Load Custom User Scripts ---
[[ -f ~/.aliases ]] && . ~/.aliases
[[ -f ~/.functions ]] && . ~/.functions
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# --- Load Grit ---
[ -f "$HOME/.grit/bin/env" ] && . "$HOME/.grit/bin/env"

# --- Load ZSH Profile ---
[ -f "$HOME/.zsh_profile" ] && . "$HOME/.zsh_profile"

# --- Load ENV (final pass for overrides) ---
[ -f "$HOME/.envsh" ] && . "$HOME/.envsh"
[ -f "$HOME/.privateenvsh" ] && . "$HOME/.privateenvsh"

# --- VS Code shell integration ---
[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code-insiders --locate-shell-integration-path zsh)"

# --- CEF Configuration for Tauri ---
export CEF_PATH="$HOME/.local/share/cef"
export DYLD_FALLBACK_LIBRARY_PATH="$DYLD_FALLBACK_LIBRARY_PATH:$CEF_PATH:$CEF_PATH/Chromium Embedded Framework.framework/Libraries"

# --- pnpm ---
export PNPM_HOME="/Volumes/CORSAIR/Tool/macOS/pnpm/global"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

export GIT_DISCOVERY_ACROSS_FILESYSTEM=1

# --- NVM ---
# Load NVM lazily: set up the dir and PATH but defer full nvm.sh load
# until `nvm` is actually called. This prevents "node -v" zombie chains.
export NVM_DIR="/Volumes/CORSAIR/Tool/NVM"
# Add current default node to PATH directly (no subprocess)
# The alias file may contain just a major (e.g. "24") — resolve to full version
_nvm_resolved=""
if [ -f "$NVM_DIR/alias/default" ]; then
	_nvm_alias=$(cat "$NVM_DIR/alias/default")
	if [ -d "$NVM_DIR/versions/node/v${_nvm_alias}/bin" ]; then
		_nvm_resolved="v${_nvm_alias}"
	else
		_nvm_resolved=$(ls -1 "$NVM_DIR/versions/node/" 2>/dev/null | grep "^v${_nvm_alias}" | sed 's/^v//' | sort -t. -k1,1n -k2,2n -k3,3n | tail -1 | sed 's/^/v/')
	fi
	unset _nvm_alias
fi
[ -z "$_nvm_resolved" ] && \
	_nvm_resolved=$(ls -1 "$NVM_DIR/versions/node/" 2>/dev/null | sed 's/^v//' | sort -t. -k1,1n -k2,2n -k3,3n | tail -1 | sed 's/^/v/')
[ -d "$NVM_DIR/versions/node/${_nvm_resolved}/bin" ] && \
	export PATH="$NVM_DIR/versions/node/${_nvm_resolved}/bin:$PATH"
unset _nvm_resolved
# Lazy-load nvm on first use
nvm() {
	unfunction nvm 2>/dev/null
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
	[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
	nvm "$@"
}

# --- Additional PATH entries ---
export PATH="$HOME/.composer/vendor/bin:$PATH"
export PATH="$HOME/.antigravity/antigravity/bin:$PATH"
export PATH="$HOME/.actual/bin:$PATH"

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
# PostHog Code ≥ PR#1435 uses `zsh -lc` (login, non-interactive) so .zshrc is
# never loaded for its PATH resolution. It also sets POSTHOG_CODE_RESOLVING_ENVIRONMENT=1
# as a belt-and-suspenders signal - we fast-exit immediately if present.
#
# Legacy tools (some VS Code extensions, other editors) still use `zsh -ilc`
# (interactive login), which does load .zshrc. The TTY guard below handles
# those cases and keeps init time ~25ms instead of 5-8s.
#
# See: https://github.com/PostHog/code/pull/1435

# Belt-and-suspenders: PostHog Code sets this. .zshenv already handled it,
# but guard here too for any edge-case -ilc invocation.
[[ -n "$POSTHOG_CODE_RESOLVING_ENVIRONMENT" ]] && return 0

# Legacy tools (VS Code extensions, some editors) still use `zsh -ilc`.
# .zshenv already ran and set all vars/PATH - just bail out of the heavy
# interactive init (OMZ, plugins, completions) for these non-TTY callers.
if [[ ! -o interactive ]] || [[ ! -t 0 ]]; then
	return 0
fi

# ==============================================================================
#
#                    SECTION 1: ENVIRONMENT & PATH CONFIGURATION
#
# ==============================================================================
# NOTE: All env vars (CORSAIR, NVM_DIR, CARGO_HOME, telemetry opt-outs, PATH
# appends) are defined in ~/.envsh, sourced by ~/.zshenv on every invocation.
# Do not re-source it here — it would re-run GPG_TTY=$(tty) and other
# subprocesses. The zsh PATH array also lives in ~/.zshenv (typeset -U).

# --- Initialize Homebrew Environment ---
# Cache brew prefix to avoid repeated subprocess calls (~200ms each)
if [ -f "${HOMEBREW_PREFIX:-/opt/homebrew}/bin/brew" ]; then
	eval "$(${HOMEBREW_PREFIX:-/opt/homebrew}/bin/brew shellenv)"
fi

# Cache the brew prefix for later use (avoid repeated $(brew --prefix) calls)
_BREW_PREFIX="${HOMEBREW_PREFIX:-/opt/homebrew}"

# ==============================================================================
#
#                       SECTION 2: OH MY ZSH FRAMEWORK
#
# ==============================================================================

# Theme
ZSH_THEME="ys"

zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 1
HYPHEN_INSENSITIVE="true"

# --- Oh My Zsh Plugins ---
# NOTE: node/npm/yarn/bun/deno removed - they conflict with NVM/mise
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
	golang

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
	ripgrep
	git-lfs
	colored-man-pages
	encode64
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
HISTSIZE=100000
SAVEHIST=100000
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

# autoenv (directory-based environments) - use cached prefix
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

# --- VS Code shell integration ---
# Use known path instead of spawning code-insiders subprocess (~100ms)
if [[ "$TERM_PROGRAM" == "vscode" ]]; then
	_vscode_si="$HOME/.vscode-insiders/extensions/ms-vscode.vscode-insiders-*/shellIntegration-rc.zsh"
	# shellcheck disable=SC2086
	local _found=($_vscode_si(N[1]))
	if [[ -n "$_found" ]]; then
		source "$_found"
	else
		# Fallback: spawn the subprocess only if cached path doesn't exist
		. "$(code-insiders --locate-shell-integration-path zsh 2>/dev/null)" 2>/dev/null
	fi
fi

# --- NVM ---
# NVM_DIR is set in ~/.envsh. Load nvm lazily: defer full nvm.sh load
# until `nvm` is actually called. This prevents "node -v" zombie chains.
nvm() {
	unfunction nvm 2>/dev/null
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
	[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
	nvm "$@"
}

# Hermes completions
[ -d "$HOME/completions" ] && FPATH="$HOME/completions:$FPATH"
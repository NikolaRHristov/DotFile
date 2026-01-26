#!/usr/bin/env bash

# ==============================================================================
# macOS Dotfile Setup Script
#
# This script manages the setup of dotfiles for a macOS environment.
# It can install and remove configurations.
#
# Usage:
#   ./macos.sh install      - Creates symbolic links for all configurations.
#   ./macos.sh remove       - Deletes all created symbolic links.
#
# ==============================================================================

# The central location of your dotfiles repository
DOTFILE_REPO="$HOME/Developer/Application/NikolaRHristov/DotFile/"

# ---
# Display Usage Instructions
# ---
usage() {
    echo "macOS Dotfile Management Script"
    echo "---------------------------------"
    echo "Usage: $0 {install|remove}"
    echo
    echo "Commands:"
    echo "  install    Backs up existing files and creates new symbolic links."
    echo "  remove     Removes all symbolic links created by this script."
    echo
}

# ---
# Remove Existing Dotfile Configurations
# ---
remove_dotfiles() {
    echo "Removing all created dotfile symbolic links and configurations..."

    # List of files and directories to remove from the home directory
    targets=(
        ".aliases"
        ".envsh"
        ".bash_history_shared"
        ".bash_logout"
        ".bash_profile"
        ".bash-preexec.sh"
        ".bashrc"
        ".functions"
        ".gitconfig"
        ".gitmessage"
        ".zshrc"
        "biome.json"
        "prettier.config.js"
        "rome.json"
        "rustfmt.toml"
        "tailwind.config.js"
        ".config"    # Directory
        "Bash"       # Directory
        "PowerShell" # Directory
        "ZSH"        # Directory
    )

    for target in "${targets[@]}"; do
        if [ -e "$HOME/$target" ] || [ -L "$HOME/$target" ]; then
            echo "Removing ~/$target"
            # shellcheck disable=SC2115
            rm -rf "$HOME/$target"
        fi
    done

    echo
    echo "Cleanup complete."
}

# ---
# Install Dotfiles by Creating Symbolic Links
# ---
install_dotfiles() {
    # First, ask the user if they want to clean up old files
    read -p "This will overwrite existing configurations. Do you want to remove old files first? (y/n) " -n 1 -r
    echo # Move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        remove_dotfiles
    fi

    echo
    echo "Starting macOS dotfile setup..."
    echo "Dotfile source: $DOTFILE_REPO"

    if [ ! -d "$DOTFILE_REPO" ]; then
        echo "Error: Dotfiles repository not found at $DOTFILE_REPO"
        exit 1
    fi

    # Create necessary directories if they don't exist
    mkdir -p "$HOME/.config"
    mkdir -p "$HOME/Developer"

    # Create symbolic links using -s (symbolic), -f (force/overwrite), -n (no-dereference)
    echo "Linking shell configurations..."
    ln -sfn "$DOTFILE_REPO.aliases" ~/.aliases
    ln -sfn "$DOTFILE_REPO.envsh" ~/.envsh
    ln -sfn "$DOTFILE_REPO.bash_profile" ~/.bash_profile
    ln -sfn "$DOTFILE_REPO.bash_logout" ~/.bash_logout
    ln -sfn "$DOTFILE_REPO.bash_history_shared" ~/.bash_history_shared
    ln -sfn "$DOTFILE_REPO.zshrc" ~/.zshrc
    ln -sfn "$DOTFILE_REPO.bashrc" ~/.bashrc
    ln -sfn "$DOTFILE_REPO.functions" ~/.functions
    ln -sfn "$DOTFILE_REPO.bash-preexec.sh" ~/.bash-preexec.sh

    echo "Linking Git configuration..."
    # .gitconfig is copied so you can set a machine-specific user/email
    cp "$DOTFILE_REPO.gitconfig" ~/.gitconfig
    ln -sfn "$DOTFILE_REPO.gitmessage" ~/.gitmessage

    echo "Linking application configurations..."
    ln -sfn "$DOTFILE_REPO"prettier.config.mjs ~/prettier.config.mjs
    ln -sfn "$DOTFILE_REPO"rome.json ~/rome.json
    ln -sfn "$DOTFILE_REPO"biome.json ~/biome.json
    ln -sfn "$DOTFILE_REPO"rustfmt.toml ~/rustfmt.toml
    ln -sfn "$DOTFILE_REPO"tailwind.config.js ~/tailwind.config.js

    echo "Linking configuration directories..."
    ln -sfn "$DOTFILE_REPO.config" ~/.config
    ln -sfn "$DOTFILE_REPO"Bash ~/Bash
    ln -sfn "$DOTFILE_REPO"PowerShell ~/PowerShell
    ln -sfn "$DOTFILE_REPO"ZSH ~/ZSH

    echo "✅ macOS dotfile setup complete."
    echo "Please restart your terminal or run 'source ~/.zshrc' or 'source ~/.bash_profile'."
}

# ---
# Main Script Logic
# ---
case "$1" in
install)
    install_dotfiles
    ;;
remove)
    remove_dotfiles
    ;;
*)
    usage
    exit 1
    ;;
esac

exit 0

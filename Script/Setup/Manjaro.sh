#!/usr/bin/env bash

Current=$(\cd -- "$(\dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && \pwd)

# shellcheck disable=SC1091
# source "$Current/Fn/Remove.sh"

DOTFILE="/home/nikola/Developer/Application/NikolaRHristov/DotFile/"

mv ~/.gitconfig ~/.gitconfig.bak
mv ~/.aliases ~/.aliases.bak
mv ~/.bash_history_shared ~/.bash_history_shared.bak
mv ~/.bash_logout ~/.bash_logout.bak
mv ~/.bash_profile ~/.bash_profile.bak
mv ~/.bashrc ~/.bashrc.bak
mv ~/.functions ~/.functions.bak
mv ~/.gitmessage ~/.gitmessage.bak
mv ~/.zshrc ~/.zshrc.bak
mv ~/Bash ~/Bash.bak
mv ~/PowerShell ~/PowerShell.bak
mv ~/ZSH ~/ZSH.bak
mv ~/biome.json ~/biome.json.bak
mv ~/prettier.config.js ~/prettier.config.js.bak
mv ~/rome.json ~/rome.json.bak
mv ~/rustfmt.toml ~/rustfmt.toml.bak
mv ~/tailwind.config.js ~/tailwind.config.js.bak

cp "$DOTFILE".gitconfig ~/.gitconfig
ln -s "$DOTFILE".aliases ~/.aliases
ln -s "$DOTFILE".bash_history_shared ~/.bash_history_shared
ln -s "$DOTFILE".bash_logout ~/.bash_logout
ln -s "$DOTFILE".bash_profile ~/.bash_profile
ln -s "$DOTFILE".bashrc ~/.bashrc
ln -s "$DOTFILE".functions ~/.functions
ln -s "$DOTFILE".gitmessage ~/.gitmessage
ln -s "$DOTFILE".zshrc ~/.zshrc
ln -s "$DOTFILE"Bash ~/Bash
ln -s "$DOTFILE"PowerShell ~/PowerShell
ln -s "$DOTFILE"ZSH ~/ZSH
ln -s "$DOTFILE"Configuration/biome.json ~/biome.json
ln -s "$DOTFILE"Configuration/prettier.config.mjs ~/prettier.config.js
ln -s "$DOTFILE"Configuration/rome.json ~/rome.json
ln -s "$DOTFILE"Configuration/rustfmt.toml ~/rustfmt.toml
ln -s "$DOTFILE"Configuration/tailwind.config.js ~/tailwind.config.js

# rm ~/Developer/.clang-format
# rm ~/Developer/.csharpierrc
# rm ~/Developer/.editorconfig
# rm ~/Developer/.jshintrc
# rm ~/Developer/.npmrc
# rm ~/Developer/.prettierignore
# rm ~/Developer/.stylua.toml
# rm ~/Developer/biome.json
# rm ~/Developer/jsconfig.json
# rm ~/Developer/rome.json
# rm ~/Developer/rustfmt.toml
# rm ~/Developer/tsconfig.json

# ln -s "$DOTFILE".clang-format ~/Developer/.clang-format
# ln -s "$DOTFILE".csharpierrc ~/Developer/.csharpierrc
# ln -s "$DOTFILE".editorconfig ~/Developer/.editorconfig
# ln -s "$DOTFILE".jshintrc ~/Developer/.jshintrc
# ln -s "$DOTFILE".npmrc ~/Developer/.npmrc
# ln -s "$DOTFILE".prettierignore ~/Developer/.prettierignore
# ln -s "$DOTFILE".stylua.toml ~/Developer/.stylua.toml
# ln -s "$DOTFILE"biome.json ~/Developer/biome.json
# ln -s "$DOTFILE"jsconfig.json ~/Developer/jsconfig.json
# ln -s "$DOTFILE"rome.json ~/Developer/rome.json
# ln -s "$DOTFILE"rustfmt.toml ~/Developer/rustfmt.toml
# ln -s "$DOTFILE"tsconfig.json ~/Developer/tsconfig.json

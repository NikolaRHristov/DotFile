#!/bin/bash

DOTFILE="/media/sf_Developer/Application/NikolaRHristov/Dotfile/"

rm -rf ~/.aliases
rm -rf ~/.bash_profile
rm -rf ~/.bash_logout
rm -rf ~/.bash_history_shared
rm -rf ~/.bashrc
rm -rf ~/.zshrc
rm -rf ~/.config
rm -rf ~/.functions
rm -rf ~/.gitconfig
rm -rf ~/.gitmessage
rm -rf ~/Bash
rm -rf ~/Powershell
rm -rf ~/ZSH
rm -rf ~/prettier.config.js
rm -rf ~/rustfmt.toml
rm -rf ~/tailwind.config.js
rm -rf ~/rome.json
rm -rf ~/biome.json

ln -s "$DOTFILE".aliases ~/.aliases
ln -s "$DOTFILE".bash_profile ~/.bash_profile
ln -s "$DOTFILE".bash_logout ~/.bash_logout
ln -s "$DOTFILE".bash_history_shared ~/.bash_history_shared
ln -s "$DOTFILE".zshrc ~/.zshrc
ln -s "$DOTFILE".bashrc ~/.bashrc
ln -s "$DOTFILE".functions ~/.functions
cp "$DOTFILE".gitconfig ~/.gitconfig
ln -s "$DOTFILE".gitmessage ~/.gitmessage
ln -s "$DOTFILE"prettier.config.js ~/prettier.config.js
ln -s "$DOTFILE"rome.json ~/rome.json
ln -s "$DOTFILE"biome.json ~/biome.json
ln -s "$DOTFILE"rustfmt.toml ~/rustfmt.toml
ln -s "$DOTFILE"tailwind.config.js ~/tailwind.config.js
ln -s "$DOTFILE".config ~/.config
ln -s "$DOTFILE"Bash ~/Bash
ln -s "$DOTFILE"Powershell ~/Powershell
ln -s "$DOTFILE"ZSH ~/ZSH

rm ~/Developer/.clang-format
rm ~/Developer/.csharpierrc
rm ~/Developer/.editorconfig
rm ~/Developer/.jshintrc
rm ~/Developer/.npmrc
rm ~/Developer/.prettierignore
rm ~/Developer/.stylua.toml
rm ~/Developer/jsconfig.json
rm ~/Developer/rome.json
rm ~/Developer/biome.json
rm ~/Developer/rustfmt.toml
rm ~/Developer/tsconfig.json

ln -s "$DOTFILE".clang-format ~/Developer/.clang-format
ln -s "$DOTFILE".csharpierrc ~/Developer/.csharpierrc
ln -s "$DOTFILE".editorconfig ~/Developer/.editorconfig
ln -s "$DOTFILE".jshintrc ~/Developer/.jshintrc
ln -s "$DOTFILE".npmrc ~/Developer/.npmrc
ln -s "$DOTFILE".prettierignore ~/Developer/.prettierignore
ln -s "$DOTFILE".stylua.toml ~/Developer/.stylua.toml
ln -s "$DOTFILE"jsconfig.json ~/Developer/jsconfig.json
ln -s "$DOTFILE"rome.json ~/Developer/rome.json
ln -s "$DOTFILE"biome.json ~/Developer/biome.json
ln -s "$DOTFILE"rustfmt.toml ~/Developer/rustfmt.toml
ln -s "$DOTFILE"tsconfig.json ~/Developer/tsconfig.json

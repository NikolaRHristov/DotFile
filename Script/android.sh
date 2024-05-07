#!/bin/bash

DotFile="~/Developer/Application/NikolaRHristov/DotFile/"

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

cp "$DotFile".aliases ~/.aliases
cp "$DotFile".bash_profile ~/.bash_profile
cp "$DotFile".bash_logout ~/.bash_logout
cp "$DotFile".bash_history_shared ~/.bash_history_shared
cp "$DotFile".zshrc ~/.zshrc
cp "$DotFile".bashrc ~/.bashrc
cp "$DotFile".functions ~/.functions
cp "$DotFile".gitconfig ~/.gitconfig
cp "$DotFile".gitmessage ~/.gitmessage
cp "$DotFile"prettier.config.js ~/prettier.config.js
cp "$DotFile"rome.json ~/rome.json
cp "$DotFile"biome.json ~/biome.json
cp "$DotFile"rustfmt.toml ~/rustfmt.toml
cp "$DotFile"tailwind.config.js ~/tailwind.config.js
cp "$DotFile".config ~/.config
cp "$DotFile"Bash ~/Bash
cp "$DotFile"Powershell ~/Powershell
cp "$DotFile"ZSH ~/ZSH

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

ln -s "$DotFile".clang-format ~/Developer/.clang-format
ln -s "$DotFile".csharpierrc ~/Developer/.csharpierrc
ln -s "$DotFile".editorconfig ~/Developer/.editorconfig
ln -s "$DotFile".jshintrc ~/Developer/.jshintrc
ln -s "$DotFile".npmrc ~/Developer/.npmrc
ln -s "$DotFile".prettierignore ~/Developer/.prettierignore
ln -s "$DotFile".stylua.toml ~/Developer/.stylua.toml
ln -s "$DotFile"jsconfig.json ~/Developer/jsconfig.json
ln -s "$DotFile"rome.json ~/Developer/rome.json
ln -s "$DotFile"biome.json ~/Developer/biome.json
ln -s "$DotFile"rustfmt.toml ~/Developer/rustfmt.toml
ln -s "$DotFile"tsconfig.json ~/Developer/tsconfig.json

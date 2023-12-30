#!/bin/bash

DOTFILE="/media/sf_Developer/Application/NikolaRHristov/Dotfile/"

rm ~/.aliases
rm ~/.bash_profile
rm ~/.bash_logout
rm ~/.bash_history_shared
rm ~/.bashrc
rm ~/.zshrc
rm ~/.config
rm ~/.functions
rm ~/.gitconfig
rm ~/.gitmessage
rm ~/Bash
rm ~/Powershell
rm ~/ZSH
rm ~/prettier.config.js
rm ~/rustfmt.toml
rm ~/tailwind.config.js
rm ~/rome.json
rm ~/biome.json

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
ln -s ~/.config/nvim ~/AppData/Local/nvim

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

ln -s /media/sf_Developer/Application/NikolaRHristov/Dotfile/.clang-format ~/Developer/.clang-format
ln -s /media/sf_Developer/Application/NikolaRHristov/Dotfile/.csharpierrc ~/Developer/.csharpierrc
ln -s /media/sf_Developer/Application/NikolaRHristov/Dotfile/.editorconfig ~/Developer/.editorconfig
ln -s /media/sf_Developer/Application/NikolaRHristov/Dotfile/.jshintrc ~/Developer/.jshintrc
ln -s /media/sf_Developer/Application/NikolaRHristov/Dotfile/.npmrc ~/Developer/.npmrc
ln -s /media/sf_Developer/Application/NikolaRHristov/Dotfile/.prettierignore ~/Developer/.prettierignore
ln -s /media/sf_Developer/Application/NikolaRHristov/Dotfile/.stylua.toml ~/Developer/.stylua.toml
ln -s /media/sf_Developer/Application/NikolaRHristov/Dotfile/jsconfig.json ~/Developer/jsconfig.json
ln -s /media/sf_Developer/Application/NikolaRHristov/Dotfile/rome.json ~/Developer/rome.json
ln -s /media/sf_Developer/Application/NikolaRHristov/Dotfile/biome.json ~/Developer/biome.json
ln -s /media/sf_Developer/Application/NikolaRHristov/Dotfile/rustfmt.toml ~/Developer/rustfmt.toml
ln -s /media/sf_Developer/Application/NikolaRHristov/Dotfile/tsconfig.json ~/Developer/tsconfig.json

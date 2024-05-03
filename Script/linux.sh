#!/bin/bash

Home="/home/nikola/"
Developer="${Home}Developer/"
DotFile="${Developer}Application/NikolaRHristov/DotFile/"

rm -rf "${Home}.aliases"
rm -rf "${Home}.bash_profile"
rm -rf "${Home}.bash_logout"
rm -rf "${Home}.bash_history_shared"
rm -rf "${Home}.bashrc"
rm -rf "${Home}.zshrc"
rm -rf "${Home}.config"
rm -rf "${Home}.functions"
rm -rf "${Home}.gitconfig"
rm -rf "${Home}.gitmessage"
rm -rf "${Home}Bash"
rm -rf "${Home}PowerShell"
rm -rf "${Home}ZSH"
rm -rf "${Home}prettier.config.js"
rm -rf "${Home}rustfmt.toml"
rm -rf "${Home}tailwind.config.js"
rm -rf "${Home}rome.json"
rm -rf "${Home}biome.json"

ln -s "$DotFile".aliases "${Home}.aliases"
ln -s "$DotFile".bash_profile "${Home}.bash_profile"
ln -s "$DotFile".bash_logout "${Home}.bash_logout"
ln -s "$DotFile".bash_history_shared "${Home}.bash_history_shared"
ln -s "$DotFile".zshrc "${Home}.zshrc"
ln -s "$DotFile".bashrc "${Home}.bashrc"
ln -s "$DotFile".functions "${Home}.functions"
cp "${DotFile}.gitconfig" "${Home}.gitconfig"
ln -s "$DotFile".gitmessage "${Home}.gitmessage"
ln -s "$DotFile"prettier.config.js "${Home}prettier.config.js"
ln -s "$DotFile"rome.json "${Home}rome.json"
ln -s "$DotFile"biome.json "${Home}biome.json"
ln -s "$DotFile"rustfmt.toml "${Home}rustfmt.toml"
ln -s "$DotFile"tailwind.config.js "${Home}tailwind.config.js"
ln -s "$DotFile".config "${Home}.config"
ln -s "$DotFile"Bash "${Home}Bash"
ln -s "$DotFile"PowerShell "${Home}PowerShell"
ln -s "$DotFile"ZSH "${Home}ZSH"

rm -rf ${Developer}.clang-format
rm -rf ${Developer}.csharpierrc
rm -rf ${Developer}.editorconfig
rm -rf ${Developer}.jshintrc
rm -rf ${Developer}.npmrc
rm -rf ${Developer}.prettierignore
rm -rf ${Developer}.stylua.toml
rm -rf ${Developer}jsconfig.json
rm -rf ${Developer}rome.json
rm -rf ${Developer}biome.json
rm -rf ${Developer}rustfmt.toml
rm -rf ${Developer}tsconfig.json

ln -s "$DotFile".clang-format ${Developer}.clang-format
ln -s "$DotFile".csharpierrc ${Developer}.csharpierrc
ln -s "$DotFile".editorconfig ${Developer}.editorconfig
ln -s "$DotFile".jshintrc ${Developer}.jshintrc
ln -s "$DotFile".npmrc ${Developer}.npmrc
ln -s "$DotFile".prettierignore ${Developer}.prettierignore
ln -s "$DotFile".stylua.toml ${Developer}.stylua.toml
ln -s "$DotFile"jsconfig.json ${Developer}jsconfig.json
ln -s "$DotFile"rome.json ${Developer}rome.json
ln -s "$DotFile"biome.json ${Developer}biome.json
ln -s "$DotFile"rustfmt.toml ${Developer}rustfmt.toml
ln -s "$DotFile"tsconfig.json ${Developer}tsconfig.json

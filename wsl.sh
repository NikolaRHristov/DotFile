#!/bin/bash
rm -rf /root/.aliases
rm -rf /root/.bash_profile
rm -rf /root/.bashrc
rm -rf /root/.config
rm -rf /root/.functions
rm -rf /root/.gitconfig
rm -rf /root/.oh-my-bash
rm -rf /root/.oh-my-posh
rm -rf /root/.oh-my-zsh
rm -rf /root/.ssh
rm -rf /root/prettier.config.js
rm -rf /root/rustfmt.toml
rm -rf /root/tailwind.config.js
rm -rf /root/rome.json

ln -s /mnt/f/Developer/app/NikolaRHristov/dot/.aliases /root/.aliases
ln -s /mnt/f/Developer/app/NikolaRHristov/dot/.bash_profile /root/.bash_profile
ln -s /mnt/f/Developer/app/NikolaRHristov/dot/.bashrc /root/.bashrc
ln -s /mnt/f/Developer/app/NikolaRHristov/dot/.config /root/.config
ln -s /mnt/f/Developer/app/NikolaRHristov/dot/.functions /root/.functions
ln -s /mnt/f/Developer/app/NikolaRHristov/dot/.gitconfig /root/.gitconfig
ln -s /mnt/f/Developer/app/NikolaRHristov/dot/.oh-my-bash /root/.oh-my-bash
ln -s /mnt/f/Developer/app/NikolaRHristov/dot/.oh-my-posh /root/.oh-my-posh
ln -s /mnt/f/Developer/app/NikolaRHristov/dot/.oh-my-zsh /root/.oh-my-zsh

cp -rf /mnt/e/MEGA/PROJECTS/Personal/Credentials/Keys/SSH /root/.ssh
chmod 0400 /root/.ssh/*

ln -s /mnt/f/Developer/app/NikolaRHristov/dot/prettier.config.js /root/prettier.config.js
ln -s /mnt/f/Developer/app/NikolaRHristov/dot/rome.json /root/rome.json
ln -s /mnt/f/Developer/app/NikolaRHristov/dot/rustfmt.toml /root/rustfmt.toml
ln -s /mnt/f/Developer/app/NikolaRHristov/dot/tailwind.config.js /root/tailwind.config.js

#!/usr/bin/env bash

# WSL install script

# Fix: cannot create /var/lib/landscape/landscape-sysinfo.cache: Permission denied
# https://askubuntu.com/questions/1414483/landscape-sysinfo-cache-permission-denied-when-i-start-ubuntu-22-04-in-wsl
sudo apt remove -y landscape-common # Remove the package
sudo apt autoremove -y              # Remove orphaned packages
rm -rf ~/.landscape/                # Clean up, no longer used

# Update to latests and greatest
sudo apt update
sudo apt upgrade -y

# Install packages
sudo apt install -y git \
                    git-flow \
                    bash-completion \
                    bash-builtins \
                    powerline \
                    powerline-gitstatus \
                    dos2unix \

# Get Bash environment
git clone https://github.com/claesjaeger/bash_tools.git
git clone https://github.com/claesjaeger/bashlib.git

# Setup bash environment
mv .bashrc org_bashrc
mv .ssh org_ssh
ln -s bash_tools/.bashrc .bashrc
ln -s bash_tools/vim/.vimrc .vimrc
ln -s bash_tools/ssh/SGRE .ssh
ln -s ~/bash_tools/powerline .config/powerline

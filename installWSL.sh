#!/usr/bin/env bash

# WSL install script
CURRENTDIR=$(pwd)
cd ~

# Update to latests and greatest
sudo apt-get update
sudo apt-get upgrade -y

# Install packages
## graphviz is installed by plantUML
## util-linux should have column, but apprently that is in bsdmainutils
sudo apt-get install -y git \
                    git-flow \
                    bash-completion \
                    bash-builtins \
                    util-linux \
                    bsdmainutils \
                    powerline \
                    powerline-gitstatus \
                    dos2unix \
                    doxygen \
                    doxygen-gui \
                    mscgen \
                    python3-pip \

# Get Bash environment
git clone https://github.com/claesjaeger/bash_tools.git
git clone https://github.com/claesjaeger/bashlib.git


# PLANTUML
PLANTUML_FILE="plantuml_install.sh"
PLANTUML_SCRIPT="https://raw.githubusercontent.com/metanorma/plantuml-install/refs/heads/main/ubuntu.sh"
curl -o $PLANTUML_FILE  -L $PLANTUML_SCRIPT
chmod +x $PLANTUML_FILE
bash $PLANTUML_FILE
rm $PLANTUML_FILE

# Setup bash environment
mv .bashrc org_bashrc
mv .ssh org_ssh
ln -s bash_tools/.bashrc .bashrc
ln -s bash_tools/vim/.vimrc .vimrc
ln -s bash_tools/ssh/SGRE .ssh
ln -s ~/bash_tools/powerline .config/powerline

cd $CURRENTDIR

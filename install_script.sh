#!/usr/bin/env bash

# -----------private--------------------------
sudo add-apt-repository -y ppa:danielrichter2007/grub-customizer
sudo add-apt-repository -y ppa:jtaylor/keepass
sudo add-apt-repository -y ppa:openshot.developers/ppa

# Set time to use local-time so Ubuntu and windows can co-exists
# https://www.howtogeek.com/323390/how-to-fix-windows-and-linux-showing-different-times-when-dual-booting/
timedatectl set-local-rtc 1 --adjust-system-clock

sudo apt-get update
sudo apt-get upgrade -y
 
sudo apt-get install -y mono-complete \
			keepass2 \
			grub-customizer \
			xournal \
			geany \
			git \
			git-flow \
			meld \
			bash-completion \
			bash-builtins \
			mate-utils \
			curl \
			jq \
			terminator \
			putty \
			gtkterm \
			openshot-qt \
			pinta \
			gnome-tweaks \
			htop \
			powerline \
			powerline-gitstatus \
						

# https://forum.kee.pm/t/installing-kee-with-keepassrpc-for-keepass-password-safe-instructions/23
curl -s https://api.github.com/repos/kee-org/keepassrpc/releases/latest | jq -r ".assets[] | select(.name | test(\"KeePassRPC.plgx\")) | .browser_download_url" | xargs sudo curl -s -L -o "/usr/lib/keepass2/Plugins/KeePassRPC.plgx"
#wget https://github.com/kee-org/keepassrpc/releases/download/v1.9.0/KeePassRPC.plgx
#sudo mv KeePassRPC.plgx /usr/lib/keepass2/Plugins/

# bash-tools claes
git clone https://github.com/claesjaeger/bash_tools.git
git clone https://github.com/claesjaeger/bashlib.git

mv .bashrc org_bashrc
mv .ssh org_ssh
ln -s bash_tools/.bashrc .bashrc
ln -s bash_tools/vim/.vimrc .vimrc
ln -s bash_tools/ssh/Private .ssh
cd .config
ln -s ~/bash_tools/powerline powerline
                 





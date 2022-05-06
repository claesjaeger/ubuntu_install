#!/usr/bin/env bash

# -----------private--------------------------
#sudo add-apt-repository -y ppa:danielrichter2007/grub-customizer
#sudo add-apt-repository -y ppa:jtaylor/keepass
#sudo add-apt-repository -y ppa:openshot.developers/ppa

# Set time to use local-time so Ubuntu and windows can co-exists
# https://www.howtogeek.com/323390/how-to-fix-windows-and-linux-showing-different-times-when-dual-booting/
timedatectl set-local-rtc 1 --adjust-system-clock

sudo apt-get update
 
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
						

# https://forum.kee.pm/t/installing-kee-with-keepassrpc-for-keepass-password-safe-instructions/23
curl -s https://api.github.com/repos/kee-org/keepassrpc/releases/latest | jq -r ".assets[] | select(.name | test(\"KeePassRPC.plgx\")) | .browser_download_url" | xargs sudo curl -s -L -o "/usr/lib/keepass2/Plugins/KeePassRPC.plgx"
#wget https://github.com/kee-org/keepassrpc/releases/download/v1.9.0/KeePassRPC.plgx
#sudo mv KeePassRPC.plgx /usr/lib/keepass2/Plugins/

#wget https://downloads.slack-edge.com/linux_releases/slack-desktop-4.0.2-amd64.deb
#sudo apt-get install -y ./slack-desktop-*.deb
#rm slack-desktop-*.deb


# run this guide
#https://docs.google.com/document/d/1eESvpygRr0zT-MD2NPkzh30kqdcwkLM8BtZNxdL4gXc/edit#

#run bootstrap
#copy ssh-keys
#run bor cli

# bash-tools claes
#git clone git@github.com:claesjaeger/.bash_tools.git
                 





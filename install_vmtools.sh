#!/usr/bin/env bash
# @file install_wmtools.sh
# @brief Installs tools to run virtual machines with Vagrant and Packer
# @description
#     The scripts installs the current packages:
#      * Virtualbox
#      * Vagrant
#      * Packer
#      
#		Requirements - These are installed automatically if they are not present.
#		* git
#		* syslinux-utils
#		* unzip
#		* bash-builtins

RED="\033[0;31m"
GREEN="\033[0;32m"
RESET="\033[0m"


# Define spinner function for slow tasks
# courtesy of http://fitnr.com/showing-a-bash-spinner.html
spinner()
{
    local pid=$1
    local delay=0.75
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

# Check if the packages required for the installation is installed
# on the system.
check_package_installed()
{
        dpkg-query -s $1 > /dev/null 2>&1
        case $? in
        0)
            echo -e "${GREEN}$1 is installed$RESET"
            PKG_OK="ok"
            ;;
        1)
            echo -e "${RED}$1 is not installed$RESET"
            if [ $# -eq 1 ]; then
				PKG_OK=""
            else
				install_package $1
			fi
            ;;
        2)
            echo An error occurred
            ;;
        esac
}

install_package()
{
	echo "Installing "$1
	(sudo apt-get -y install $1 > /dev/null 2>&1) &
	spinner $!
}

update_repos()
{
	echo "Update repos..."
	(sudo apt-get update > /dev/null 2>&1) &
	spinner $!
}


# Get distro automatic
# https://unix.stackexchange.com/questions/6345/how-can-i-get-distribution-name-and-version-number-in-a-simple-shell-script
if [ -f /etc/os-release ]; then
    # freedesktop.org and systemd
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
    DISTRO=$UBUNTU_CODENAME
elif type lsb_release >/dev/null 2>&1; then
    # linuxbase.org
    OS=$(lsb_release -si)
    VER=$(lsb_release -sr)
    DISTRO=$(lsb_release -sr)
elif [ -f /etc/lsb-release ]; then
    # For some versions of Debian/Ubuntu without lsb_release command
    . /etc/lsb-release
    OS=$DISTRIB_ID
    VER=$DISTRIB_RELEASE
    DISTRO=$DISTRIB_CODENAME
else
    # Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
    OS="Ubuntu"
    VER="16.04"
    CODE="xenial"
fi

# Get arch
ARCH=$(arch)

echo "Values used in installation:"
echo "Operating system: "$OS
echo "Version: "$VER
echo "Distribution: "$DISTRO
echo "Arch: "$ARCH
echo ""

update_repos

check_package_installed "git" -repo
check_package_installed "syslinux-utils" -repo
check_package_installed "unzip" -repo
check_package_installed "bash-builtins" -repo

# check this link to make sure you install the latest version https://www.virtualbox.org/wiki/Linux_Downloads
VIRTUALBOX="virtualbox-6.1"
check_package_installed $VIRTUALBOX
if [ "" == "$PKG_OK" ]; then
  # downloading and registering ssh keys. This need to be done before adding dependencies
  echo "Adding keys for Virtualbox"
  wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
  wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
  
  # Add the following line to your /etc/apt/sources.list.
  echo "Adding repos to sources.list"
  case $ARCH in
  x86_64)
    sudo apt-add-repository 'deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian '$DISTRO' contrib' 
    ;;
  i*86)
    sudo apt-add-repository 'deb  https://download.virtualbox.org/virtualbox/debian '$DISTRO' contrib' 
    ;;
  *)
    # leave ARCH as-is
    ;;
  esac
  
  update_repos
  install_package $VIRTUALBOX
fi

VAGRANT="vagrant"
check_package_installed $VAGRANT
if [ "" == "$PKG_OK" ]; then
  echo "Installing vagrant"
  # create temporary file
  # download deb file and store as temp file
  # install deb file
  # remove temporary file
  TEMP_DEB="$(mktemp)" &&
  wget -O "$TEMP_DEB" 'https://releases.hashicorp.com/vagrant/2.2.9/vagrant_2.2.9_x86_64.deb' &&
  sudo dpkg -i "$TEMP_DEB" 
  rm -f "$TEMP_DEB"
fi

PKG_OK=$(command -v packer|grep "packer")
if [ "" == "$PKG_OK" ]; then
  echo -e "${RED} packer not installed$RESET"
  echo "Installing packer" 
  sudo mkdir /usr/local/packer
  TEMP_ZIP="$(mktemp)" &&
  wget -O "$TEMP_ZIP" 'https://releases.hashicorp.com/packer/1.6.0/packer_1.6.0_linux_amd64.zip' &&
  sudo unzip "$TEMP_ZIP" -d /usr/local/packer
  rm -f "$TEMP_ZIP"
  echo 'export PATH="/usr/local/packer:$PATH"' >> ~/.bashrc
else
	echo -e "${GREEN}packer is installed$RESET"
fi


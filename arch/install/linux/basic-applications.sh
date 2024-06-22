#!/bin/bash

echo "-------------------------------------------------------------------------------"
echo "Install basic apps on top of base linux system"
echo "-------------------------------------------------------------------------------"

# ------------------------------------------------------------------------------
# Parsing options
# ------------------------------------------------------------------------------
#
# Default values
hdd=/dev/sda
hostname="arch-linux"
root_pwd="admin"
#
# Parse command line options
if [ ! -z "$1" ]; then
    hdd="$1"
fi
#
# Display the options
echo "Selected options:"
echo " - hdd: $hdd"

# ------------------------------------------------------------------------------
# Install basic apps
#  - Network Manager
#  - neovim
#  - git
#  - base-devel
#  - make
#  - gcc
#  - FAT & NTFS file system manager
#  - htop
#  - mc
#  - ranger
#  - lynx
#  - thefuck
#  - tldr
#  - neofetch
#  - exa
# ------------------------------------------------------------------------------
#
# Network Manager
pacman -S networkmanager --noconfirm
systemctl enable NetworkManager
echo "[✔] Install Network Manager"
#
# Pulsemixer
pacman -S pulsemixer --noconfirm
echo "[✔] pulsemixer"
#
# Install essatial apps
pacman -S neovim git wget --noconfirm
echo "[✔] Install Neo vim and git"
pacman -S base-devel make gcc --noconfirm
echo "[✔] Install base-devel, make, gcc"
#
# Vim configuration
config_folder=~/.config
mkdir -p ${config_folder}
cd ${config_folder}
git clone https://github.com/devbysp/nvim
echo "[✔] Configure Neo vim"
#
# FAT and NTFS filesystems
pacman -S dosfstools ntfsprogs ntfs-3g --noconfirm
echo "[✔] Install FAT & NTFS file manager"
#
# System monitoring
pacman -S htop --noconfirm
echo "[✔] Install htop"
#
# File manager
pacman -S mc --noconfirm
echo "[✔] Install mc"
#
pacman -S ranger --noconfirm
echo "[✔] Install ranger"
#
# Textbased web browser
pacman -S lynx --noconfirm
echo "[✔] Install lynx"
#
# The fuck: Autocorrect command
pacman -S thefuck --noconfirm
echo "[✔] Install thefuck"
#
# tldr: Cheat sheet for commands
pacman -S tldr --noconfirm
echo "[✔] Install tldr"
#
# Neofetch: Display system info
pacman -S neofetch --noconfirm
echo "[✔] Install neofetch"
#
# exa: commind line 'ls' command with steroids: colors and icons
pacman -S exa ttf-arimo-nerd --noconfirm
echo "[✔] Install exa"
#
# zip, unzip
pacman -S zip unzip --noconfirm
echo "[✔] Install zip unzip"
#
# trasnsmission
pacman -S transmission-cli --noconfirm
echo "[✔] transmission-cli"
#
# node
pacman -S nodejs npm --noconfirm
echo "[✔] nodejs"

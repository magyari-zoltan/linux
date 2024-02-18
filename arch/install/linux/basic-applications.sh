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
#  - ufw
#  - vim
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
# Uncomplicated firewall
# pacman -S ufw --noconfirm
# #
# systemctl enable ufw
# systemctl start ufw
# systemctl status ufw
# #
# ufw default deny outgoing
# ufw default deny incoming
# ufw default deny routed
# #
# ufw allow out http
# ufw allow out https
# ufw allow out dns
# ufw allow out ssh
# ufw allow out on docker0
# #
# ufw allow 51413/tcp comment 'transmission-cli / peer-port'
# ufw allow 51413/udp comment 'transmission-cli / peer-port'
# ufw allow 6881/udp comment  'transmission-cli / DHT protocol (finding peers more quickly)'
# #
# ufw enable
# ufw status
# echo "[✔] Firewall setup"
#
# Pulsemixer
pacman -S pulsemixer --noconfirm
echo "[✔] pulsemixer"
#
# Install essatial apps
pacman -S vim git wget --noconfirm
echo "[✔] Install vim and git"
pacman -S base-devel make gcc --noconfirm
echo "[✔] Install base-devel, make, gcc"
#
# Vim configuration
cd ~
git clone https://github.com/devbysp/.vim.git
cp .vim/.vimrc .
vim +PlugInstall +qall
echo "[✔] Configure vim"
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

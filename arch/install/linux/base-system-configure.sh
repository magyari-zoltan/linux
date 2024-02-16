#!/bin/bash

echo "-------------------------------------------------------------------------------"
echo "Configure base linux system"
echo "-------------------------------------------------------------------------------"

# ------------------------------------------------------------------------------
# Parsing options
# ------------------------------------------------------------------------------
#
# Default values
boot="bios"
hdd=/dev/sda
hostname="arch-linux"
root_pwd="admin"
#
# Parse command line options
if [ ! -z "$1" ]; then
    boot="$1"
fi
if [ ! -z "$2" ]; then
    hdd="$2"
fi
#
# Display the options
echo "Selected options:"
echo " - boot: $boot"
echo " - hdd: $hdd"

# ------------------------------------------------------------------------------
# Basic configuration
#  - hardware clock
#  - locale
#  - keyboard
#  - host name
#  - local hosts
#  - update keyring
#  - grub boot loader
#  - ufw
#  - root password
# ------------------------------------------------------------------------------
#
# Set timezone
ln -sf /usr/share/zoneinfo/Europe/Bucharest /etc/localtime
hwclock --systohc
echo "[✔] Hardware clock initialized (/etc/localtime)"
#
# Localization
sed -i 's/#hu_HU.UTF-8 UTF-8/hu_HU.UTF-8 UTF-8/g' /etc/locale.gen
locale-gen
echo "[✔] Localization (/etc/locale.gen)"
#
# Create the locale config file
echo "LANG=hu_HU.UTF-8" > /etc/locale.conf
echo "[✔] Create locale config file (/etc/locale.conf)"
#
# Create the console keyboard layout
echo "KEYMAP=hu101" > /etc/vconsole.conf
echo "[✔] Keyboard layout (/etc/vconsole.conf)"
#
# Network configuration
#
# Host name
echo ${hostname} >> /etc/hostname
echo "[✔] Host name (/etc/hostname)"
#
# Hosts
echo "127.0.0.1		localhost" > /etc/hosts
echo "::1			localhost" >> /etc/hosts
echo "127.0.1.1		${hostname}.localdomain ${hostname}" >> /etc/hosts
echo "[✔] Hosts(/etc/hosts)"
#
# Refresh keys
pacman-key --init
pacman-key --populate
echo "[✔] Update keyring"
#
# Init ramfs
mkinitcpio -P
#
# Grub boot loader
pacman -S grub --noconfirm
if [ "$boot" == "uefi" ]; then
  pacman -S efibootmgr --noconfirm

  ls
  grub-mkconfig -o /boot/grub/grub.cfg
  grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=grub
  grub-mkconfig -o /boot/grub/grub.cfg
else
  grub-install --target=i386-pc ${hdd}
  grub-mkconfig -o /boot/grub/grub.cfg
fi
echo "[✔] Configure grub"

#
# Uncomplicated firewall
#pacman -S ufw --noconfirm
#
#systemctl enable ufw
#systemctl start ufw
#systemctl status ufw
#
#ufw enable
#ufw default deny outgoing
#ufw default deny incoming
#ufw default deny routed
#
#ufw allow out http
#ufw allow out https
#ufw allow out dns
#ufw allow out ssh
#ufw allow out on docker0
#ufw status
#echo "[✔] Firewall setup"
#
# Root password
echo -en "${root_pwd}\n${root_pwd}\n" | passwd
echo "[✔] Root password created"

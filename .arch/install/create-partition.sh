#!/bin/bash

echo "-------------------------------------------------------------------------------"
echo "Create partitons"
echo "-------------------------------------------------------------------------------"

# ------------------------------------------------------------------------------
# Parsing options
# ------------------------------------------------------------------------------
#
# Default values
boot="bios"
hdd=/dev/sda
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
# Partitioning the hard disk
#
# this configuration might change depending on the machine you are installing
# on
# ------------------------------------------------------------------------------
#
# Creating partitions
if [ "$boot" == "uefi" ]; then
  # UEFI with GPT
  echo -e "g\nn\n\n\n+1G\nt\nuefi\nn\n\n\n\nw\n" | fdisk ${hdd}
  echo "✓ Partition created ('${hdd}')"
  #
  # Formatting the partitions
  mkfs.fat -F 32 ${hdd}1
  mkfs.ext4 ${hdd}2
  echo "✓ Partitions formatted (/dev/sda1: fat32, /dev/sda2: ext4)"
  #
  # Mount partition
  mount ${hdd}2 /mnt
  echo "✓ Mount partition ('${hdd}2 -> /mnt')"
  #
  mount --mkdir ${hdd}1 /mnt/boot/efi
  echo "✓ Mount partition ('${hdd}1 -> /mnt/boot/efi')"
else
  # Bios with MBR
  echo -e "o\nn\n\n\n\n\na\nw\n" | fdisk ${hdd}
  echo "✓ Partition created ('${hdd}')"
  #
  # Formatting the partitions
  mkfs.ext4 ${hdd}1
  echo "✓ Partition formatted (ext4)"
  #
  # Mount partition
  mount ${hdd}1 /mnt
  echo "✓ Mount partition ('/mnt')"
fi

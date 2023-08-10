#!/bin/bash

echo "-------------------------------------------------------------------------------"
echo "Create partitons"
echo "-------------------------------------------------------------------------------"

# ------------------------------------------------------------------------------
# Parsing options
# ------------------------------------------------------------------------------
#
# Default values
hdd=/dev/sda
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
# Partitioning the hard disk
#
# # this configuration might change depending on the machine you are installing
# # on
# ------------------------------------------------------------------------------
#
# Creating partitions
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

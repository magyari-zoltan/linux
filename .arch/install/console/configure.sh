#!/bin/bash

echo "-------------------------------------------------------------------------------"
echo "Configure console mode"
echo "-------------------------------------------------------------------------------"

grub_config=/etc/default/grub
sed -i 's/^GRUB_GFXMODE=.*$/GRUB_GFXMODE=auto/g' ${grub_config}
sed -i 's/^#+GRUB_TERMINAL_OUTPUT=.*$/GRUB_TERMINAL_OUTPUT="gfxterm"/g'  ${grub_config}
grub-mkconfig -o /boot/grub/grub.cfg

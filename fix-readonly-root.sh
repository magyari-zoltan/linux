#!/bin/bash
set -euo pipefail

FSTAB="/etc/fstab"

echo "1) Root partíció újracsatolása írhatóként, ha szükséges..."
if mount | grep -E ' on / ' | grep -q '(ro,'; then
    mount -o remount,rw /
fi

echo "2) /etc/fstab bejegyzés javítása (defaults/rw)..."
if grep -E '^[^#]+\s+/\s+' "$FSTAB" | grep -vq '\bdefaults\b'; then
    sed -i '/^[^#].*\s\/\s/s/\s\+\S\+\s\+\S\+\s\+\S\+/ \0 defaults/' "$FSTAB"
fi

echo "3) Kernelparaméterekből az \"ro\" eltávolítása..."
if [ -f /etc/default/grub ]; then
    sed -i 's/\bro\b//g' /etc/default/grub
    update-grub
fi

echo "4) systemd-remount-fs.service, majd a kritikus unitok újraindítása..."
systemctl restart systemd-remount-fs.service
systemctl restart systemd-random-seed.service \
                   systemd-sysusers.service \
                   systemd-journald.service \
                   systemd-logind.service

echo "Kész. Ellenőrizze a szolgáltatások státuszát: systemctl status <unit>"

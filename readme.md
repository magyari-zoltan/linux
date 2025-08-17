# Linux

## Arch Linux

1. Download then boot into the [live arch iso](https://archlinux.org/download).
2. Load your preferred keyboard layout for convenience. My personal choice is the **hu101** layout which can be done with the command: `loadkeys hu101`.
3. Update arch linux pgp keys:
    ```shell
    pacman-key --init
    pacman-key --populate
    ```
4. Install git in order to clone the install script: `pacman -Sy git --noconfirm`
5. Clone the install script: `git clone https://github.com/devbysp/linux`
6. Run the install with the command
    ```shell
    cd arch/install
    ./install
    ```
7. Select a profile to be installed
   - The installer creates an unencrypted boot partition and can optionally encrypt the root partition with LUKS.
     In UEFI mode this partition is `/boot/efi`. When using BIOS with encryption enabled
     an additional `/boot` partition is created while the root partition is encrypted.

## Troubleshooting

If the system boots with a read-only root filesystem, preventing services such as `systemd-logind` or `systemd-journald` from starting, run the `fix-readonly-root.sh` script with root privileges to remount the root filesystem read-write and restart essential systemd units.

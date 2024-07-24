# Linux

## Arch Linux

1. Download then boot into the [live arch iso](https://archlinux.org/download).
2. Load your preferred keyboard layout for convenience. I loaded the **hu101** layout with the command: `loadkeys hu101`.
3. Update arch linux pgp keys:
    ```shell
    pacman-key --init
    pacman-key --populate
    ```
4. Install git in order to clone the install script: `pacman -Sy git --noconfirm`
5. Clone the install script: `git clone https://github.com/devbysp/linux`
6. Install base linux system:
    ```shell
    cd linux/BaseSystem
    ./install
    ```

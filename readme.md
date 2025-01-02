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

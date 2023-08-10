# Arch linux

## Arch iso

Shell script to create a custom **Arch linux live iso** image.

**Note:** The script uses Arch linux specific commands (like pacman), therefore it has to be executed on a Arch linux system.

### Create iso image

1. Run the script [./arch/iso/create-archiso.sh](./arch/iso/create-archiso.sh). This will create a **~/ArchLiveISO** folder containing the baseline configuration for creating the iso image.
2. Inside the ArchLiveISO you'll find a build script (**~/ArchLiveISO/build.sh**) which will create the iso image from the basline configuration. The iso image will be placed inside the **~/ArchLiveISO/out** folder.

#### ISO customizations

1. Locale: `hu_HU.UTF-8`
2. Istalled packages: git

## Arch install

1. Boot the **Arch live iso** image.
2. Run the script inside the home directory (**~/install.sh**).


### Notes

- The **install.sh** script defaultly installs the linux system on `/dev/sda`.
- If you would like to change the default drive you have to pass in as an argument `install.sh /dev/vda`.
- Intalls the system on a single partition. Uses `BIOS` booting with `grub` as a boot manager placed in the `MRB`. 
- Creates a single user: **root** / default passwd: **admin**
- Locale: hu_HU.UTF-8
- Keymap: hu101
- Apps installed:
    - NetworkManager
    - base-devel, make, gcc
    - wget, git, vim (with config: https://github.com/devbysp/.vim.git)
    - dosfstools, ntfsprogs, ntfs-3g
    - ufw:
    - default deny outgoing
        - default deny incoming
        - default deny redirect
        - allow out http
        - allow out https
        - allow out dns
        - allow out ssh
    - htop, mc, lynx
    - zsh (oh-my-zsh)
    - xorg-server, xorg-xinit, xorg-xrandr, xorg-xsetroot, nitrogen, picom, webkit2gtk, mesa, xf86-video-ati
    - dwm, st, dmenu, dwmstatus
    - alsa-utils
    - firefox

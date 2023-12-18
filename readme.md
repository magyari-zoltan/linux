# Linux

This repo is there to record solution for linux related problems.

## Arch Linux

The folder [arch](arch) contains Arch linux related solutions.

### Arch ISO

The folder [iso](arch/iso) contains a [archiso](https://wiki.archlinux.org/title/Archiso)
configurator script [create-archiso.sh](arch/iso/create-archiso.sh).

The _create-archiso.sh_ is a Arch linux bash script. When executed, it will
create a customized _Live Arch ISO_ image inside the **~/ArchLiveISO** folder.

The next step is to run the _build.sh_ sctipt also found inside the
**~/ArchLiveISO** folder.

The _build.sh_ script will create the custom iso image. It will be placed
inside the **~/ArchLiveISO/out** folder. The custom _Live Arch ISO_ image when
booted it will clone this [repository](https://github.com/devbysp/linux)
into the home folder.

This repository contains a custom linux [installer](arch/install/install.sh)
script too. The script automates the linux installation on the computer. For
more details see the chapter _Arch installer_.

### Arch installer

The purpose of the installer is to automate the installation of the Arch linux.

It can be started by running the script [install.sh](arch/install/install.sh).

The script has the following options:

- `--hdd /dev/sda`: The option `--hdd` specifies on which hard disk will the
  linux be installed. Caution the script will format the hard disk and might
  create also new partitions, therefore all data will be lost on that
  hard disk. If the option is not specified then the `/dev/sda` hard disk
  will be the default.
- `--gui dwm | gnome`: The option `--gui` specifies if graphical user
  interface should be installed and which one. There are two choices **dwm**
  or **gnome**. If the option is not specified then no gui will be installed.
- `--vboxguest`: If the option is specified then the virtual box guest will
  be installed, otherwise it won't be installed.
- `--dev`: If the option is specified all the softwares needed for development
  will be installed, otherwise it won't be installed.

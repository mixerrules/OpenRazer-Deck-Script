#!/bin/bash
sudo steamos-readonly disable
sudo sed -i "s/SigLevel    = Required DatabaseOptional/SigLevel = Never/g" /etc/pacman.conf
sed -i "s/LocalFileSigLevel = Optional/#LocalFileSigLevel = Optional/g" /etc/pacman.conf
sudo pacman-key --refresh-keys
sudo pacman-key --init
sudo pacman -Sy archlinux-keyring
sudo pacman -S --overwrite \* fakeroot base-devel
sudo pacman-key --populate archlinux
sudo pacman -Syu base-devel mlocate cmake gcc holo-rel/linux-headers jupiter-rel/linux-neptune-headers holo-rel/linux-lts-headers $(pacman -Qk 2>/dev/null | grep -ve ' 0 missing' | grep -ie ^libc -e glibc -e gcc -e clang -e headers -e udev -e systemd | awk -F ':' '{print $1}') --overwrite '*'
cd /tmp/
git clone https://aur.archlinux.org/openrazer-git.git
cd openrazer-git
makepkg -sri
systemctl --user enable --now openrazer-daemon.service
sudo gpasswd -a deck plugdev

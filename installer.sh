#!/bin/bash

echo -n "Insert hostname:"
read hostname
echo -n "Insert desktop options (xorg, i3, bspwm, gnome, kde, kde+apps available; empty for tty selection):"
read desktop
echo -n "Insert video drivers (intel, amd, intel+amd, nvidia, intel+nvidia, amd+nvidia available, empty for no drivers):"
read videod
echo -n "Insert username:"
read username
echo -n "Insert timezone (ex. Europe/Rome):"
read timezone
echo -n "Insert audio preferences (pulseaudio and pipewire available, empty for no audio):"
read audio

timedatectl set-timezone $timezone
hwclock --systohc
sed -i '297s/.//' /etc/locale.gen
locale-gen
echo "LANG=it_IT.UTF-8" > /etc/locale.conf
export "LANG=it_IT.UTF-8"
echo "KEYMAP=it" >> /etc/vconsole.conf
echo "$hostname" > /etc/hostname
echo "127.0.0.1	localhost" >> /etc/hosts
echo "::1	localhost" >> /etc/hosts
echo "127.0.1.1	arch" >> /etc/hosts



pacman -S --noconfirm net-tools wireless_tools dialog wpa_supplicant networkmanager xf86-input-synaptics grub efibootmgr

case $desktop in
    xorg)
	pacman -S --noconfirm xorg xorg-xinit
	;;
    i3)
	pacman -S --noconfirm xorg xorg-xinit i3-gaps i3status
	;;
    gnome)
	pacman -S --noconfirm xorg xorg-xinit gnome gnome-shell gdm
	;;
    kde)
	pacman -S --noconfirm xorg xorg-xinit plasma dolphin sddm
	;;
    kde+apps)
	pacman -S --noconfirm xorg xorg-xinit plasma kde-applications sddm
	;;
    bspwm)
	pacman -S --noconfirm xorg xorg-xinit bspwm
	;;
    *)
	echo -n "no desktop option selected."
	;;
esac

case $audio in
    pulseaudio)
	pacman -S --noconfirm alsa-utils pulseaudio pavucontrol
	;;
    pipewire)
	pacman -S --noconfirm alsa-utils pipewire pipewire-alsa pipewire-pulse pavucontrol
	;;
    *)
	echo -n "no audio preferences selected."
	;;
esac

case $videod in
    intel)
	pacman -S --noconfirm xf86-video-intel
	;;
    amd)
	pacman -S --noconfirm xf86-video-amdgpu
	;;
    intel+amd)
	pacman -S --noconfirm xf86-video-intel xf86-video-amdgpu
	;;
    nvidia)
	pacman -S --noconfirm nvidia
	;;
    intel+nvidia)
	pacman -S --noconfirm xf86-video-intel nvidia
	;;
    amd+nvidia)
	pacman -S --noconfirm xf86-video-amdgpu nvidia
	;;
    *)
	echo -n "no driver selected."
	;;
esac



useradd -mG wheel -s /bin/bash $username

grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi
grub-mkconfig -o /boot/grub/grub.cfg


systemctl enable NetworkManager.service

echo -n "Now you need only to create a root password (passwd), a user password (passwd username) and to edit (if you want) the /etc/sudoers file to give wheel permission. :)"

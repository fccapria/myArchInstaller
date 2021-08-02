#!/bin/bash

timedatectl set-timezone Europe/Rome
hwclock --systohc
sed -i '297s/.//' /etc/locale.gen
locale-gen
echo "LANG=it_IT.UTF-8" > /etc/locale.conf
export "LANG=it_IT.UTF-8"
echo "KEYMAP=it" >> /etc/vconsole.conf
echo "arch" > /etc/hostname
echo "127.0.0.1	localhost" >> /etc/hosts
echo "::1	localhost" >> /etc/hosts
echo "127.0.1.1	arch" >> /etc/hosts

pacman -S --noconfirm net-tools wireless_tools dialog wpa_supplicant networkmanager alsa-utils pulseaudio xf86-video-intel xf86-video-amdgpu xf86-input-synaptics grub efibootmgr xorg xorg-xinit

grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi
grub-mkconfig -o /boot/grub/grub.cfg


systemctl enable NetworkManager.service

echo "Manca solamente il cambio passworde dell'utente root (passwd), la creazione dell'utente (useradd -mG wheel -s /bin/bash nomeutente), la sua password e la variazione del gruppo wheel (/etc/sudoers)"

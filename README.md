# myArchInstaller             

![myArchInstaller](https://user-images.githubusercontent.com/62179193/147276616-ebf95366-d9d3-4d05-8721-8665dc5a4687.png)


**EN**
------
What is this?
Basically it is a very simple script that allows a "guided" installation of Arch after running the pacstrap and installing git. 
Currently available features:

1. Hostname
2. DE/WM
   * Fresh Xorg
   * i3-gaps
   * BSPWM
   * Gnome
   * KDE
   * KDE with applications
3. Video drivers
   * Intel
   * AMD
   * Nvidia
   * Hybrids (Intel+AMD - Intel+Nvidia - AMD+Nvidia)
4. Username
5. Timezone
6. Audio
   * Pulseaudio
   * Pipewire
  
How to use it
-------------

```bash
git clone https://github.com/fccapria/myArchInstaller.git
cd myArchInstaller
chmod +x installer.sh
./installer.sh
```

# ALERT
The script was created for a fresh "Italian locales" installation. If you want to change the locale edit the installer ;)

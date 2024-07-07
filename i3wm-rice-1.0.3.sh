#!/bin/bash

# Update system
sudo dnf update -y &&
sleep 3 &&
sudo dnf upgrade -y &&
sleep 3 &&

# Github clone my rice
cd &&
cd Downloads &&
git clone https://github.com/astonish-g/i3-nord-dotfiles.git &&

# Install i3 Window Manager
sudo dnf install i3 dmenu -y &&
sleep 3 &&

# Install and build Picom FT labs fork
cd &&
cd Downloads &&
git clone https://github.com/FT-Labs/picom.git &&

# Install ependencies of Picom-FtLabs
sudo dnf install dbus-devel gcc git libconfig-devel libdrm-devel libev-devel libX11-devel libX11-xcb libXext-devel libxcb-devel libGL-devel libEGL-devel libepoxy-devel meson pcre2-devel pixman-devel uthash-devel xcb-util-image-devel xcb-util-renderutil-devel xorg-x11-proto-devel xcb-util-devel -y &&
sleep 3 &&

# Build Picom-FTlabs
cd picom &&
sleep 2
meson setup --buildtype=release build &&
sleep 2
ninja -C build &&
sleep 2
ninja -C build install &&
sleep 2

# Install necessary apps for my i3 set-up
sudo dnf install alacritty rofi nitrogen polybar lxappearance nemo nemo-fileroller brightnessctl fasfetch htop -y &&

echo "Installation is succesful! Please do not close the terminal." &&
sleep 2
echo "Now we will copy the files" &&
sleep 2
cd ~/Downloads/i3-new-dotfiles/helper-scripts/ &&
./config-0.2.sh &&

#Enable tap-to-click 

sleep 1  

echo "Configuration is complete. Tap-to-click will take effect after a system reboot." &&
echo
sleep 1
echo "Now we will configure the i3 for tap-to-click for your touchpad." &&

sleep 1 &&

# This script will add tap to touch to i3 on Fedora
sudo sudo bash -c 'cat > /etc/X11/xorg.conf.d/touchpad-tap.conf << EOF
Section "InputClass"
        Identifier "libinput touchpad catchall"
        MatchIsTouchpad "on"
        MatchDevicePath "/dev/input/event*"
        Driver "libinput"
        Option "Tapping" "on"
EndSection
EOF' &&

# Making Nemo personalizations
echo
echo "now we will make the modifications to Nemo file manager" &&
echo
# Icon size zoom-level
dconf write /org/nemo/icon-view/default-zoom-level "'larger'" &&
# Hide menu bar
dconf write /org/nemo/window-state/start-with-menu-bar false &&
# Hide status bar
dconf write /org/nemo/window-state/start-with-status-bar false &&
# Thumbnail preview image size increased to 1 gb
gsettings set org.nemo.preferences thumbnail-limit 1073741824 &&
# Inherit view type (icon, compact, list) from parent to children
dconf write /org/nemo/preferences/inherit-folder-viewer true &&

echo "Nemo configuration is done."
echo

# Install Optional Apps
# Set-up GitHub
read -p "Would you like to configure GitHub on your computer [y/n] " ANSWER1
if [[ $ANSWER1 = y ]] ; then
cd $HOME/Downloads/i3-new-dotfiles/helper-scripts/
./install-github-v2.sh
fi &&

# Install Blender 
read -p "Would you like to install the latest version of Blender? [y/n] " ANSWER2
if [[ $ANSWER2 = y ]] ; then
cd $HOME/Downloads/i3-new-dotfiles/helper-scripts/
./blender-install-v2.sh
fi &&

# Install Obsidian
read -p "Would you like to install the latest version of Obsidian? [y/n] " ANSWER3
if [[ $ANSWER3 = y ]] ; then
cd $HOME/Downloads/i3-new-dotfiles/helper-scripts/
./obsidian-install.sh
fi &&

# Install Virtual-box
read -p "Would you like to install Oracle Virtualbox 7? [y/n] " ANSWER4
if [[ $ANSWER4 = y ]] ; then
cd $HOME/Downloads/i3-new-dotfiles/helper-scripts/
./virtualbox-install.sh
fi





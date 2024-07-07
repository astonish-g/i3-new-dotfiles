#!/bin/bash

# Install Oh-my-bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" --unattended &&

cd ~/Downloads/i3-new-dotfiles &&

# Copy .config Files
cp -r ~/Downloads/i3-new-dotfiles/.config/* ~/.config/ &&

# Copy Wallpapers
cp -r ~/Downloads/i3-new-dotfiles/Pictures/* ~/Pictures/ &&

# Copy themes
cp -r ~/Downloads/i3-new-dotfiles/.themes ~/ &&

# Copy fonts
cp -r ~/Downloads/i3-new-dotfiles/.local/share/fonts/ ~/.local/share/ &&

# Extras
cp -r ~/Downloads/i3-new-dotfiles/Documents/* ~/Documents &&

# Nordzy Icon download
cd ~/Downloads && 
git clone https://github.com/alvatip/Nordzy-icon.git &&
cd Nordzy-icon/ &&
./install.sh -c dark -t all &&

# GTK 4 theme
cp -r ~/.themes/Catppuccin-Mocha-Standard-Blue-Dark/gtk-4.0/ ~/.config/ &&

# Set GTK Theme
gsettings set org.gnome.desktop.interface gtk-theme "Catppuccin-Mocha-Standard-Blue-Dark" &&

# Set Icon Theme
gsettings set org.gnome.desktop.interface icon-theme 'Nordzy-dark'




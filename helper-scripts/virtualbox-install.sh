#!/bin/bash

# VirtualBox 7.0 Installation script for Fedora 40

# Install dependencies
sudo dnf install @development-tools -y &&
sudo dnf install kernel-headers kernel-devel dkms -y &&

# Add Virtualbox Repository
# we add bash -c to the beginning because redirection will be performed by bash started with root
# that have enough rights to write to the /etc/
# if it was not writing to a root directory, then the line would start with the cat command
sudo bash -c 'cat > /etc/yum.repos.d/virtualbox.repo << EOF
[virtualbox]
name=Fedora \$releasever - \$basearch - VirtualBox
baseurl=http://download.virtualbox.org/virtualbox/rpm/fedora/\$releasever/\$basearch
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://www.virtualbox.org/download/oracle_vbox_2016.asc
EOF' &&

# Update
sudo dnf update -y &&

# Upgrade 
sudo dnf upgrade -y &&

# Install VirtualBox
sudo dnf install VirtualBox-7.0 -y &&

# Install VirtualBox Extension Pack
wget https://download.virtualbox.org/virtualbox/7.0.18/Oracle_VM_VirtualBox_Extension_Pack-7.0.18.vbox-extpack &&
sudo vboxmanage extpack install Oracle_VM_VirtualBox_Extension_Pack-7.0.18.vbox-extpack &&

# Add User to vboxusers Group
sudo usermod -a -G vboxusers $USER &&
echo "Installation is complete, now you should reboot your computer!"



#!/bin/bash

# Welcome
echo
echo "Welcome to GitHub configuration for Fedora" &&
sleep 2
echo "First we will set-up local Git" &&
echo
sleep 2

# Read user info
read -p "Enter your Github username please: " USERNAME &&
read -p "Enter your Github user e-mail please: " EMAIL && 

# Set-up local GIT
git config --global user.name "$USERNAME" &&
git config --global user.email $EMAIL &&
git config --global init.defaultBranch main &&

sleep 1
echo "Local GIT set-up succesfully." &&
sleep 2
echo "Now we will install GitHub CLI tool" &&
sleep 2

# This Script installs from the Official Github Repo
sudo dnf install 'dnf-command(config-manager)' -y &&
sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo &&
sudo dnf install gh --repo gh-cli

sleep 1
echo "GitHub CLI tool installed correctly." &&
sleep 2
echo "Now we should log you in to GitHub." &&
sleep 2

# Logging in to GitHub
gh auth login &&

sleep 1
echo "Logged in succesfully." &&
sleep 2
echo "Now you can start using GitHub. Have fun!"
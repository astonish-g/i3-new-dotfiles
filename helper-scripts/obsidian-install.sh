#!/bin/bash

# This is a script to install and extract Obsidian AppImage

# Trying to find out the latest version
# wget -q -O - https://api.github.com/repos/obsidianmd/obsidian-releases/releases/latest | grep 'AppImage"$' | awk -F'"' ' {print $4} '

# The command above seems like downloading the source code of the page with the wget command
# Grep finds the part about the AppImage
# And awk deletes the useless download link text before the link.

# This command gives exactly the output that I need: Obsidian-1.6.5.AppImage
# jq is necessary as js parser for the wget output for Fedora 40 since it uses wget 2, or else, the script was breaking.
# wget -q -O - https://api.github.com/repos/obsidianmd/obsidian-releases/releases/latest | jq | grep 'name' | awk -F'"' ' { print $4 } ' | grep 'AppImage' | grep -v 'arm64'

# This command on the other hand gives the version number: 1.6.5
# wget -q -O - https://api.github.com/repos/obsidianmd/obsidian-releases/releases/latest | jq | grep 'name' | awk -F'"' ' { print $4 } ' | grep 'AppImage' | grep -v 'arm64' | sed 's/Obsidian-//' | sed 's/.AppImage//'

# Variable for the latest Obsidian file name such as : Obsidian-1.6.5.AppImage
OBSIDIAN="`wget -q -O - https://api.github.com/repos/obsidianmd/obsidian-releases/releases/latest | jq | grep 'name' | awk -F'"' ' { print $4 } ' | grep 'AppImage' | grep -v 'arm64'`"

# Variable for the latest Obsidian version number such as : 1.6.5
VERSION="`wget -q -O - https://api.github.com/repos/obsidianmd/obsidian-releases/releases/latest | jq | grep 'name' | awk -F'"' ' { print $4 } ' | grep 'AppImage' | grep -v 'arm64' | sed 's/Obsidian-//' | sed 's/.AppImage//'`"

echo ""
echo "Hello! We will be downloading and installing $OBSIDIAN for your computer" &&

sleep 1

echo "The final version of the Obsidian is v$VERSION"

# Download the latest Obsidian
# --quiet for a cleaner look
# --force-progress to show a download progress bar in quiet mode or any verbose mode and in wget2 it has changed to --force-progress. On wget (wget1) use --show-progress
wget --quiet --force-progress --directory-prefix ~/Downloads https://github.com/obsidianmd/obsidian-releases/releases/download/v$VERSION/$OBSIDIAN &&

# Create a bin folder in .local and move Obsidian App Image there
# mkdir -p argument creates a directory if it doesn't exist
mkdir -p ~/.local/bin &&
mv ~/Downloads/$OBSIDIAN ~/.local/bin &&
chmod +x ~/.local/bin/$OBSIDIAN &&

# Now extract the contents of the AppImage
cd ~/.local/bin &&
./$OBSIDIAN --appimage-extract &&

# Clean the directory a bit
mv squashfs-root/ obsidian &&
rm $OBSIDIAN &&

# Finally create the .Desktop file
bash -c 'cat > ~/.local/share/applications/obsidian.desktop << EOF
[Desktop Entry]
Name=Obsidian
Exec=$HOME/.local/bin/obsidian/obsidian
Terminal=false
Type=Application
Icon=$HOME/.local/bin/obsidian/obsidian.png
StartupWMClass=obsidian
Comment=Obsidian
MimeType=x-scheme-handler/obsidian;
Categories=Office;
EOF' &&

echo ""
echo "Installation is complete! You can use your Obsidian now."



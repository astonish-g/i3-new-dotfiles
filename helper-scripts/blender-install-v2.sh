#/bin/bash

# If the download fails, then you will have to change the Blender download link to the updated one.

# Function to display ASCII art
display_hello() {
	cat << "EOF"
  ____  _     _____ _   _ ____  _____ ____  
 | __ )| |   | ____| \ | |  _ \| ____|  _ \ 
 |  _ \| |   |  _| |  \| | | | |  _| | |_) |
 | |_) | |___| |___| |\  | |_| | |___|  _ < 
 |____/|_____|_____|_| \_|____/|_____|_| \_\
                                            
EOF
}

#Display ASCII art
display_hello

echo "Hello, now we will install the latest release version of Blender."
echo
echo "Sit behind, and enjoy."
echo

# Find the last version of Blender
# Outputs as 4.1
RELEASE="`wget -q -O - https://developer.blender.org/docs/release_notes/ | grep '(current stable release)' | awk -F'"' ' { print $2 } ' | sed 's/\///'`"

# Find the complete file version of Blender
# tail -n 1 chooses the last one from the matches as it is the newest one
# Outputs as 4.1.1
VERSION="`wget -q -O - https://mirrors.sahilister.in/blender/release/Blender$RELEASE/ | grep 'linux' | tail -n 1 | awk -F'"' ' { print $2 } ' | sed 's/blender-//' | sed 's/-linux-x64.tar.xz//'`"

# Full file name
# Outputs as blender-4.1.1-linux-x64.tar.xz
FILENAME="`wget -q -O - https://mirrors.sahilister.in/blender/release/Blender$RELEASE/ | grep 'linux' | tail -n 1 | awk -F'"' ' { print $2 } '`"

echo "We are checking the last version of Blender"
echo
echo "We will be installing Blender $VERSION"
echo

# Download Blender
curl https://ftp.halifax.rwth-aachen.de/blender/release/Blender$RELEASE/$FILENAME > $HOME/Downloads/$FILENAME

# Older version
# curl https://ftp.halifax.rwth-aachen.de/blender/release/Blender$VERSION/$FILENAME > $HOME/Downloads/blender.tar.xz &&

# Extract Blender
mkdir -p $HOME/.local/bin/ &&
cd $HOME/Downloads/ &&
tar -xvf $FILENAME -C $HOME/.local/bin/ &&

# Change bin folder name to blender
cd $HOME/.local/bin/ &&
mv blender-$VERSION-linux-x64 blender

# Create a blender.desktop file
bash -c 'cat > $HOME/.local/share/applications/blender.desktop << EOF
[Desktop Entry]
Name=Blender
GenericName=3D Modeler
Comment=3D modeling, animation, rendering and post-production
Keywords=3d;modeling;rendering;
Exec=$HOME/.local/bin/blender/blender
Icon=$HOME/.local/bin/blender/blender.svg
Terminal=false
Type=Application
PrefersNonDefaultGPU=true
X-KDE-RunOnDiscreteGpu=true
Categories=Graphics;3DGraphics;
MimeType=application/x-blender;
EOF'&&

# Delete the downloaded zip file
cd $HOME/Downloads &&
rm $FILENAME &&

# Change the name of the configuration file to the installed version
cd $HOME/.config/blender/ &&
CONFIG=ls | grep -v 'matlib'  
mv $CONFIG $RELEASE

# Installation complete -hopefully-
echo
echo "Installation has completed, enjoy using the Blender!"
echo "See you! :-)"

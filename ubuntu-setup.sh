#!/bin/bash

echo "Warning! This will make potentially damaging changing to your $HOME directory."
echo "Please review the contents of ./ubuntu-setup.sh before running this script"
echo "Continue? (y/n)"
read -rp "" input
if [[ ! "$input" =~ ^[yY](es)?$ ]]; then
  echo "Script cancelled..."
  exit 1
fi

sudo apt install speedtest-cli -y
# Make the terminal look like Ubuntu 18, even on Ubuntu 20+
dconf load /org/gnome/terminal/legacy/profiles:/ < gnome-terminal-profiles.dconf
# Copy the binaries directory
cp -r ./bin ~/bin
# Transform home folders to lowercase
cp ./user-dirs.dirs ~/.config
cp ./bookmarks ~/.config/gtk-3.0
mv ~/Documents ~/documents
mv ~/Downloads ~/downloads
mv ~/Desktop ~/desktop
mv ~/Videos ~/videos
mv ~/Music ~/music
mv ~/Pictures ~/pictures
mv ~/Public ~/public
rmdir ~/Templates
# Add ~/bin path to bashrc, with highest priority (earliest in path)
cat >>~/.bashrc <<EOF
# Add custom bin
export PATH="/home/npip99/bin:$PATH"
EOF


#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
# pacman -Syu --noconfirm PACKAGESHERE

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

# Download Shattered-Pixel-Dungeon linux zip
TAG="$(curl -s https://api.github.com/repos/00-Evan/shattered-pixel-dungeon/releases/latest | jq -r '.tag_name')"
echo "Downloading Shattered-Pixel-Dungeon $TAG..."
wget --retry-connrefused --tries=30 https://github.com/00-Evan/shattered-pixel-dungeon/releases/download/$TAG/ShatteredPD-$TAG-Linux.zip -O /tmp/spd.zip
mkdir -p /tmp/spd
(cd /tmp/spd; unzip /tmp/spd.zip; ls /tmp/spd; ls /tmp/spd/*)
exit 1
sudo cp -r /tmp/wine-x86/* /usr/
rm -rf /tmp/wine*

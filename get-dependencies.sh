#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
#pacman -Syu --noconfirm tree

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

# Download Shattered-Pixel-Dungeon linux zip
TAG="$(curl -s https://api.github.com/repos/00-Evan/shattered-pixel-dungeon/releases/latest | jq -r '.tag_name')"
echo "Downloading Shattered-Pixel-Dungeon $TAG..."
wget --retry-connrefused --tries=30 https://github.com/00-Evan/shattered-pixel-dungeon/releases/download/$TAG/ShatteredPD-$TAG-Linux.zip -O /tmp/spd.zip
mkdir -p /tmp/spd
(cd /tmp/spd; unzip /tmp/spd.zip)
rm /tmp/spd/lib/*.png
mv /tmp/spd/bin/"Shattered Pixel Dungeon" /tmp/spd/bin/ShatteredPixelDungeon
mv /tmp/spd/lib/app/"Shattered Pixel Dungeon.cfg" /tmp/spd/lib/app/ShatteredPixelDungeon.cfg
cp -r /tmp/spd/* /usr/
rm -rf /tmp/spd*

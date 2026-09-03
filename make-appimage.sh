#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(curl -s https://api.github.com/repos/00-Evan/shattered-pixel-dungeon/releases/latest | jq -r '.tag_name' | sed 's|^v||')
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=https://github.com/00-Evan/shattered-pixel-dungeon/blob/master/desktop/src/main/assets/icons/icon_256.png?raw=true
export DESKTOP=./shatteredpd.desktop

# Deploy dependencies
quick-sharun /usr/bin/ShatteredPixelDungeon /usr/lib/app /usr/lib/runtime /usr/lib/libapplauncher.so

# Additional changes can be done in between here

# Turn AppDir into AppImage
quick-sharun --make-appimage

# Test the app for 12 seconds, if the test fails due to the app
# having issues running in the CI use --simple-test instead
quick-sharun --test ./dist/*.AppImage

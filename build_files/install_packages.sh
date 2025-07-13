#!/bin/bash
set -ouex pipefail

dnf5 install -y \
    neovim \
    emacs \
    buildah \
    powerline-fonts \
    hexchat \
    ardour7 \
    tokei \
    btop \
    ufw \
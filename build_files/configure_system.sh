#!/bin/bash
set -ouex pipefail

# Avoid bug
export DRACUT_NO_XATTR=1

# Update initramfs
KERNEL_SUFFIX=""

QUALIFIED_KERNEL="$(dnf5 repoquery --installed --queryformat='%{evr}.%{arch}' "kernel${KERNEL_SUFFIX:+-${KERNEL_SUFFIX}}")"
/usr/bin/dracut --no-hostonly --kver "$QUALIFIED_KERNEL" --reproducible --zstd -v --add ostree -f "/usr/lib/modules/$QUALIFIED_KERNEL/initramfs.img"

chmod 0600 /usr/lib/modules/"$QUALIFIED_KERNEL"/initramfs.img

# Set hostname
echo osterreich > /etc/hostname
echo "127.0.0.1   localhost osterreich" >> /etc/hosts

# Set up services
systemctl enable podman.socket
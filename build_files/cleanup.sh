#!/bin/bash
set -ouex pipefail

# Clean package manager cache
dnf5 clean all

# Clean temp files
rm -rf /tmp/*

# Clean /var directory while preserving essential files
find /var/* -maxdepth 0 -type d \! -name cache -exec rm -fr {} \;
find /var/cache/* -maxdepth 0 -type d \! -name libdnf5 \! -name rpm-ostree -exec rm -fr {} \;

# Restore and setup dirs
mkdir -p /var/tmp
chmod -R 1777 /var/tmp
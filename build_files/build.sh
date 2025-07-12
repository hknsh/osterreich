#!/bin/bash
set -ouex pipefail

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

echo "Building..."

echo "Installing fonts..."
bash "$SCRIPT_DIR/install_fonts.sh"

echo "Installing packages..."
bash "$SCRIPT_DIR/install_packages.sh"

echo "Configuring system..."
bash "$SCRIPT_DIR/configure_system.sh"

echo "Cleaning up..."
bash "$SCRIPT_DIR/cleanup.sh"

echo "Finalizing image..."
bash "$SCRIPT_DIR/finalize_image.sh"

echo "Done."
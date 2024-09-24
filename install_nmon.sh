#!/bin/bash

# Detect the Linux distribution
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
else
    echo "Unable to detect your Linux distribution!"
    exit 1
fi

# Install nmon based on the detected distribution
case "$OS" in
    ubuntu|debian)
        echo "Installing nmon on Ubuntu/Debian..."
        sudo apt update
        sudo apt install -y nmon
        ;;
    centos|rhel|rocky|almalinux)
        echo "Installing nmon on CentOS/RHEL..."
        sudo yum install -y epel-release
        sudo yum install -y nmon
        ;;
    fedora)
        echo "Installing nmon on Fedora..."
        sudo dnf install -y nmon
        ;;
    arch|manjaro)
        echo "Installing nmon on Arch/Manjaro..."
        sudo pacman -Syu nmon
        ;;
    *)
        echo "Unsupported Linux distribution!"
        exit 1
        ;;
esac

# Verify the installation
echo "Verifying nmon installation..."
if command -v nmon &> /dev/null; then
    echo "nmon successfully installed!"
    nmon -h
else
    echo "nmon installation failed!"
    exit 1
fi
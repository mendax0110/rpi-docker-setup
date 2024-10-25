#!/bin/bash

# Script to install essential packages on a new Raspberry Pi setup

# Update package lists
echo "Updating package lists..."
sudo apt-get update

# Install specified packages
echo "Installing packages..."
sudo apt-get install -y --no-install-recommends \
    sudo \
    net-tools \
    iputils-ping \
    dnsutils \
    curl \
    wget \
    nano \
    python3 \
    python3-pip \
    python3-dev \
    build-essential \
    gnupg \
    git \
    gnupg2 \
    ranger \
    screen

# Clean up apt cache to save space
echo "Cleaning up..."
sudo apt-get clean
sudo rm -rf /var/lib/apt/lists/*

echo "Installation complete!"

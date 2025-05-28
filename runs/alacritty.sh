#!/bin/bash

# Function to print colored messages
print_color() {
    local color="$1"
    shift
    echo -e "${color}$*${NC}"
}

# Define color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Check if Rust is installed
if ! command -v rustc &> /dev/null; then
    print_color $YELLOW "Installing Rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source $HOME/.cargo/env

    print_color $GREEN "Rust is installed."
    
    print_color $YELLOW "Restarting the terminal..."
    sudo reboot
else
    print_color $GREEN "Rust is already installed."
fi

# Update package list
print_color $GREEN "Updating package list..."
sudo apt update

# Update Rust
print_color $YELLOW "Updating Rust..."
rustup update

# Install dependencies
print_color $YELLOW "Installing dependencies..."
sudo apt install cmake g++ pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3

# Clone Alacritty repository
print_color $YELLOW "Cloning Alacritty repository..."
git clone https://github.com/alacritty/alacritty.git

# Change to the Alacritty directory
cd alacritty

# Build Alacritty
print_color $GREEN "Building Alacritty..."
cargo build --release

# Install Alacritty
print_color $GREEN "Installing Alacritty..."
# sudo cp target/release/alacritty /usr/local/bin
# Install desktop entry
# sudo cp alacritty.desktop /usr/share/applications

sudo tic -xe alacritty,alacritty-direct extra/alacritty.info
infocmp alacritty
sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database

# Clean up
cd ..
rm -rf alacritty

print_color $GREEN "Alacritty installation completed."
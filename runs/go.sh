#!/bin/bash

# Define color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Function to print messages in color
print_message() {
    echo -e "${1}${2}${NC}"
}

# Check if Go is already installed
if command -v go &> /dev/null; then
    print_message $YELLOW "Go is already installed."
    exit 0
fi

# Download and install Go
print_message $GREEN "Installing Go..."

# Get the latest version of Go
GO_VERSION=$(curl -s https://golang.org/dl/ | grep -oP 'go[0-9.]+\.linux-amd64.tar.gz' | head -1)

# Download the tarball
curl -LO "https://golang.org/dl/${GO_VERSION}"

# Remove any existing Go installation
sudo rm -rf /usr/local/go

# Install Go
sudo tar -C /usr/local -xzf "${GO_VERSION}"

# Set up Go environment variables
# echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
# source ~/.bashrc

print_message $GREEN "Go installation completed successfully!"

#!/bin/bash

# Define colors for echo
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Function to echo messages in color
function echo_color() {
    echo -e "${1}${2}${NC}"
}

# Update package list
echo_color $YELLOW "Updating package list..."
sudo apt update

# Check if Node.js is installed
if command -v node &> /dev/null; then
    echo_color $GREEN "Node.js is already installed."
else
    echo_color $YELLOW "Installing Node.js..."
    

    https://nodejs.org/dist/v22.14.0/node-v22.14.0-linux-x64.tar.xz

	# Verify the Node.js version:
	node -v # Should print "v22.14.0".
	npm -v

	npm install -g pnpm@latest-10
	pnpm -v

# Check if pnpm is installed
if command -v pnpm &> /dev/null; then
    echo_color $GREEN "pnpm is already installed."
else
	echo_color $GREEN "Node.js installed successfully!"

    echo_color $GREEN "pnpm installed successfully!"
 fi
fi



# Check if bun is installed
if command -v bun &> /dev/null; then
    echo_color $GREEN "bun is already installed."
else
    echo_color $YELLOW "Installing bun..."
    curl -fsSL https://bun.sh/install | bash

    echo_color $GREEN "bun installed successfully!"
fi

echo_color $GREEN "All installations completed successfully!"

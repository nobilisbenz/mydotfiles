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
else
    print_color $GREEN "Rust is already installed."
fi
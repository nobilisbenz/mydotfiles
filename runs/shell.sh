#!/bin/bash

# Define color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Update package list
echo -e "${BLUE}Updating package list...${NC}"
sudo apt update

# Install eza
if ! command -v eza &> /dev/null; then
    echo -e "${GREEN}Installing eza...${NC}"
    cargo install eza
else
    echo -e "${YELLOW}eza is already installed.${NC}"
fi

# Install Starship
if ! command -v starship &> /dev/null; then
    echo -e "${GREEN}Installing Starship...${NC}"
    curl -sS https://starship.rs/install.sh | sh
else
    echo -e "${YELLOW}Starship is already installed.${NC}"
fi

# Install Tmux
if ! command -v tmux &> /dev/null; then
    echo -e "${GREEN}Installing Tmux...${NC}"
    sudo apt install -y tmux
else
    echo -e "${YELLOW}Tmux is already installed.${NC}"
fi

# Install Tmux Plugin Manager (TPM)
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo -e "${GREEN}Installing Tmux Plugin Manager...${NC}"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
    echo -e "${YELLOW}Tmux Plugin Manager is already installed.${NC}"
fi

# Install FiraCodeiScript
if [ ! -d "$HOME/.local/share/fonts/FiraCodeiScript" ]; then
    echo -e "${GREEN}Installing Fira Code iScript...${NC}"
    mkdir -p ~/.local/share/fonts
    git clone https://github.com/kencrocken/FiraCodeiScript.git ~/.local/share/fonts/FiraCodeiScript
    fc-cache -fv
else
    echo -e "${YELLOW}Fira Code iScript is already installed.${NC}"
fi

echo -e "${BLUE}Installation complete!${NC}"

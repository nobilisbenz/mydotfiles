#!/bin/bash

# Define colors for echoing steps
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Step 1: Download Chrome .deb package
echo -e "${GREEN}Downloading Google Chrome...${NC}"
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O google-chrome.deb

# Step 2: Install the downloaded package
echo -e "${GREEN}Installing Google Chrome...${NC}"
sudo dpkg -i google-chrome.deb

# Step 3: Fix any dependency issues
echo -e "${GREEN}Fixing dependencies...${NC}"
sudo apt-get install -f

# Step 4: Clean up
echo -e "${GREEN}Cleaning up...${NC}"
rm google-chrome.deb

echo -e "${GREEN}Google Chrome installation completed!${NC}"

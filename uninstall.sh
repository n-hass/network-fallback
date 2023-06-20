#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Colour

printf "${BLUE}Disabling systemd service ...${NC}\n"
sudo systemctl disable --now network-fallback.service

printf "${BLUE}Cleaning system and config files ...${NC}\n"
sudo rm -f /etc/systemd/system/network-fallback.service
sudo rm -rf /etc/network-fallback.d

sudo -H pip3 uninstall network_fallback_service

printf "${GREEN}Done${NC}\n"
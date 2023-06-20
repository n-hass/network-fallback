#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Colour

export PACKAGE_ARCHIVE=$(ls src/dist/*.tar.gz 2> /dev/null)

## if there is no archive, install from source
if [ -z "$PACKAGE_ARCHIVE" ]; then
	printf "${BLUE}Building ...${NC}\n"
	(cd src; sudo -H python3 setup.py install)
else
	printf "${BLUE}Installing from archive distribution ...${NC}\n"
	sudo -H pip3 install ${PACKAGE_ARCHIVE}
fi

sudo /usr/local/bin/network-fallback-config
if [ $? -ne 0 ]; then
	printf "\n${RED}Error:${NC} Failed to configure service.\n"
	exit 1
fi

sudo systemctl daemon-reload

## prompt the user to start and enable the service now
printf "\n${GREEN}Done!${NC} Would you like to enable and start the service now? (y/n)\n"
read -p "" -n 1 -r
## if the user wants to enable and start the service
if [[ $REPLY =~ ^[Yy]$ ]]; then
	sudo systemctl enable --now network-fallback.service
else
	printf "\n${RED}Not enabled. You can enable/start the service with systemctl.${NC}\n"
fi
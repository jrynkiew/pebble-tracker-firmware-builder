#!/bin/bash
# # Environment variables
red=`tput setaf 1`
# purple=`tput setaf 93`
# blue=`tput setaf 21`
green=`tput setaf 2`
gold=`tput setaf 214`
reset=`tput sgr0`

. ./tools/setenv.sh

# Get user input
read -p "Which ${green}IoTeX${reset} ${gold}Pebble Tracker Firmware${reset} do you want to build?
        ${green}1)${reset}: Aries
        ${green}2)${reset}: Gravel
        ${green}3)${reset}: Riverrock
        " FIRMWARE_SELECTION_CONFIG

# Set hardocded folder names for Pebble Apps based on git branch selection (These are set in the actual github repositories)
export PEBBLE_APPS_BRANCH=$(case "$FIRMWARE_SELECTION_CONFIG" in
  (1)    
    echo "aries"    ;;
  (2)    
    echo "main"  ;; #gravel
  (3)    
    echo "riverrock"  ;;
esac)

export FIRMWARE_SELECTION=$(case "$FIRMWARE_SELECTION_CONFIG" in
  (1)    
    echo "Aries"    ;;
  (2)    
    echo "Gravel"  ;;
  (3)    
    echo "Riverrock"  ;;
esac)

echo "Building the ${green}$FIRMWARE_SELECTION firmware${reset}"

docker-compose -p JRPC-pebble-firmware -f $JRPC_PEBBLE_DIR/build/docker-compose.yaml build --build-arg FIRMWARE_SELECTION=$FIRMWARE_SELECTION --build-arg PEBBLE_APPS_BRANCH=$PEBBLE_APPS_BRANCH --build-arg PEBBLE_APPS_REPOSITORY=$PEBBLE_APPS_REPOSITORY --build-arg PEBBLE_FIRMWARE_BRANCH=$PEBBLE_FIRMWARE_BRANCH --build-arg PEBBLE_FIRMWARE_REPOSITORY=$PEBBLE_FIRMWARE_REPOSITORY

docker-compose -p JRPC-pebble-firmware -f $JRPC_PEBBLE_DIR/build/docker-compose.yaml up



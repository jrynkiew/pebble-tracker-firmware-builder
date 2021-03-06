#!/bin/bash
# Environment variables
red=`tput setaf 1`
purple=`tput setaf 93`
blue=`tput setaf 21`
green=`tput setaf 2`
gold=`tput setaf 214`
reset=`tput sgr0`

. ./tools/setenv.sh

git submodule update --init --recursive

cd $JRPC_PEBBLE_DIR/external/pebble-firmware

read -p "Which ${green}IoTeX${reset} ${gold}Pebble Tracker Firmware${reset} do you want to build?
        ${green}1)${reset}: Aries
        ${green}2)${reset}: Gravel
        ${green}3)${reset}: Riverrock
        " FIRMWARE_SELECTION_CONFIG

FIRMWARE_SELECTION_GIT=$(case "$FIRMWARE_SELECTION_CONFIG" in
  (1)    
    echo "aries"    ;;
  (2)    
    echo "main"  ;; #gravel
  (3)    
    echo "riverrock"  ;;
esac)

FIRMWARE_SELECTION=$(case "$FIRMWARE_SELECTION_CONFIG" in
  (1)    
    echo "Aries"    ;;
  (2)    
    echo "Gravel"  ;;
  (3)    
    echo "Riverrock"  ;;
esac)

case $FIRMWARE_SELECTION_GIT in
  aries)
    FIRMWARE_PATH_DOCKER="/app/pebble-firmware-legacy/nrf/applications/$FIRMWARE_SELECTION/"
    FIRMWARE_PATH="$JRPC_PEBBLE_DIR/external/pebble-firmware/nrf/applications/$FIRMWARE_SELECTION/" 
    git checkout $FIRMWARE_SELECTION_GIT  ;;

  main)
    FIRMWARE_PATH_DOCKER="/app/pebble-firmware-legacy/nrf/applications/$FIRMWARE_SELECTION/" 
    FIRMWARE_PATH="$JRPC_PEBBLE_DIR/external/pebble-firmware/nrf/applications/$FIRMWARE_SELECTION/"
    git checkout $FIRMWARE_SELECTION_GIT  ;;

  riverrock)
    FIRMWARE_PATH_DOCKER="/app/pebble-firmware-legacy/nrf/applications/$FIRMWARE_SELECTION/"
    FIRMWARE_PATH="$JRPC_PEBBLE_DIR/external/pebble-firmware/nrf/applications/$FIRMWARE_SELECTION/"
    git checkout $FIRMWARE_SELECTION_GIT  ;;

  *)
    echo "${red}Not a valid answer. Terminating${reset}"
    exit 0 ;;
esac

cd $JRPC_PEBBLE_DIR/external/pebble-firmware-legacy
git checkout v1.4.0

cp -r $FIRMWARE_PATH $JRPC_PEBBLE_DIR/external/pebble-firmware-legacy/nrf/applications

echo "This script will attempt to build the ${green}$FIRMWARE_SELECTION firmware${reset}"

# Start the container
docker-compose -p JRPC-pebble-firmware -f $JRPC_PEBBLE_DIR/build/docker-compose.yaml up --no-deps --build

echo "FIRMWARE_PATH_DOCKER=$FIRMWARE_PATH_DOCKER" > $JRPC_PEBBLE_DIR/build/.env




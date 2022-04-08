
# # Environment variables
red=`tput setaf 1`
# purple=`tput setaf 93`
# blue=`tput setaf 21`
green=`tput setaf 2`
gold=`tput setaf 214`
reset=`tput sgr0`

. ./build/setenv.sh "applications/Aries/"

#git submodule update --init --recursive

# rm -rf ./external/pebble-firmware/ncs/nrf/boards/arm/thingy91_nrf9160 && \
# cp -rv ./external/pebble-firmware-legacy/nrf/boards/arm/thingy91_nrf9160 ./external/pebble-firmware/ncs/nrf/boards/arm/

read -p "Which ${green}IoTeX${reset} ${gold}Pebble Tracker Firmware${reset} do you want to build? \n
        (${red}1${reset}): Gravel
        (${red}2${reset}): Asset Tracker
        (${red}3${reset}): Aries
        " FIRMWARE_SELECTION_CONFIG

FIRMWARE_SELECTION=$(case "$FIRMWARE_SELECTION_CONFIG" in
  (1)    echo "gravel"           ;;
  (2)    echo "asset_tracker"    ;;
  (3)    echo "aries"    ;;
esac)

case $FIRMWARE_SELECTION in
  gravel)
    FIRMWARE_PATH="/app/pebble-firmware/nrf/applications/Gravel/" ;;

  asset_tracker)
    FIRMWARE_PATH="/app/pebble-firmware-legacy/nrf/applications/asset_tracker/" ;;

  aries)
    FIRMWARE_PATH="/app/pebble-firmware/nrf/applications/Aries/" ;;
  *)
    echo "${red}Not a valid answer. Terminating${reset}"
    exit 0 ;;
esac

# Getting necessary user input
read -p "This script will attempt to install ${green}$BUILD $FIRMWARE_PATH ${reset}
Do you want to perform a first-time installation (${red}F${reset}) or run the application (${green}R${reset})?: " MODE

MODE_flag=$(case "$MODE" in
  (F|f)
    echo "docker-compose -p JRPC-pebble-firmware -f ./build/docker-compose.yaml up --no-deps --build" ;;
  (R|r)
    echo "docker-compose -p JRPC-pebble-firmware -f ./build/docker-compose.yaml up" ;;
esac)

$MODE_flag
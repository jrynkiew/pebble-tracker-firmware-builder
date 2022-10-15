#!/bin/bash
red=`tput setaf 1`
purple=`tput setaf 93`
blue=`tput setaf 21`
green=`tput setaf 2`
gold=`tput setaf 214`
reset=`tput sgr0`

function banner {
echo "${gold}     ____._____________________________  
${gold}    |    |\______   \______   \_   ___ \ 
${gold}    |    | |       _/|     ___/    \  \/ 
${gold}/\__|    | |    |   \|    |   \     \____
${gold}\________| |____|_  /|____|    \______  /
${gold}                  \/                  \/ ${reset}"
}

# Build firmware
west build -b iotex_pebble_hw30ns "/app/pebble-firmware/nrf/applications/$FIRMWARE_SELECTION/"

banner
echo "${green}The server is available at http://0.0.0.0:1337 ${reset}"
echo "${green}e${reset}${red}n${reset}${blue}j${reset}${purple}o${reset}${red}y${reset} ${red}:)${reset}"

cd /app/pebble-firmware/build/zephyr
python3 -m http.server

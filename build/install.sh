#!/bin/bash

cd /app/pebble-firmware-legacy

# git clone https://github.com/nrfconnect/sdk-zephyr zephyr
# cd zephyr
# git reset --hard v2.4.0-ncs1
# git rm -r --cached .
# cd ..




rm -rf build/
west update
west zephyr-export
source zephyr/zephyr-env.sh
pip3 install -r nrf/scripts/requirements.txt
pip3 install -r bootloader/mcuboot/scripts/requirements.txt
pip3 install -r zephyr/scripts/requirements.txt
west build -b iotex_pebble_hw30ns /app/pebble-firmware-legacy/nrf/applications/Aries

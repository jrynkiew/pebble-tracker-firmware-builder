#!/bin/bash

cd /app/pebble-firmware-legacy

# git clone https://github.com/nrfconnect/sdk-zephyr zephyr
# cd zephyr
# git reset --hard v2.4.0-ncs1
# git rm -r --cached .
# cd ..

pip3 install -r zephyr/scripts/requirements.txt
pip3 install -r nrf/scripts/requirements.txt
pip3 install -r bootloader/mcuboot/scripts/requirements.txt

source zephyr/zephyr-env.sh
rm -rf build/
west update
west zephyr-export
west build -b iotex_pebble_hw30ns nrf/applications/Aries

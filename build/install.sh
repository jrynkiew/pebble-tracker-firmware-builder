#!/bin/bash

cd /app/pebble-firmware-legacy

rm -rf build/
rm -rf zephyr/
west update
west zephyr-export
source zephyr/zephyr-env.sh
pip3 install -r nrf/scripts/requirements.txt
pip3 install -r bootloader/mcuboot/scripts/requirements.txt
pip3 install -r zephyr/scripts/requirements.txt
west build -b iotex_pebble_hw30ns /app/pebble-firmware-legacy/nrf/applications/Aries

#!/bin/bash
pip3 install -r /app/pebble-firmware/nrf/scripts/requirements.txt
pip3 install -r /app/pebble-firmware/bootloader/mcuboot/scripts/requirements.txt
pip3 install -r $ZEPHYR_BASE/scripts/requirements.txt

source $ZEPHYR_BASE/zephyr-env.sh

cd /app/pebble-firmware
rm -rf build/
west update
west zephyr-export

west build -b iotex_pebble_hw30ns $BRANCH

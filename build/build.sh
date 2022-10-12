#!/bin/bash

# Prepare environment
cd /app/pebble-firmware
rm -rf ./build/
rm -rf ./zephyr/
git clone -b v2.4.0-ncs1 https://github.com/nrfconnect/sdk-zephyr zephyr
cd ./zephyr
git branch manifest-rev

# Install requirements
pip3 install -r /app/pebble-firmware/nrf/scripts/requirements.txt
pip3 install -r /app/pebble-firmware/bootloader/mcuboot/scripts/requirements.txt
pip3 install -r $ZEPHYR_BASE/scripts/requirements.txt
source $ZEPHYR_BASE/zephyr-env.sh

# Build
west update
west zephyr-export
west build -b iotex_pebble_hw30ns $BRANCH

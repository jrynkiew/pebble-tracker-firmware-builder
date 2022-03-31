#!/bin/bash

cp -r /app/pebble-firmware/nrf/applications/Aries/ /app/pebble-firmware-legacy/nrf/applications/
west build -b thingy91_nrf9160ns /app/pebble-firmware-legacy/nrf/applications/Aries/


# RUN pip3 install -r zephyr/scripts/requirements.txt && \
#     pip3 install -r nrf/scripts/requirements.txt && \
#     pip3 install -r bootloader/mcuboot/scripts/requirements.txt

# cd /app/pebble-firmware/ncs
# west build -b thingy91_nrf9160ns /app/pebble-firmware-legacy/nrf/applications/asset_tracker/

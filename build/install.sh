#!/bin/bash

cp -r /app/pebble-firmware/nrf/applications/Aries/ /app/pebble-firmware-legacy/nrf/applications/
west build -b thingy91_nrf9160ns /app/pebble-firmware-legacy/nrf/applications/Aries/

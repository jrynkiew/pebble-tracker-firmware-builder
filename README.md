# Pebble Tracker Firmware Update Build System
![Banner_optimized](https://user-images.githubusercontent.com/63042547/166878689-1ef9fce4-7996-4b95-89a7-b0f39a439656.png)


# Instructions
(only tested on Linux)

1. Install Docker
2. Install Docker-Compose

3. `chmod +x install.sh`

4. `./install.sh
5. Select which firmware to build (input numeric keys 1, 2 or 3 and press enter)


**Output** ./external/pebble-firmware-legacy/build/zephyr/app_test_update.hex`

# Post Build Instructions
(requires direct access to a working Pebble Tracker)

Go to IoTeX documentation here https://docs.iotex.io/verifiable-data/pebble-tracker/firmware-update#offline-firmware-upgrade and follow the instructions on flashing your Pebble Tracker with the newly build firmware.

FROM ubuntu:bionic
ENV DEBIAN_FRONTEND noninteractive
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt update && apt install --no-install-recommends git cmake ninja-build gperf \
    ccache dfu-util device-tree-compiler wget \
    python3-dev python3-pip xz-utils file \
    make gcc gcc-multilib g++-multilib libsdl2-dev libssl-dev -y

RUN wget https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu-rm/9-2020q2/gcc-arm-none-eabi-9-2020-q2-update-x86_64-linux.tar.bz2 && \
    tar -jxvf gcc-arm-none-eabi-9-2020-q2-update-x86_64-linux.tar.bz2 && \
    mv gcc-arm-none-eabi-9-2020-q2-update gnuarmemb
#    rm gcc-arm-none-eabi-9-2020-q2-update-x86_64-linux.tar.bz2

# RUN git clone https://github.com/nrfconnect/sdk-zephyr zephyr
# WORKDIR /zephyr
# RUN git reset --hard v2.4.0-ncs1
# RUN git rm -r --cached .
# WORKDIR /

RUN python3 -m pip install --upgrade pip setuptools tk wheel && \
    pip3 install west intelhex pyelftools click cryptography cbor

RUN source ~/.bashrc

# Install NRF SDK
# WORKDIR /west
# RUN west init -m https://github.com/nrfconnect/sdk-nrf --mr v1.4.0 && \
#     west update

# Install CMake
WORKDIR /cmake
RUN wget https://github.com/Kitware/CMake/releases/download/v3.22.2/cmake-3.22.2.tar.gz && \
    tar -zxvf cmake-3.22.2.tar.gz && \
    cd cmake-3.22.2 && \
    ./bootstrap && \
    make && \
    make install

# Export a Zephyr CMake. The Zephyr CMake package ensures that CMake can automatically select a Zephyr to use for building the application.
# WORKDIR /west
# RUN west zephyr-export

RUN wget https://launchpad.net/ubuntu/+source/device-tree-compiler/1.4.7-1/+build/15279267/+files/device-tree-compiler_1.4.7-1_amd64.deb -P /build && \
    apt install /build/device-tree-compiler_1.4.7-1_amd64.deb && \
    rm /build/device-tree-compiler_1.4.7-1_amd64.deb

# CMD [ "west", "build", "-b", "thingy91_nrf9160ns", "/app/pebble-firmware-legacy/nrf/applications/Aries" ]
# CMD [ "west", "build", "-b", "thingy91_nrf9160ns", "/app/pebble-firmware-legacy/nrf/applications/Aries" ]

# RUN west build -b thingy91_nrf9160ns /app/pebble-firmware-legacy/nrf/applications/asset_tracker/
#/app/pebble-firmware-legacy/nrf/applications/asset_tracker/
#/app/pebble-firmware/nrf/applications/Aries

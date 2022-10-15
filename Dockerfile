# Prepare the environment for cloning necessary files
FROM alpine/git:latest AS cloner
ARG PEBBLE_APPS_BRANCH
ARG PEBBLE_APPS_REPOSITORY
ARG PEBBLE_FIRMWARE_BRANCH
ARG PEBBLE_FIRMWARE_REPOSITORY
ARG FIRMWARE_SELECTION

# get the repositories
RUN git clone $PEBBLE_FIRMWARE_REPOSITORY /pebble-firmware \
    && cd /pebble-firmware \
    && git checkout $PEBBLE_FIRMWARE_BRANCH

RUN git clone $PEBBLE_APPS_REPOSITORY /pebble-apps \
    && cd /pebble-apps \
    && git checkout $PEBBLE_APPS_BRANCH \
    && cp -r ./nrf/applications/$FIRMWARE_SELECTION /pebble-firmware/nrf/applications

# Prepare the environment variables for building the firmware
FROM ubuntu:bionic AS builder
ENV DEBIAN_FRONTEND noninteractive
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
ENV VIRTUAL_ENV=/opt/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Update image and install necessary packages
RUN apt update && apt install -y apt-utils
RUN apt upgrade -y  
RUN apt install -y --no-install-recommends \
    python3-dev python3-venv \
    wget xz-utils file ninja-build \
    make gcc gcc-multilib g++-multilib \
    libssl-dev libsdl2-dev \
    dfu-util git \
    flex bison

# Prepare Python virtual environment
RUN python3 -m venv $VIRTUAL_ENV
RUN pip3 install --upgrade pip wheel
RUN pip3 install --upgrade west tk setuptools setuptools-rust intelhex pyelftools docopt click cryptography cbor

# Install packages manually, since they are not provided pre-packaged by the ubuntu repositories
RUN wget https://github.com/Kitware/CMake/releases/download/v3.22.2/cmake-3.22.2.tar.gz && \
    tar -zxvf cmake-3.22.2.tar.gz && \
    mv cmake-3.22.2 /opt/cmake && \
    cd /opt/cmake && \
    ./bootstrap && \
    make && \
    make install && \
    rm /cmake-3.22.2.tar.gz

RUN wget https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu-rm/9-2020q2/gcc-arm-none-eabi-9-2020-q2-update-x86_64-linux.tar.bz2 && \
    tar -jxvf gcc-arm-none-eabi-9-2020-q2-update-x86_64-linux.tar.bz2 && \
    mv gcc-arm-none-eabi-9-2020-q2-update /opt/gnuarmemb && \
    rm /gcc-arm-none-eabi-9-2020-q2-update-x86_64-linux.tar.bz2

RUN wget https://git.kernel.org/pub/scm/utils/dtc/dtc.git/snapshot/dtc-1.6.1.tar.gz && \
    tar -zxvf dtc-1.6.1.tar.gz && \
    mv dtc-1.6.1 /opt/dtc-1.6.1 && \
    cd /opt/dtc-1.6.1 && \
    make && \
    make install && \
    rm /dtc-1.6.1.tar.gz 

RUN wget https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v0.15.1/zephyr-sdk-0.15.1_linux-x86_64.tar.gz && \
    tar -zxvf zephyr-sdk-0.15.1_linux-x86_64.tar.gz && \
    mv zephyr-sdk-0.15.1 /opt/zephyr-sdk && \
    cd /opt/zephyr-sdk && \
    ./setup.sh -t all -h -c && \
    rm /zephyr-sdk-0.15.1_linux-x86_64.tar.gz

# Copy cloed repositories from cloner container to the builder container
COPY --from=cloner /pebble-firmware /app/pebble-firmware

# Prepare the python virtual environment for building the firmware
WORKDIR /app/pebble-firmware

RUN pip3 install -r /app/pebble-firmware/nrf/scripts/requirements.txt
RUN pip3 install -r /app/pebble-firmware/bootloader/mcuboot/scripts/requirements.txt
RUN pip3 install -U west

# Clean repository (to delete in custom firmware repo)
RUN rm -r bootloader/mcuboot mbedtls modules nrfxlib tools test/cmock

# Initiate zephyr repository
RUN west update

# Install extra requirements
RUN pip3 install -r /app/pebble-firmware/zephyr/scripts/requirements.txt
RUN . /app/pebble-firmware/zephyr/zephyr-env.sh
RUN west zephyr-export

CMD ["bash", "-l"]
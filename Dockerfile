FROM ubuntu:bionic
ENV DEBIAN_FRONTEND noninteractive
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
ENV VIRTUAL_ENV=/opt/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

RUN apt update && apt install -y apt-utils
RUN apt upgrade -y  
RUN apt install -y --no-install-recommends \
    python3-dev python3-venv \
    wget xz-utils file ninja-build \
    make gcc gcc-multilib g++-multilib \
    libssl-dev libsdl2-dev \
    dfu-util git \
    flex bison

RUN python3 -m venv $VIRTUAL_ENV
RUN pip3 install --upgrade pip wheel
RUN pip3 install --upgrade west tk setuptools setuptools-rust intelhex pyelftools docopt click cryptography cbor

# Install CMake
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


# RUN west --version

CMD ["bash", "-l"]

# RUN wget https://launchpad.net/ubuntu/+source/device-tree-compiler/1.4.7-1/+build/15279267/+files/device-tree-compiler_1.4.7-1_amd64.deb -P /build && \
#     apt install /build/device-tree-compiler_1.4.7-1_amd64.deb && \
#     rm /build/device-tree-compiler_1.4.7-1_amd64.deb

# Export a Zephyr CMake. The Zephyr CMake package ensures that CMake can automatically select a Zephyr to use for building the application.
# WORKDIR /west
# RUN west zephyr-export



# CMD [ "west", "build", "-b", "thingy91_nrf9160ns", "/app/pebble-firmware-legacy/nrf/applications/Aries" ]
# CMD [ "west", "build", "-b", "thingy91_nrf9160ns", "/app/pebble-firmware-legacy/nrf/applications/Aries" ]

# RUN west build -b thingy91_nrf9160ns /app/pebble-firmware-legacy/nrf/applications/asset_tracker/
#/app/pebble-firmware-legacy/nrf/applications/asset_tracker/
#/app/pebble-firmware/nrf/applications/Aries

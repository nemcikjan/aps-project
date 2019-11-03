#!/bin/bash

# install dependencies
apt-get install -y \
build-essential \
libncurses-dev \
bison \
flex \
libssl-dev \
libelf-dev \
bc \
time

# getting kernel sources
wget https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.19.80.tar.xz

# unzip
unxz -v linux-4.19.80.tar.xz

# untar
tar xvf linux-4.19.80.tar

# copy kernel config
cp -v ./.config linux-4.19.80

# build sources
/usr/bin/time -o timeFile make --directory linux-4.19.80
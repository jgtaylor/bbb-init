#!/bin/bash

# install shit:
# nvm, node 7.7x, kernel-headers, fixed rtl driver, curl, get, etc.
# configure connman for wifi, etc.
# disable HDMI/AUDIO (NOT EMMC!!!!)
# set default cape universala

function wirelessFix() {
# SRC: https://github.com/pvaret/rtl8192cu-fixes
# get the kernel version via uname -r
version=$(uname -r)
apt-get install git linux-headers-${version} build-essential dkms
git clone https://github.com/pvaret/rtl8192cu-fixes.git
dkms add ./rtl8192cu-fixes
dkms install 8192cu/1.10
depmod -a
cp ./rtl8192cu-fixes/blacklist-native-rtl8192.conf /etc/modprobe.d/
cp ./rtl8192cu-fixes/8192cu-disable-power-management.conf /etc/modprobe.d/
}


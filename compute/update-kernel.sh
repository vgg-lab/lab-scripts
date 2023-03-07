#!/bin/bash

VERSION=$1

# 5.10 Kernel
if [ "${VERSION}" == "5.10" ]; then
    wget -c https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.10/amd64/linux-headers-5.10.0-051000_5.10.0-051000.202012132330_all.deb
    wget -c https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.10/amd64/linux-headers-5.10.0-051000-generic_5.10.0-051000.202012132330_amd64.deb
    wget -c https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.10/amd64/linux-image-unsigned-5.10.0-051000-generic_5.10.0-051000.202012132330_amd64.deb
    wget -c https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.10/amd64/linux-modules-5.10.0-051000-generic_5.10.0-051000.202012132330_amd64.deb
fi

# 5.11 Kernel
if [ "${VERSION}" == "5.11" ]; then
    wget -c https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.11/amd64/linux-headers-5.11.0-051100_5.11.0-051100.202102142330_all.deb
    wget -c https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.11/amd64/linux-headers-5.11.0-051100-generic_5.11.0-051100.202102142330_amd64.deb
    wget -c https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.11/amd64/linux-image-unsigned-5.11.0-051100-generic_5.11.0-051100.202102142330_amd64.deb
    wget -c https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.11/amd64/linux-modules-5.11.0-051100-generic_5.11.0-051100.202102142330_amd64.deb
fi

# 5.15 Kernel
if [ "${VERSION}" == "5.15" ]; then
    wget -c https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.15/amd64/linux-headers-5.15.0-051500_5.15.0-051500.202110312130_all.deb
    wget -c https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.15/amd64/linux-headers-5.15.0-051500-generic_5.15.0-051500.202110312130_amd64.deb
    wget -c https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.15/amd64/linux-image-unsigned-5.15.0-051500-generic_5.15.0-051500.202110312130_amd64.deb
    wget -c https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.15/amd64/linux-modules-5.15.0-051500-generic_5.15.0-051500.202110312130_amd64.deb
fi

sudo dpkg -i *.deb
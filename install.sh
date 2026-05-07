#!/bin/bash

# Update package
opkg update

#install packages
opkg install iptables iptables-mod-nat-extra redsocks 6in4 ipv6helper irqbalance luci-app-ttyd shellsync

#Then run this line
service redsocks stop && mv /etc/redsocks.conf /etc/redsocks.conf.bkp && cd /etc && wget https://github.com/IXWRT/BNET/raw/main/bdix.conf && mv /etc/init.d/redsocks /etc/init.d/redsocks.bkp && cd /etc/init.d && wget https://github.com/IXWRT/BNET/raw/main/bdix && chmod +x /etc/init.d/bdix

cd /
clear

service bdix enable

service bdix start

wget -O /tmp/aurora.ipk "https://github.com/eamonxg/luci-theme-aurora/releases/download/v0.11.0/luci-theme-aurora_0.11.0-r20260208_all.ipk" && opkg install /tmp/aurora.ipk && rm /tmp/aurora.ipk

echo -e "Thanks for installing & its Running Now."

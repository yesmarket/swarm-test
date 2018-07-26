#!/bin/bash
interface="/etc/sysconfig/network-scripts/ifcfg-$3"
cp "/vagrant/etc/sysconfig/network-scripts/test" "$interface"
sed -i 's/:ip/'"$1"'/g' "$interface"
sed -i 's/:netmask/'"$2"'/g' "$interface"
sed -i 's/:device/'"$3"'/g' "$interface"
sudo systemctl restart network.service

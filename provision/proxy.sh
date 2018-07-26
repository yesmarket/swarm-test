#!/bin/bash
if [ -n "$3" ]; then
   cp /vagrant/etc/environment /etc/environment
   sed -i 's/:proxy/'"$3"'/g' /etc/environment
   cp /vagrant/etc/systemd/system/docker.service.d/http-proxy.conf /etc/systemd/system/docker.service.d/http-proxy.conf
   sed -i 's/:proxy/'"$3"'/g' /etc/systemd/system/docker.service.d/http-proxy.conf
   sed '/\[main\]/a proxy='"$3" /etc/yum.conf
fi

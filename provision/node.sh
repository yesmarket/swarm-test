#!/bin/bash

# Install test version of docker engine, also shell completions
curl -fsSL https://test.docker.com/ | sh

# Add the vagrant user to the docker group
usermod -aG docker vagrant

# Configure the docker engine
# Daemon options: https://docs.docker.com/engine/reference/commandline/dockerd/
# Set both unix socket and tcp to make it easy to connect both locally and remote
# You can add TLS for added security (docker-machine does this automagically)
cp /vagrant/etc/docker/daemon.json /etc/docker/daemon.json

# You can't pass both CLI args and use the daemon.json for parameters,
# so I'm using the RPM systemd unit file because it doesn't pass any args
# This version changes the following as of 17.03:
#  - Removes Requires=docker.socket
#  - Removes docker.socket from After
#  - Sets LimitNOFILE=infinity
#  - Removes -H fd:// from ExecStart
systemctl daemon-reload
systemctl restart docker

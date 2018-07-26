# Swarm Test

## Pre-requisites

* PowerShell
* VirtualBox
* Vagrant

## Proxy settings

If you use a proxy server to access the internet, run the following from an elevated command prompt:

    [Environment]::SetEnvironmentVariable("HTTP_PROXY", ":proxy", "Machine")

where ":proxy" is the address of your proxy server.

## Usage

Run the following commands:

    > ./host-only-network-adapter.ps1
    > vagrant up
    > ./swarm-init.ps1

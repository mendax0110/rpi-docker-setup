#!/bin/bash

# Configure a static IP address for eth0 (Ethernet)
echo "Setting up static IP for eth0..."
echo "auto eth0" >> /etc/network/interfaces
echo "iface eth0 inet static" >> /etc/network/interfaces
echo "    address 192.168.1.100" >> /etc/network/interfaces
echo "    netmask 255.255.255.0" >> /etc/network/interfaces
echo "    gateway 192.168.1.1" >> /etc/network/interfaces

#!/bin/sh -x

# fix networking issue
printf '\nauto enp0s3\niface enp0s3 inet dhcp\n\n' >> /etc/network/interfaces


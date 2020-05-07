#!/bin/sh -x

# disable qxl
lsmod | grep "^qxl" > /dev/null
if [ $? -eq 0 ] ; then
    sudo sed -i 's/^GRUB_CMDLINE_LINUX_DEFAULT=\"\(.*\)\"/GRUB_CMDLINE_LINUX_DEFAULT=\"\1 qxl.modeset=0\"/g' /etc/default/grub
    sudo update-grub
fi


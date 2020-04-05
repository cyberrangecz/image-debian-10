# Debian-10-desktop-amd64

## Introduction

Debian 10.3 base image for KYPO and Vagrant built from ISO.

It contains Packer files for building Debian base image for QEMU and for VirtualBox/Vagrant.

## Requirements

* [packer](http://www.packer.io/downloads.html) (tested at 1.4.1)

### To run QEMU
* QEMU (tested at v 4.0.0)

### To run VirtualBox/Vagrant
* Python 3
* [VirtualBox 6](https://www.virtualbox.org/wiki/Download_Old_Builds_6_0)
* [Vagrant 2.2.5](https://www.vagrantup.com/downloads.html)

### Ubuntu:
```
sudo apt install qemu-kvm virt-manager virt-viewer libvirt-bin ebtables gir1.2-spiceclientgtk-3.0 libguestfs-tools python3 virtualbox vagrant
```

### MacOS:
```
brew install qemu
brew install packer
```
Note: `brew install qemu --with-sdl` or `brew install qemu --with-sdl2` is not supported anymore.

Note: Missing commands to install Python, VirtualBox and Vagrant.

## Info about the build

There is one user account in each image:

*  "debian" created by [cloud-init](https://cloudinit.readthedocs.io/en/latest/)
*  "vagrant" with password "vagrant" according to [vagrant documentation](https://www.vagrantup.com/docs/boxes/base.html#quot-vagrant-quot-user)

vagrant user is only created for the VirtualBox/Vagrant image and debian only for QEMU.

Password for debian user is disabled, use SSH keys instead.

SSH server is enabled.

## Usage

### QEMU

At Linux, add `"accelerator": "kvm"` to QEMU builder configuration in `debian.json`. 

```bash
# start the installation
packer build -only=debian-qemu debian.json
# run locally
qemu-system-x86_64 -accel kvm -m size=4096 target-qemu/debian
# run in OpenStack
# import image to OpenStack
openstack image create --file target-qemu/debian --property hw_scsi_model=virtio-scsi --property hw_disk_bus=scsi --property hw_rng_model=virtio --property hw_qemu_guest_agent=yes --property os_require_quiesce=yes --property os_type=linux --property os_distro=debian debian-10-amd64-v1
# create server on OpenStack
openstack server create --image b13b62af-6b6f-4f7c-a08b-fd7e0d263fe8 --flavor csirtmu.small2x4  debian
# get server console url
openstack console url show debian --spice
```

### VBox/Vagrant
```bash
# start the installation
packer build -only=debian-vbox debian.json
# add box to vagrant
vagrant box add --name debian.10 target-vbox/debian.box
```

Now `debian.10` can be used in Vagrantfile as a name of a box.

Note: Creating both boxes is possible using `packer build -parallel=false debian.json`

Note: In case downloading ISO fails with 404, iso_url in debian.json needs to be updated to newer version

## TODO

* make two Packer templates: one for Linux and the other for Mac (to handle OS-specific settings)
* [logging to console](https://docs.openstack.org/image-guide/openstack-images.html#ensure-image-writes-boot-log-to-console) to see boot logs in OpenStack
* tweak cloud-init config according to [OpenStack image requirements]https://docs.openstack.org/image-guide/openstack-images.html
* add swap partition on boot using [cloud-init](https://cloudinit.readthedocs.io/en/latest/topics/modules.html?highlight=swap#mounts)
* CI for building and storing the images? Each push to our lab git
repository will trigger a CI job that will build both QEMU and VMware and store
them on the GitLab server where user can download them via GitLab Web UI.

## Known Issues

* See Packer builder template for comments about building the images at MacOS.

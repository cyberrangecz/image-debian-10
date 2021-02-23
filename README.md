# Debian-10-server

## Introduction

This repo contains Packer files for building Debian 10.8 amd64 base image for QEMU/OpenStack and for VirtualBox/Vagrant.

Both images use interface naming of type `enp0s3`.

General requirement and instructions how to create and import created images to OpenStack/Vagrant are available in [wiki](https://gitlab.ics.muni.cz/muni-kypo-images/muni-kypo-images-wiki/-/wikis/image-packer).

## Image for QEMU/OpenStack

There is one user account:

*  `debian` created by [cloud-init](https://cloudinit.readthedocs.io/en/latest/)

## Image for VirtualBox/Vagrant

There is one user account:

*  `vagrant` with password `vagrant` 

## Known issues and requested features

See [issues](https://gitlab.ics.muni.cz/muni-kypo-images/debian-10/-/issues).


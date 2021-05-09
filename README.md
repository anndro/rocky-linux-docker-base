Rocky Linux Docker build scripts
===========================

This repository contains the kickstart files needed to build a Rocky Linux Docker container from scratch

## Necessary tools

 * lorax
 * anaconda-tui


## Build

In order to build the container, a rootfs tarball and Dockerfile are required.
We use lorax's livemedia-creator to create the rootfs tarball. You can run the
containerbuild.sh script, which will fetch the rpms from repo, create the rootfs, and
generate a Dockerfile for you.

After you've run this command, your rootfs tarball and Dockerfile will be
waiting for you in `/var/tmp/containers/<datestamp>/`

--
```bash
# sudo ./containerbuild.sh rocky-8.ks
```
--

## Usage

From here, you can either import the docker container via

```
cat centos-version-docker.tar.xz | docker import - container-name
```

Or you can create a Dockerfile to build the image directly in docker.

```
FROM scratch
MAINTAINER you<your@email.here> - ami_creator
ADD centos-version-docker.tar.xz /
```

## Forked From

https://github.com/CentOS/sig-cloud-instance-build/tree/master/docker
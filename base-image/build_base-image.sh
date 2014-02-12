#!/bin/bash
image="skurtzemann/base-image"
suite="precise"
packages="iproute,iputils-ping,vim,less,openssh-server,net-tools,psmisc,file"
mirror="http://nl.archive.ubuntu.com/ubuntu/"

./mkimage-debootstrap.sh -z -i "$packages" "$image" "$suite" "$mirror"
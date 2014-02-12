#!/bin/bash

log() {
	echo -e "\033[34m*** post-debootstrap.sh: "$1" ***\033[0m"
}

# set locale
log "[config] set locale"
locale-gen fr_FR.UTF-8
cat << EOF | tee /etc/environment
export LANG=fr_FR.UTF-8
export LANGUAGE=fr_FR.UTF-8 
EOF
source /etc/environment

# set timezone
log "[config] set timezone"
rm /etc/localtime && ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime


# install additionnal packages
export DEBIAN_FRONTEND=noninteractive
log "[apt] install additionnal packages"
apt-get update
apt-get install htop supervisor -y

# install salt-minion
log "[apt] install salt-minion"
apt-get install python-software-properties -y
add-apt-repository ppa:saltstack/salt -y
apt-get update
apt-get install salt-minion -y

# upgrade the system
log "[apt] upgrade the system"
apt-get upgrade -y

# add the salt minion preseed keys
log "[salt] copy the minion ssh keys"
cp /tmp/files/minion_docker.* /etc/salt/pki/minion/
ln -s /etc/salt/pki/minion/minion_docker.pem /etc/salt/pki/minion/minion.pem
ln -s /etc/salt/pki/minion/minion_docker.pub /etc/salt/pki/minion/minion.pub
# run a salt config
log "[salt] run the salt state 'docker.first_run"
salt-call -l warning --master=wiki.kurtzemann.fr --id=docker state.highstate


# additionnal config form openssh
mkdir -p /var/run/sshd

#!/usr/bin/env bash
set -eux
set -o pipefail

# The sleep 30 in the example above is very important.
# Because Packer is able to detect and SSH into the instance as soon as SSH is
# available, Ubuntu actually doesn't get proper amounts of time to initialize.
# The sleep makes sure that the OS properly initializes.
sleep 30
sudo add-apt-repository -y ppa:webupd8team/java
sudo apt-get upgrade -y
sudo apt-get update -y

sudo apt-get -y install git curl libcurl3 bridge-utils bundler unzip wget python-setuptools python-protobuf cgroup-bin ruby1.9.1
sudo easy_install pip
sudo pip install docker-py==1.1.0

# install java8
echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
sudo apt-get install -y oracle-java8-installer

cat << EOF > /etc/security/limits.conf
* soft nofile 64000
* hard nofile 64000
root soft nofile 64000
root hard nofile 64000
EOF

cat << EOF > /etc/sysctl.d/60-network.conf
fs.file-max = 100000

# Increase the ipv4 port range:
net.ipv4.ip_local_port_range = 1024 65535

# General gigabit tuning:
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216
net.ipv4.tcp_rmem = 4096 87380 16777216
net.ipv4.tcp_wmem = 4096 65536 16777216
net.ipv4.tcp_syncookies = 1

# This gives the kernel more memory for tcp which you need with many (100k+) open socket connections
net.ipv4.tcp_mem = 50576 64768 98152
net.core.netdev_max_backlog = 2500
EOF

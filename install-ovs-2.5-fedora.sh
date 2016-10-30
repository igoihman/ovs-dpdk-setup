#!/bin/bash

cd /usr/src/
git clone https://github.com/openvswitch/ovs.git
cd ovs
git checkout branch-2.5
./boot.sh
./configure
cp openvswitch-2.5.2.tar.gz $HOME/rpmbuild/SOURCES
rpmbuild -bb --with dpdk --without check rhel/openvswitch-fedora.spec

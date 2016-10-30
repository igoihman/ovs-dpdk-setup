#!/bin/bash

cd /usr/src/
git clone https://github.com/openvswitch/ovs.git
cd ovs
git checkout branch-2.5
./boot.sh
./configure
cp openvswitch-2.5.2.tar.gz $HOME/rpmbuild/SOURCES
rpmbuild -bb --with dpdk --without check rhel/openvswitch-fedora.spec

# DB creation
mkdir -p /usr/local/etc/openvswitch
mkdir -p /usr/local/var/run/openvswitch
rm /usr/local/etc/openvswitch/conf.db
ovsdb-tool create /usr/local/etc/openvswitch/conf.db  \
	/usr/local/share/openvswitch/vswitch.ovsschema

# start ovs-db server, no ssl support
ovsdb-server --remote=punix:/usr/local/var/run/openvswitch/db.sock \
	--remote=db:Open_vSwitch,Open_vSwitch,manager_options \
	--pidfile --detach

# init DB
ovs-vsctl --no-wait init

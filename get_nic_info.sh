#!/bin/bash
if [ "$#" -ne 1 ]; then
	echo "illegal args number"
	exit 1 
fi

INTERFACE=$1

NUMA_ID=`cat /sys/class/net/"$INTERFACE"/device/numa_node`
CPU_LIST=`cat /sys/class/net/"$INTERFACE"/device/local_cpulist`
DRIVER=`readlink /sys/class/net/"$INTERFACE"/device/driver/module`
if [ $DRIVER ]; then
	DRIVER=`echo $DRIVER | rev | cut -d/ -f1 | rev`
fi
echo numa id: "$NUMA_ID", local cpu list: "$CPU_LIST", driver: "$DRIVER"


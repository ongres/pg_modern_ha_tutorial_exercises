#!/bin/bash


DEVICE=/dev/sdb
MOUNT_POINT=/var/postgresql


mkfs.xfs $DEVICE
mount $MOUNT_POINT



function instance_metadata() {
	curl -s -H "Metadata-Flavor: Google" http://metadata.google.internal/computeMetadata/v1/instance/$1
}

function instance_metadata_kv() {
	instance_metadata attributes/$1
}


name=`instance_metadata_kv template-name`
my_ip=`instance_metadata network-interfaces/0/ip`
etcd_host=`instance_metadata_kv etcd-host`
sed -i "s+__INSTANCE_NAME__+$name+" /etc/patroni/postgres.yml
sed -i "s+__INSTANCE_IP__+$my_ip+" /etc/patroni/postgres.yml
sed -i "s+__ETCD_HOST__+$etcd_host+" /etc/patroni/postgres.yml

systemctl daemon-reload
service patroni start

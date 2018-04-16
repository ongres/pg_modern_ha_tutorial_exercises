#!/bin/bash


function instance_metadata() {
	curl -s -H "Metadata-Flavor: Google" http://metadata.google.internal/computeMetadata/v1/instance/$1
}

function instance_metadata_kv() {
	instance_metadata attributes/$1
}


name=`instance_metadata_kv template-name`
my_ip=`instance_metadata network-interfaces/0/ip`
etcd_cluster=`instance_metadata_kv etcd-cluster`
sed -i "s+__NAME__+$name+" /etc/systemd/system/etcd.service
sed -i "s+__MY_IP__+$my_ip+" /etc/systemd/system/etcd.service
sed -i "s+__ETCD_INITIAL_CLUSTER__+$etcd_cluster+" /etc/systemd/system/etcd.service

systemctl daemon-reload
service etcd restart

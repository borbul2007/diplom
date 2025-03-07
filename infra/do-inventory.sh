#!/bin/bash

echo "[kube_control_plane]" > inventory.ini
echo "" >> inventory.ini
for i in 0 1 2 ; do
        echo "node$((${i}+1)) ansible_host=$(terraform output -json k8s_master_nodes_public_ips | jq -j ".[${i}]") ip=$(terraform output -json k8s_master_nodes_private_ips | jq -j ".[${i}]") etcd_member_name=etcd1"  >> inventory.ini
done
echo "" >> inventory.ini
echo "[etcd:children]" >> inventory.ini
echo "kube_control_plane" >> inventory.ini
echo "" >> inventory.ini
echo "[kube_node]" >> inventory.ini
for i in 0 1 ; do
        echo "node$((${i}+4)) ansible_host=$(terraform output -json k8s_worker_nodes_public_ips | jq -j ".[${i}]") ip=$(terraform output -json k8s_worker_nodes_private_ips | jq -j ".[${i}]")" >> inventory.ini
done

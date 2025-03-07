#!/bin/bash

echo "[kube_control_plane]" > inventory.ini
echo "" >> inventory.ini
for i in 1 2 3; do
  echo "node${i} ansible_host=$(terraform output -json k8s_master_nodes_public_ips | jq -j ".[${i}-1]") ip=$(terraform output -json k8s_master_nodes_private_ips | jq -j ".[${i}-1]") etcd_member_name=etcd1"  >> inventory.ini
done
echo "" >> inventory.ini
echo "[etcd:children]" >> inventory.ini
echo "kube_control_plane" >> inventory.ini
echo "" >> inventory.ini
echo "[kube_node]" >> inventory.ini
for i in 4 5 ; do
  echo "node${i} ansible_host=$(terraform output -json k8s_worker_nodes_public_ips | jq -j ".[${i}-1]") ip=$(terraform output -json k8s_worker_nodes_private_ips | jq -j ".[${i1-1}]")" >> inventory.ini
done

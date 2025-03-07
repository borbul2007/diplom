#!/bin/bash

echo -e "[kube_control_plane]\n" > inventory.ini
for i in 0 1 2 ; do
  echo "node$((${i}+1)) ansible_host=$(terraform output -json k8s_master_nodes_public_ips | jq -j ".[${i}]") ip=$(terraform output -json k8s_master_nodes_private_ips | jq -j ".[${i}]") etcd_member_name=etcd1"  >> inventory.ini
done
echo -e "\n[etcd:children]\nkube_control_plane\n\n[kube_node]" >> inventory.ini
for i in 0 1 ; do
  echo "node$((${i}+4)) ansible_host=$(terraform output -json k8s_worker_nodes_public_ips | jq -j ".[${i}]") ip=$(terraform output -json k8s_worker_nodes_private_ips | jq -j ".[${i}]")" >> inventory.ini
done

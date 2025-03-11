#!/bin/bash

#python3 -m venv venv && source ./venv/bin/activate && pip3 install -r requirements.txt
#cp -rfp ./inventory/sample ./inventory/k8s
echo -e "[kube_control_plane]\n" > ./inventory/k8s/inventory.ini
for i in 0 1 2 ; do
  echo "node$((${i}+1)) ip=$(terraform output -json k8s_master_nodes_private_ips | jq -j ".[${i}]") etcd_member_name=etcd1"  >> inventory.ini
done
echo -e "\n[etcd:children]\nkube_control_plane\n\n[kube_node]" >> inventory.ini
for i in 0 1 ; do
  echo "node$((${i}+4)) ip=$(terraform output -json k8s_worker_nodes_private_ips | jq -j ".[${i}]")" >> inventory.ini
done

#cd ~/kubespray
#ansible-playbook -i ./inventory/k8s/ -u $USERNAME -b -v --private-key ~/keys/id_ed25519 cluster.yml
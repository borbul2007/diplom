#!/bin/bash

python3 -m venv venv && source ./venv/bin/activate
git clone https://github.com/kubernetes-sigs/kubespray.git /home/ubuntu/kubespray
cp -rfp ~/kubespray/inventory/sample ~/kubespray/inventory/k8s

echo -e "[kube_control_plane]\n" > ~/kubespray/inventory/k8s/inventory.ini
for i in 0 1 2 ; do
  echo "k8s-master-node$((${i}+1)) ip=$(terraform output -json k8s_master_nodes_private_ips | jq -j ".[${i}]") etcd_member_name=etcd1"  >> ~/kubespray/inventory/k8s/inventory.ini
done
echo -e "\n[etcd:children]\nkube_control_plane\n\n[kube_node]" >> ~/kubespray/inventory/k8s/inventory.ini
for i in 0 1 ; do
  echo "k8s-worker-node$((${i}+4)) ip=$(terraform output -json k8s_worker_nodes_private_ips | jq -j ".[${i}]")" >> ~/kubespray/inventory/k8s/inventory.ini
done

cd ~/kubespray
pip3 install -r requirements.txt
ansible-playbook -i ~/kubespray/inventory/k8sinventory.ini -u ubuntu -b -v --private-key ~/keys/id_ed25519 cluster.yml
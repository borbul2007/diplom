#!/bin/bash

cd ~/diplom/infra
echo -e "[kube_control_plane]\n" > ./resources/inventory.ini
for i in 0 1 2 ; do echo "k8s-master-node-$((${i}+1)) ip=$(terraform output -json k8s_master_nodes_private_ips | jq -j ".[${i}]") etcd_member_name=etcd$((${i}+1))"  >> ./resources/inventory.ini; done
echo -e "\n[etcd:children]\nkube_control_plane\n\n[kube_node]" >> ./resources/inventory.ini
for i in 0 1 ; do echo "k8s-worker-node-$((${i}+1)) ip=$(terraform output -json k8s_worker_nodes_private_ips | jq -j ".[${i}]")" >> ./resources/inventory.ini; done

cd ~
python3 -m venv venv && source ./venv/bin/activate
git clone https://github.com/kubernetes-sigs/kubespray.git /home/ubuntu/kubespray
cp -rfp ~/kubespray/inventory/sample ~/kubespray/inventory/mycluster && cp -rfp ~/diplom/infra/resources/inventory.ini ~/kubespray/inventory/mycluster
cp -rfp ~/diplom/infra/resources/0040-verify-settings.yml /home/ubuntu/kubespray/roles/kubernetes/preinstall/tasks/0040-verify-settings.yml

cd ~/kubespray
pip3 install -r requirements.txt
ansible-playbook -i ~/kubespray/inventory/mycluster/inventory.ini -u ubuntu -b -v --private-key ~/keys/id_ed25519 cluster.yml
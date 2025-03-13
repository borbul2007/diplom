# Terraform Manifest
----
## On localhost (https://yandex.cloud/ru/docs/cli/quickstart)
yc init (see URL!)
yc iam key create --service-account-name nt-terraform --output key.json && mv ~keys/nt-terraform.json

cd ~/diplom && git clone https://github.com/borbul2007/diplom.git

cd ~/diplom/zero-step
terraform init && terraform apply -auto-approve
./do_jump-host.sh

## On jump host
cd ~/diplom/infra
terraform init -backend-config=${ACCESS_KEY} -backend-config=${SECRET_KEY} && terraform apply -auto-approve
./do_k8s-cluster.sh



echo "export PUBLIC_IP=$(terraform output jump-host_public_ip)" >> resources/.profile
ssh -i ~/keys/id_ed25519 ubuntu@k8s-master-node-1 -c "USERNAME=$(whoami); sudo chown -R $USERNAME:$USERNAME /etc/kubernetes/admin.conf"

#USERNAME=$(whoami); sudo chown -R $USERNAME:$USERNAME /etc/kubernetes/admin.conf
#exit


mkdir~/.kube scp -i ~/keys/id_ed25519 ubuntu@k8s-master-node-1:/etc/kubernetes/admin.conf ~/.kube/config
kubectl get pods --all-namespaces

##git clone -b release-2.24 https://github.com/kubernetes-sigs/kubespray.git
##vi /home/ubuntu/kubespray/roles/kubernetes/preinstall/tasks/0040-verify-settings.yml
##kubectl top nodes
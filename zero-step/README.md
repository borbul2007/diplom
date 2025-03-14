# Terraform Manifest
----

## On jump host
cd ~/diplom/infra
terraform init -backend-config=${ACCESS_KEY} -backend-config=${SECRET_KEY} && terraform apply -auto-approve
./do_k8s-cluster.sh


##git clone -b release-2.24 https://github.com/kubernetes-sigs/kubespray.git
##vi /home/ubuntu/kubespray/roles/kubernetes/preinstall/tasks/0040-verify-settings.yml
##kubectl top nodes
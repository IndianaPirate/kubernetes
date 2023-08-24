#!/bin/bash

sudo apt-get update && sudo apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

sudo apt-get update -y
sudo apt-get install -y kubelet=1.28.0-00 kubeadm=1.28.0-00 kubectl=1.28.0-00 
sudo apt-mark hold kubelet kubeadm kubectl
config=$(hostname)

if [ config == "master" ]; then
  mkdir -p ~/.kube
  sudo cp -i /etc/kubernetes/admin.conf ~/.kube/config
  sudo chown -R vagrant:vagrant ~/.kube/
fi

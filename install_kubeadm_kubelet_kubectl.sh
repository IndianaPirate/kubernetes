#!/bin/bash

GREEN='\033[0;32m'
config=$(hostname)

function install_kubectl_kubeadm_kubelet(){
  echo -e "${GREEN}INSTALL KUBEADM KUBELET KUBECTL${GREEN}"
  sudo apt-get update && sudo apt-get install -y apt-transport-https curl
  curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
  cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
  deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

  sudo apt-get update -y
  sudo apt-get install -y kubelet=1.28.0-00 kubeadm=1.28.0-00 kubectl=1.28.0-00 
  sudo apt-mark hold kubelet kubeadm kubectl
}

# Install kubectl kubeadm kubelet
install_kubectl_kubeadm_kubelet


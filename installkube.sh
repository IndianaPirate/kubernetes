#!/bin/bash

config=$(hostname)
function create_kube_directory(){
  if [ $config == "master" ]; then
    mkdir -p ~/.kube
    sudo cp -i /etc/kubernetes/admin.conf ~/.kube/config
    sudo chown -R vagrant:vagrant ~/.kube/
  fi
}

function install_weave_net(){
  if [ $hostnam == "master" ]; then
    kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml
  fi
}

function install_kubectl_kubeadm_kubelet(){
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

# Create .kube directory
create_kube_directory

# Install weave net in master node only
install_weave_net

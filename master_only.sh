#!/bin/bash

GREEN='\033[0;32m'
config=$(hostname)

function initiate_cluster() {
  echo -e "${GREEN} INITIATE CLUSTER ${GREEN}"
  sudo kubeadm init
}
function create_kube_directory(){
  if [ $config == "master" ]; then
    echo -e "${GREEN}CREATE .KUBE DIRECTORY${GREEN}"
    mkdir -p ~/.kube
    sudo cp -i /etc/kubernetes/admin.conf ~/.kube/config
    sudo chown -R vagrant:vagrant ~/.kube/
  fi
}

function install_weave_net(){
  if [ $config == "master" ]; then
    echo -e "${GREEN}INSTALL WEAVE NET${GREEN}"
    kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml
  fi
}
create_kube_directory
install_weave_net

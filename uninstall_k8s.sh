#!/bin/bash

function uninstall_k8s(){
  echo "UNINSTALL KUBERNETES"
  kubeadm reset
  sudo apt-get purge kubeadm kubectl kubelet kubernetes-cni kube*   
  sudo apt-get autoremove  
  sudo rm -rf ~/.kube
}
uninstall_k8s

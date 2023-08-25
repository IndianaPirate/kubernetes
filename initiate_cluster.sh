#!/bin/bash

GREEN='\033[0;32m'
function initiate_cluster() {
  echo -e "${GREEN} INITIATE CLUSTER ${GREEN}"
  sudo kubeadm init
}
initiate_cluster

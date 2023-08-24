#!/bin/bash

function initiate_cluster() {
  echo -e "${GREEN} INITIATE CLUSTER ${GREEN}"
  sudo kubeadm init
}
initiate_cluster

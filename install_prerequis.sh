#!/bin/bash

GREEN='\033[0;32m'

function deactivate_swap(){
  echo "${GREEN}DEACTIVATE SWAP${GREEN}"
  sudo swapoff -a
}
function firewall(){
  echo - "${GREEN}FIREWALL UFW${GREEN}"
  sudo apt update -y
  sudo apt install ufw -y
  sudo ufw enable
  hostnam=$(hostname)
  if [ "$hostnam" == "master" ]; then
    sudo ufw allow 2222/tcp
    sudo ufw allow 22/tcp
    sudo ufw allow 8080/tcp
    sudo ufw allow 80/tcp
    sudo ufw allow 443/tcp
    sudo ufw allow 10248/tcp
    
    sudo ufw allow 6443/tcp
    sudo ufw allow 2379:2380/tcp
    sudo ufw allow 10250/tcp
    sudo ufw allow 10251/tcp
    sudo ufw allow 10252/tcp
    sudo ufw allow 6783/tcp
  else
    sudo ufw allow 2222/tcp
    sudo ufw allow 22/tcp
    sudo ufw allow 8080/tcp
    sudo ufw allow 80/tcp
    sudo ufw allow 443/tcp
    
    sudo ufw allow 10250/tcp
    sudo ufw allow 30000:32767/tcp
    sudo ufw allow 6783/tcp
  fi
}

function install_containerd(){
  echo -e "${GREEN}INSTALL CONTAINERD${GREEN}"
  sudo apt-get  update -y
  sudo apt-get install containerd -y
}

function configure_containerd(){
  echo -e "${GREEN}CONFIGURE CONTAINERD${GREEN}"
  sudo mkdir  -p  /etc/containerd
  containerd config default  | sudo tee /etc/containerd/config.toml
}

function restart_containerd(){
  echo -e "${GREEN}RESTART CONTAINERD${GREEN}"
  sudo systemctl restart containerd
  service containerd status
}

function modules(){
  echo -e "${GREEN}MODULES${GREEN}"
  cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
  overlay
  br_netfilter
EOF
  
  sudo modprobe overlay
  sudo modprobe br_netfilter
  
  # sysctl params required by setup, params persist across reboots
  cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
  net.bridge.bridge-nf-call-iptables  = 1
  net.bridge.bridge-nf-call-ip6tables = 1
  net.ipv4.ip_forward                 = 1
EOF

  # Apply sysctl params without reboot
  sudo sysctl --system
}

deactivate_swap

firewall

modules

install_containerd

configure_containerd

restart_containerd

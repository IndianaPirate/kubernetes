#!/bin/bash

sudo apt update -y
sudo apt install ufw -y
sudo ufw enable
hostnam=$(hostname)
if [ hostnam == "master" ]; then
  sudo ufw allow 6443/tcp
  sudo ufw allow 2379:2380/tcp
  sudo ufw allow 10250/tcp
  sudo ufw allow 10251/tcp
  sudo ufw allow 10252/tcp
  sudo ufw allow 6783/tcp
else
  sudo ufw allow 10250/tcp
  sudo ufw allow 30000:32767/tcp
  sudo ufw allow 6783/tcp
fi

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

sudo apt-get  update -y
sudo apt-get install containerd -y

sudo mkdir  -p  /etc/containerd
containerd config default  | sudo tee /etc/containerd/config.toml

sudo systemctl restart containerd
service containerd status

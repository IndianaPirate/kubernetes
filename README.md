# KUBERNETES

### DEPLOIEMENT DE CLUSTER K8S
- Il faut suive ces étapes pour déployer le cluster
1. chmod +x *.sh 
2. ./install_prerequis.sh ( Dans le master et worker )
3. ./install_kubeadm_kubelet_kubectl.sh ( Dans le master et worker )
4. ./initiate_cluster.sh ( Dans le master seulement)
5. ./create_kube_dir_install_weave_net.sh ( Dans le master seulement)
### POUR SUPRIMMER KUBERNETES
1. ./uninstall_k8s.sh
### RESET PAREFEU UFW
1. reset_ufw_rules.sh


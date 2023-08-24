# KUBERNETES

### EXECUTE CE SCRIPT DANS LE MASTER ET WORKER NODE
- Il faut suive ces étapes pour déployer le cluster
1. chmod +x *.sh 
2. ./install.sh ( Dans le master et worker )
3. ./installkube.sh ( Dans le master et worker )
4. ./initiate_cluster.sh ( Dans le master seulement)
5. ./master_only.sh ( Dans le master seulement)
### POUR SUPRIMMER KUBERNETES
1. ./uninstall_k8s.sh
### RESET PAREFEU UFW
1. reset_ufw_rules.sh


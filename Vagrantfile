# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANT_BOX         = "debian/bullseye64"
CPUS_MASTER_NODE    = 2
CPUS_WORKER_NODE    = 1
MEMORY_MASTER_NODE  = 2048
MEMORY_WORKER_NODE  = 2048
WORKER_NODES_COUNT  = 1


Vagrant.configure(2) do |config|
  # Kubernetes Master Server
  config.vm.define "master" do |node|
  
    node.vm.box               = VAGRANT_BOX
    node.vm.box_check_update  = false
    node.vm.hostname          = "master"
    node.vm.provider :libvirt do |v|
      v.memory  = MEMORY_MASTER_NODE
      v.nested  = true
      v.cpus    = CPUS_MASTER_NODE
    end
  
  end


  # Kubernetes Worker Nodes
  (1..WORKER_NODES_COUNT).each do |i|

    config.vm.define "worker#{i}" do |node|

      node.vm.box               = VAGRANT_BOX
      node.vm.box_check_update  = false
      node.vm.hostname          = "worker#{i}"
      node.vm.provider :libvirt do |v|
        v.memory  = MEMORY_WORKER_NODE
        v.nested  = true
        v.cpus    = CPUS_WORKER_NODE
      end


    end

  end

end

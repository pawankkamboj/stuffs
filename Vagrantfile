# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.box = "centos/7"
    config.ssh.insert_key = false
    config.vm.provider "virtualbox" do |v|
        v.memory = 4000
        v.cpus = 4
    end

    config.vm.box_check_update = false
	
    config.vm.define "bgp" do |node|
		node.vm.network "private_network", ip: "192.168.50.60"
		node.vm.network "private_network", ip: "10.1.100.100"
		node.vm.hostname = "bgp"
		
		node.vm.provision :shell, inline: "cat /vagrant/ssh-key.pub >> .ssh/authorized_keys"
	end
end

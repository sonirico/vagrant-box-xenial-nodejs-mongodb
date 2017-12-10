# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "ubuntu/xenial64"
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "private_network", ip: "172.16.0.100"
  config.vm.synced_folder "../app", "/home/vagrant/app"
  config.vm.provision "shell", path: "./provision.sh"

  config.vm.provider :virtualbox do |vb|
        vb.name = "MERN App"
        vb.memory = 2048
        vb.cpus = 2
  end
end

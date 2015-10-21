# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.box = "ericmann/trusty64"

  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network "forwarded_port", guest: 80, host: 4524

  # Update args to the username you wish to be generated for Workspace
  config.vm.provision :shell, path: "bootstrap.sh", args: "orion"

  #Project folder sync - update Owner to match user args above
  config.vm.synced_folder "./projects", "/projects", owner: "orion", group: "orion", smb_username: "", smb_password: ""

  config.vm.provider "hyperv" do |v, override|
    v.memory = 1024
  end

end

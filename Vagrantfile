Vagrant.configure(2) do |config|
  config.vm.define "target" do |node|
        node.vm.box = "centos7.2"
        node.vm.hostname = "target"
        node.vm.network :private_network, ip: "192.168.100.20"
        node.vm.network :forwarded_port, id: "ssh", guest: 22, host: 2220
        node.vm.provision :shell, :inline => "sudo yum install -y vim"
		node.vm.provision :shell, :inline => "sudo echo hogehoge | passwd --stdin root"
  end
  config.vm.define "controller" do |node|
        node.vm.box = "centos7.2"
        node.vm.hostname = "controller"
        node.vm.network :private_network, ip: "192.168.100.10"
        node.vm.network :forwarded_port, id: "ssh", guest: 22, host: 2210
        node.vm.provision "file", source: "~/.ssh/id_rsa", destination: ".ssh/id_rsa"
        node.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: ".ssh/id_rsa.pub"
        node.vm.provision "file", source: "~/.vimrc", destination: ".vimrc"
        node.vm.provision "file", source: "~/.gitconfig", destination: ".gitconfig"
        node.vm.provision :shell, :inline => "sudo yum install -y vim ansible git"
        node.vm.provision :shell, :inline => "sudo curl -sL https://bootstrap.pypa.io/get-pip.py | python"
        node.vm.provision :shell, :inline => "sudo pip install pywinrm"
  end
end

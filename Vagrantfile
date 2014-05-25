Vagrant.configure("2") do |config|
  config.vm.box = "canonical-ubuntu-12.04"
  config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/precise/current/precise-server-cloudimg-amd64-vagrant-disk1.box"

  config.vm.define "node1"
  config.vm.define "node2"

  config.sh.after_share_folders = "free"
end

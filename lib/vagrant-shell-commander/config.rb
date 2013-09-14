module VagrantShellCommander
  class Config < Vagrant.plugin("2", "config")
    attr_accessor :sh
  end
end

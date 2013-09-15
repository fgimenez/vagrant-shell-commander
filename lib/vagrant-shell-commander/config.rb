module VagrantShellCommander
  # Configuration options
  class Config < Vagrant.plugin("2", "config")
    attr_accessor :after_boot

    # Initialize override, setting config options default values
    # for merging
    def initialize
      super

      @after_boot = UNSET_VALUE
    end

    # finalize! override, unseting config options
    def finalize!
      @after_boot = nil if @after_boot == UNSET_VALUE
    end
  end
end

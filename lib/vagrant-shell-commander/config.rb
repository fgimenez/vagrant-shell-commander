module VagrantPlugins
  module ShellCommander
    # Configuration options
    class Config < Vagrant.plugin("2", "config")
      attr_accessor :after_share_folders
      
      # Initialize override, setting config options default values
      # for merging
      def initialize
        super
        
        @after_share_folders = UNSET_VALUE
      end
      
      # finalize! override, unseting config options
      def finalize!
        @after_share_folders = nil if @after_share_folders == UNSET_VALUE
      end
    end
  end
end

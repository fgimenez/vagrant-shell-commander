module VagrantShellCommander
  # Main plugin command
  class Command < Vagrant.plugin("2", "command")
    def execute
      opts = define_cli_options

      0
    end

    private
    def define_cli_options
      block = lambda do |parser|
        parser.banner = 'Usage: vagrant command --cmd[=CMD] --cwd[=CWD] [MACHINE]'
      end

      OptionParser.new(&block)
    end
  end
end

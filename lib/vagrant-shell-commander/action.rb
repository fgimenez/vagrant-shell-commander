require "log4r"

module VagrantPlugins
  module ShellCommander
    # Action for shell command hooking
    class Action
      include Vagrant::Action::Builtin

      # Constructor
      #
      # @param app [Action] Next middleware to call
      # @param env [Hash] Action environment
      # @return nil
      #
      def initialize(app, env)
        @app       = app
        @env       = env
        @logger    = Log4r::Logger.new("vagrant::plugins::shell-commander::action")
      end
      
      # Call method of this middleware
      #
      # @param env [Hash] Action environment
      # @return nil
      #
      def call(env)
        @logger.debug("hook fired for action #{@env[:action_name]}, machine_action: #{@env[:machine_action]}")
        @app.call(env)
        if @env[:machine] && @env[:machine].state.id != :poweroff &&
           ! @env[:machine].config.sh.after_share_folders.nil?
          @env[:machine].action(:ssh_run, 
                                ssh_run_command: @env[:machine].config.sh.after_share_folders,
                                ssh_opts: {extra_args: []})
        end
      end
    end
  end
end

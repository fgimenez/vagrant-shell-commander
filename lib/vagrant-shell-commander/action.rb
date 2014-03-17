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
        @app = app
        @machine = env[:machine]
      end
      
      # Call method of this middleware
      #
      # @param env [Hash] Action environment
      # @return nil
      #
      def call(env)
        @app.call(env)
        unless env[:machine].config.sh.after_share_folders.nil?
          @machine.action(:ssh_run, 
                          ssh_run_command: env[:machine].config.sh.after_share_folders,
                          ssh_opts: {extra_args: []})
        end
      end
    end
  end
end

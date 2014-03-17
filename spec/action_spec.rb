require 'spec_helper'

describe VagrantPlugins::ShellCommander::Action do
  let(:app) {double(call: true)}
  let(:machine) {double(action: true)}
  let(:env) {double(:[] => machine)}
  let(:cmd) {'cmd'}
  let(:sh) {double(after_share_folders: cmd)}
  let(:config) {double(sh: sh)}
  let(:machine_env) {double(config: config)}
  let(:action_env) {{machine: machine_env}}
  let(:subject) {described_class.new(app, env)}

  describe "#call" do
    it "should call the next middleware" do
      expect(app).to receive(:call).with(action_env)

      subject.call(action_env)
    end

    describe "SSHRun call" do
      it "should call SSHRun action of the current machine with the after_boot option as command" do
        allow(env).to receive(:[]).with(:machine).and_return(machine)
        
        expect(machine).to receive(:action).with(:ssh_run, ssh_run_command: cmd, ssh_opts: {:extra_args=>[]})

        subject.call(action_env)
      end
      
      it "should not call SSHRun action if after_boot option is nil" do
        sh = double(after_share_folders: nil)
        config = double(sh: sh)
        machine_env = double(config: config)
        action_env = {machine: machine_env}
        
        expect(machine).not_to receive(:action)

        subject.call(action_env)
      end
    end
  end
end

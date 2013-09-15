require 'spec_helper'

describe VagrantShellCommander::Action do
  let(:app) {double(call: true)}
  let(:machine) {double(action: true)}
  let(:env) {double(:[] => machine)}
  let(:cmd) {'cmd'}
  let(:sh) {double(after_share_folders: cmd)}
  let(:global_config) {double(sh: sh)}
  let(:action_env) {{global_config: global_config}}
  let(:subject) {described_class.new(app, env)}

  describe "#call" do
    after(:each) do
      subject.call(action_env)
    end

    it "should call the next middleware" do
      expect(app).to receive(:call).with(action_env)
    end

    it "should call SSHRun action of the current machine with the after_boot option as command" do
      allow(env).to receive(:[]).with(:machine).and_return(machine)
      
      expect(machine).to receive(:action).with(:ssh_run, ssh_run_command: cmd)
    end
  end
end

require 'spec_helper'

describe VagrantShellCommander::Plugin do
  it 'should have a name' do
    expect(described_class.name).not_to be_nil
  end

  it "should define a command of type Command" do
    default_command = described_class.command.
      to_hash[:"sh"]
    expect(default_command).to be(VagrantShellCommander::Command)
  end

  it "should define a config of type Config" do
    default_config = described_class.components.configs[:top].to_hash[:"sh"]
    expect(default_config).to be(VagrantShellCommander::Config)
  end
=begin  
  context 'action hooks' do
    let(:hook) {double(append: true, prepend: true)}

    before(:all) do
      expect(subject).to receive(:action_hook).and_yield hook
    end

    it "should define an action hook for machine_action_up" do
      expect(hook).to receive(:append).with(VagrantShellCommander::ShAction)
    end
  end
=end
end

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

end

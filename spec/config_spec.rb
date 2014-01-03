require 'spec_helper'

describe VagrantPlugins::ShellCommander::Config do

  let(:subject) {described_class.new}

  describe 'config properies' do
    it 'should have a after_share_folders attr_accessor' do
      expect(subject).to respond_to(:after_share_folders)
      expect(subject).to respond_to(:after_share_folders=)
    end
  end

  describe "#initialize" do
    it 'should initialize after_share_folders' do
      expect(subject.after_share_folders).to be_equal(Vagrant::Plugin::V2::Config::UNSET_VALUE)
    end
  end

  describe "#finalize!" do
    it 'should deinitialize after_share_folders if it has been set' do
      config = described_class.new
      config.finalize!
      expect(config.after_share_folders).to be_nil
    end

    it 'should not deinitialize after_share_folders if it has not been set' do
      config = described_class.new
      config.after_share_folders = 'value'
      config.finalize!
      expect(config.after_share_folders).to eq('value')
    end

  end
end

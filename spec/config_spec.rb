require 'spec_helper'

describe VagrantShellCommander::Config do

  let(:subject) {described_class.new}

  describe 'config properies' do
    it 'should have a after_boot attr_accessor' do
      expect(subject).to respond_to(:after_boot)
      expect(subject).to respond_to(:after_boot=)
    end
  end

  describe "#initialize" do
    it 'should initialize after_boot' do
      expect(subject.after_boot).to be_equal(Vagrant::Plugin::V2::Config::UNSET_VALUE)
    end
  end

  describe "#finalize!" do
    it 'should deinitialize after_boot if it has been set' do
      config = described_class.new
      config.finalize!
      expect(config.after_boot).to be_nil
    end

    it 'should not deinitialize after_boot if it has not been set' do
      config = described_class.new
      config.after_boot = 'value'
      config.finalize!
      expect(config.after_boot).to eq('value')
    end

  end
end

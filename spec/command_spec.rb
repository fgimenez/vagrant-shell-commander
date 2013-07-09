require 'spec_helper'

describe VagrantShellCommander::Command do
  let(:subject) {described_class.new('2', 'command')}
  let(:argv) {double()}
  let(:opts) {{parser: 'parser', values: 'values'}}

  before(:each) do
    VagrantShellCommander::OptionManager.stub_chain(:new, :execute).
      and_return(opts)

    subject.stub(:with_target_vms)
    subject.stub(:parse_options).and_return(argv)
  end

  describe '#execute' do
    it 'returns 0 if all went good' do
      expect(subject.execute).to eql(0)
    end
    
    describe 'options' do
      after(:each) do
        subject.execute
      end

      it 'parses the given options' do
        subject.should_receive(:parse_options).with(opts[:parser])
      end
      
      it 'returns on option parsing failure' do
        subject.stub(:parse_options).and_return(false)
        
        expect(subject.execute).to eql(nil)
      end
      
    end

    describe 'command execution' do
      context 'not running machine' do
        let(:machine) {double}
        let(:ui) {double(info: true)}
        let(:env) {double(ui: ui)}

        before(:each) do
          subject.stub(:with_target_vms).and_yield(machine)
          subject.stub(:env).and_return env
        end

        after(:each) do
          subject.execute
        end

        it 'reports information about state' do
          machine_name = 'machine_name'
          machine.stub_chain(:state, :id).and_return(:not_running)
          machine.stub(:name).and_return(machine_name)
                    
          ui.should_receive(:info).with("Machine #{machine_name} is not running.")
        end

        it 'dows not try to execute the command'
      end

      context 'running machine' do
        it 'executes the given command if the machine'
      
        it 'executes the given command on every vm if vm option is missing'
        
        it 'shows the help when no command is given'
      end
    end
  end
end

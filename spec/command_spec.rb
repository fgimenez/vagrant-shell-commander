require 'spec_helper'

describe VagrantShellCommander::Command do
  let(:subject) {described_class.new('2', 'command')}
  let(:argv) {double}
  let(:opts) {{parser: 'parser', values: {cmd: 'cmd'}}}

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
      let(:machine) {double}
      let(:ui) {double(info: true)}
      let(:env) {double(ui: ui)}
      let(:machine_name) {'machine_name'}

      before(:each) do
        subject.stub(:with_target_vms).and_yield(machine)
        subject.stub(:env).and_return env
        machine.stub(:name).and_return(machine_name)
      end

      after(:each) do
        subject.execute
      end
      
      context 'not running machine' do
        before(:each) do
          machine.stub_chain(:state, :id).and_return(:not_running)
        end

        it 'reports information about state' do
          ui.should_receive(:info).with("Machine #{machine_name} is not running.")
        end

        it 'dows not try to execute the command' do
          machine.should_not_receive(:communicate)
        end
      end

      context 'running machine' do
        let(:cmd) {'command'}
        let(:cwd) {'cwd'}
        let(:communicate) {double(execute: true)}
        
        before(:each) do
          VagrantShellCommander::OptionManager.stub_chain(:new, :execute).
            and_return(parser: 'parser', values: {cmd: cmd})

          machine.stub_chain(:state, :id).and_return(:running)
          machine.stub(:communicate).and_return(communicate)
        end

        it 'executes the given command' do
          communicate.should_receive(:execute).with(cmd)
        end

        it 'shows the command output along with the machine name' do
          data = 'data'

          communicate.stub(:execute).and_yield('type', data)

          ui.should_receive(:info).with("#{machine_name}:: #{data}")
        end

        it 'executes the command in the given cwd' do
          VagrantShellCommander::OptionManager.stub_chain(:new, :execute).
            and_return(parser: 'parser', values: {cmd: cmd, cwd: cwd})
          
          communicate.should_receive(:execute).with("cd #{cwd} && #{cmd}")
        end

        describe 'does nothing' do
          after(:each) do
            subject.should_not_receive(:with_target_vms)
          end

          it 'an empty command' do
            VagrantShellCommander::OptionManager.stub_chain(:new, :execute).
              and_return(parser: 'parser', values: {cmd: '', cwd: cwd})
          end

          it 'non present command' do
            VagrantShellCommander::OptionManager.stub_chain(:new, :execute).
              and_return(parser: 'parser', values: {cwd: cwd})
          end
        end
      end
    end
  end
end

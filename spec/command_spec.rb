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
      let(:ui) {double(info: true, warn: true)}
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
          expect(ui).to receive(:warn).with("Machine #{machine_name} is not running.")
        end

        it 'dows not try to execute the command' do
          expect(machine).not_to receive(:communicate)
        end
      end

      context 'running machine' do
        let(:cmd) {'command'}
        let(:dir) {'dir'}
        let(:user) {'user'}
        let(:communicate) {double(execute: true)}
        
        before(:each) do
          VagrantShellCommander::OptionManager.stub_chain(:new, :execute).
            and_return(parser: 'parser', values: {cmd: cmd})

          machine.stub_chain(:state, :id).and_return(:running)
          allow(ui).to receive(:success)
          allow(machine).to receive(:action)
        end

        it 'executes the given command' do
          expect(machine).to receive(:action).with(:ssh_run, ssh_run_command: cmd)
        end

        it 'shows the machine name' do
          expect(ui).to receive(:success).with("#{machine_name}::")
        end

        it 'executes the command in the given dir' do
          VagrantShellCommander::OptionManager.stub_chain(:new, :execute).
            and_return(parser: 'parser', values: {cmd: cmd, dir: dir})
          
          expect(machine).to receive(:action).with(:ssh_run, 
                                                   ssh_run_command: "cd #{dir} && #{cmd}")
        end

        it 'executes the command for the given user' do
          VagrantShellCommander::OptionManager.stub_chain(:new, :execute).
            and_return(parser: 'parser', values: {cmd: cmd, user: user})
          
          expect(machine).to receive(:action).with(:ssh_run,
                                                   ssh_run_command: "sudo su - #{user} -c \"#{cmd}\"")
        end

        it 'executes the command for the given user and the given dir' do
          VagrantShellCommander::OptionManager.stub_chain(:new, :execute).
            and_return(parser: 'parser', values: {cmd: cmd, user: user, dir: dir})
          
          expect(machine).to receive(:action).with(:ssh_run, 
                                                   ssh_run_command: "sudo su - #{user} -c \"cd #{dir} && #{cmd}\"")
        end

        describe 'shows help' do
          let(:parser) {'parser'}

          after(:each) do
            expect(subject).not_to receive(:with_target_vms)
            expect(ui).to receive(:info).with(parser)
          end

          it 'an empty command' do
            VagrantShellCommander::OptionManager.stub_chain(:new, :execute).
              and_return(parser: parser, values: {cmd: '', dir: dir})
          end

          it 'non present command' do
            VagrantShellCommander::OptionManager.stub_chain(:new, :execute).
              and_return(parser: parser, values: {user: user})
          end
        end
      end
    end
  end
end

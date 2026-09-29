# frozen_string_literal: true

require 'spec_helper'

describe Facter::Util::Fact do
  before do
    Facter.clear
    allow(Facter::Core::Execution).to receive(:execute).and_call_original
    allow(Facter::Core::Execution).to receive(:which).and_call_original
  end

  describe 'sudo' do
    context 'with classic sudo' do
      before do
        allow(Facter::Core::Execution).to receive(:which).with('sudo').and_return(true)
        allow(Facter::Core::Execution).to receive(:execute).with('sudo -V 2>&1').and_return('Sudo version 1.9.15p5')
      end

      it do
        expect(Facter.fact(:sudo).value).to eq({ 'kind' => 'sudo', 'version' => '1.9.15p5' })
      end
    end

    context 'with sudo-rs' do
      before do
        allow(Facter::Core::Execution).to receive(:which).with('sudo').and_return(true)
        allow(Facter::Core::Execution).to receive(:execute).with('sudo -V 2>&1').and_return('sudo-rs 0.2.5')
      end

      it do
        expect(Facter.fact(:sudo).value).to eq({ 'kind' => 'sudo-rs', 'version' => '0.2.5' })
      end
    end

    context 'without sudo executable and with rpm' do
      before do
        allow(Facter::Core::Execution).to receive(:which).with('sudo').and_return(false)
        allow(Facter::Core::Execution).to receive(:which).with('rpm').and_return(true)
        allow(Facter::Core::Execution).to receive(:execute).with("rpm -q sudo --qf '%{VERSION}'").and_return('1.9.15p5')
      end

      it do
        expect(Facter.fact(:sudo).value).to eq({ 'kind' => 'sudo', 'version' => '1.9.15p5' })
      end
    end

    context 'without sudo executable and with dpkg-query' do
      before do
        allow(Facter::Core::Execution).to receive(:which).with('sudo').and_return(false)
        allow(Facter::Core::Execution).to receive(:which).with('rpm').and_return(false)
        allow(Facter::Core::Execution).to receive(:which).with('dpkg-query').and_return(true)
        allow(Facter::Core::Execution).to receive(:execute).with("dpkg-query -W -f='${Version}\\n' sudo").and_return('1.9.15p5-3ubuntu5')
      end

      it do
        expect(Facter.fact(:sudo).value).to eq({ 'kind' => 'sudo', 'version' => '1.9.15p5-3ubuntu5' })
      end
    end
  end
end

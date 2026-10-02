# frozen_string_literal: true

require 'spec_helper'

describe Facter::Util::Fact do
  before do
    Facter.clear
    allow(Facter::Core::Execution).to receive(:execute).and_call_original
    allow(Facter::Core::Execution).to receive(:which).and_call_original
  end

  describe 'sudoversion' do
    context 'with value' do
      before do
        allow(Facter::Core::Execution).to receive(:which).with('sudo').and_return(true)
        allow(Facter::Core::Execution).to receive(:execute).with('sudo -V 2>&1').and_return('Sudo version 1.7.10p9')
      end

      it do
        expect(Facter.fact(:sudoversion).value).to eq('1.7.10p9')
      end
    end
  end
end

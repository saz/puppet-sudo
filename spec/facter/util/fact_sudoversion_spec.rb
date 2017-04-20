require 'spec_helper'

describe Facter::Util::Fact do
  before do
    Facter.clear
  end

  describe 'sudoversion' do
    context 'with value' do
      before do
        Facter::Util::Resolution.stubs(:which).with('sudo').returns(true)
        Facter::Util::Resolution.stubs(:exec).with('sudo -V 2>&1').returns('Sudo version 1.7.10p9')
      end
      it do
        expect(Facter.fact(:sudoversion).value).to eq('1.7.10p9')
      end
    end
  end
end

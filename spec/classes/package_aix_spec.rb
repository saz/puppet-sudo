require 'spec_helper'
describe 'sudo::package::aix' do

  describe 'on supported osfamily: AIX' do

    let :params do
      {
        :package        => 'sudo',
        :package_ensure => 'present',
        :package_source => 'http://www.sudo.ws/sudo/dist/packages/AIX/5.3/sudo-1.8.9-6.aix53.lam.rpm',
      }
    end

    let :facts do
      {
        :osfamily => 'AIX'
      }
    end

    it {
      should contain_package('sudo').with(
        'ensure'   => 'present',
        'source'   => 'http://www.sudo.ws/sudo/dist/packages/AIX/5.3/sudo-1.8.9-6.aix53.lam.rpm',
        'provider' => 'rpm'
      )
    }
  end
end

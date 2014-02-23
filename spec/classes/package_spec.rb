require 'spec_helper'
describe 'sudo::package' do

  describe 'on supported osfamily: RedHat' do

    let :params do
      {
        :package        => 'sudo',
        :package_ensure => 'present',
      }
    end

    let :facts do
      {
        :osfamily => 'RedHat'
      }
    end

    it {
      should contain_package('sudo').with('ensure' => 'present')
    }
  end

  describe 'on supported osfamily: AIX' do

    let :params do
      {
        :package        => 'sudo',
        :package_ensure => 'present',
        :package_source => 'http://www.oss4aix.org/compatible/aix53/sudo-1.8.7-1.aix5.1.ppc.rpm',
      }
    end

    let :facts do
      {
        :osfamily => 'AIX'
      }
    end

    it {
      should contain_class('sudo::package::aix').with(
        'package'        => 'sudo',
        'package_source' => 'http://www.oss4aix.org/compatible/aix53/sudo-1.8.7-1.aix5.1.ppc.rpm',
        'package_ensure' => 'present'
      )
    }
  end
end

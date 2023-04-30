# frozen_string_literal: true

require 'spec_helper'
describe 'sudo::package::aix' do
  describe 'on supported osfamily: AIX' do
    let :params do
      {
        package: 'sudo',
        package_ensure: 'present',
        package_source: 'http://www.sudo.ws/sudo/dist/packages/AIX/5.3/sudo-1.8.27-1.aix53.rpm',
        package_provider: 'rpm'
      }
    end

    let :facts do
      {
        osfamily: 'AIX'
      }
    end

    it do
      is_expected.to contain_package('sudo').with(
        'ensure'   => 'present',
        'source'   => 'http://www.sudo.ws/sudo/dist/packages/AIX/5.3/sudo-1.8.27-1.aix53.rpm',
        'provider' => 'rpm'
      )
    end
  end

  describe 'on supported osfamily: AIX and package_provider set' do
    let :params do
      {
        package: 'sudo',
        package_ensure: 'present',
        package_provider: 'yum'
      }
    end

    let :facts do
      {
        osfamily: 'AIX'
      }
    end

    it do
      is_expected.to contain_package('sudo').with(
        'ensure'   => 'present',
        'provider' => 'yum'
      )
    end
  end
end

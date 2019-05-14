require 'spec_helper'
describe 'sudo::package::aix' do
  describe 'on supported osfamily: AIX' do
    let :params do
      {
        :package                   => 'sudo',
        :package_ensure            => 'present',
        :package_source            => 'http://www.sudo.ws/sudo/dist/packages/AIX/5.3/sudo-1.8.9-6.aix53.lam.rpm'
        :package_provider_override => 'rpm'
      }
    end

    let :facts do
      {
        :osfamily => 'AIX'
      }
    end

    it do
      is_expected.to contain_package('sudo').with(
        'ensure'   => 'present',
        'source'   => 'http://www.sudo.ws/sudo/dist/packages/AIX/5.3/sudo-1.8.9-6.aix53.lam.rpm',
        'provider' => 'rpm'
      )
    end
  end

  let :params do
    {
      :package                   => 'sudo',
      :package_ensure            => 'present',
      :package_source            => ''
      :package_provider_override => 'yum'
    }
  end

  let :facts do
    {
      :osfamily => 'AIX'
    }
  end

  it do
    is_expected.to contain_package('sudo').with(
      'ensure'   => 'present',
      'source'   => '',
      'provider' => 'yum'
    )
  end
end
end

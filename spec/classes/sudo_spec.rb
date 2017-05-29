require 'spec_helper'
describe 'sudo' do
  let :default_params do
    {
      :enable              => true,
      :package_ensure      => 'present',
      :purge               => true,
      :config_file_replace => true
    }
  end

  [{},
   {
     :package_ensure      => 'present',
     :purge               => false,
     :config_file_replace => false
   },
   {
     :package_ensure      => 'latest',
     :purge               => true,
     :config_file_replace => false
   }].each do |param_set|
    describe "when #{param_set == {} ? 'using default' : 'specifying'} class parameters" do
      let :param_hash do
        default_params.merge(param_set)
      end

      let :params do
        param_set
      end

      %w[Debian Redhat].each do |osfamily|
        let :facts do
          {
            :operatingsystem           => osfamily,
            :operatingsystemrelease    => '7.0',
            :operatingsystemmajrelease => '7',
            :osfamily                  => osfamily,
            :puppetversion             => '3.7.0'
          }
        end

        describe "on supported osfamily: #{osfamily}" do
          it { is_expected.to contain_class('sudo::params') }

          it do
            is_expected.to contain_file('/etc/sudoers').with(
              'ensure'  => 'present',
              'owner'   => 'root',
              'group'   => 'root',
              'mode'    => '0440',
              'replace' => param_hash[:config_file_replace]
            )
          end

          it do
            is_expected.to contain_file('/etc/sudoers.d').with(
              'ensure'  => 'directory',
              'owner'   => 'root',
              'group'   => 'root',
              'mode'    => '0550',
              'recurse' => param_hash[:purge],
              'purge'   => param_hash[:purge]
            )
          end

          it do
            is_expected.to contain_class('sudo::package').with(
              'package'        => 'sudo',
              'package_ensure' => param_hash[:package_ensure]
            )
          end
        end
      end

      describe 'on RedHat 5.4' do
        let :facts do
          {
            :osfamily                  => 'RedHat',
            :operatingsystemrelease    => '5.4',
            :operatingsystemmajrelease => '5',
            :puppetversion             => '3.7.0'
          }
        end

        it do
          if params == {}
            is_expected.to contain_class('sudo::package').with(
              'package'        => 'sudo',
              'package_ensure' => 'latest'
            )
          else
            is_expected.to contain_class('sudo::package').with(
              'package'        => 'sudo',
              'package_ensure' => param_hash[:package_ensure]
            )
          end
        end
      end

      describe 'on supported osfamily: AIX' do
        let :facts do
          {
            :osfamily      => 'AIX',
            :puppetversion => '3.7.0'
          }
        end

        it { is_expected.to contain_class('sudo::params') }

        it do
          is_expected.to contain_file('/etc/sudoers').with(
            'ensure'  => 'present',
            'owner'   => 'root',
            'group'   => 'system',
            'mode'    => '0440',
            'replace' => param_hash[:config_file_replace]
          )
        end

        it do
          is_expected.to contain_file('/etc/sudoers.d').with(
            'ensure'  => 'directory',
            'owner'   => 'root',
            'group'   => 'system',
            'mode'    => '0550',
            'recurse' => param_hash[:purge],
            'purge'   => param_hash[:purge]
          )
        end

        it do
          is_expected.to contain_class('sudo::package').with(
            'package'        => 'sudo',
            'package_ensure' => param_hash[:package_ensure],
            'package_source' => 'http://www.sudo.ws/sudo/dist/packages/AIX/5.3/sudo-1.8.9-6.aix53.lam.rpm'
          )
        end
      end

      describe 'on supported osfamily: Solaris 10' do
        let :facts do
          {
            :operatingsystem => 'Solaris',
            :osfamily        => 'Solaris',
            :kernelrelease   => '5.10',
            :puppetversion   => '3.7.0',
            :hardwareisa     => 'i386'
          }
        end

        it { is_expected.to contain_class('sudo::params') }

        it do
          is_expected.to contain_file('/etc/sudoers').with(
            'ensure'  => 'present',
            'owner'   => 'root',
            'group'   => 'root',
            'mode'    => '0440',
            'replace' => param_hash[:config_file_replace]
          )
        end

        it do
          is_expected.to contain_file('/etc/sudoers.d').with(
            'ensure'  => 'directory',
            'owner'   => 'root',
            'group'   => 'root',
            'mode'    => '0550',
            'recurse' => param_hash[:purge],
            'purge'   => param_hash[:purge]
          )
        end

        it do
          is_expected.to contain_class('sudo::package').with(
            'package' => 'TCMsudo',
            'package_ensure' => param_hash[:package_ensure],
            'package_source' => 'http://www.sudo.ws/sudo/dist/packages/Solaris/10/TCMsudo-1.8.9p5-i386.pkg.gz',
            'package_admin_file' => '/var/sadm/install/admin/puppet'
          )
        end

        context 'when package is set' do
          let :params do
            {
              :package => 'mysudo'
            }
          end

          it do
            is_expected.to contain_class('sudo::package').with(
              'package' => 'mysudo'
              )
          end
        end
      end

      describe 'on supported osfamily: Solaris 11' do
        let :facts do
          {
            :operatingsystem => 'Solaris',
            :osfamily        => 'Solaris',
            :kernelrelease   => '5.11',
            :puppetversion   => '3.7.0'
          }
        end

        it { is_expected.to contain_class('sudo::params') }

        it do
          is_expected.to contain_file('/etc/sudoers').with(
            'ensure'  => 'present',
            'owner'   => 'root',
            'group'   => 'root',
            'mode'    => '0440',
            'replace' => param_hash[:config_file_replace]
          )
        end

        it do
          is_expected.to contain_file('/etc/sudoers.d').with(
            'ensure'  => 'directory',
            'owner'   => 'root',
            'group'   => 'root',
            'mode'    => '0550',
            'recurse' => param_hash[:purge],
            'purge'   => param_hash[:purge]
          )
        end

        it do
          is_expected.to contain_class('sudo::package').with(
            'package' => 'pkg://solaris/security/sudo',
            'package_ensure' => param_hash[:package_ensure]
          )
        end
      end
    end
  end
end

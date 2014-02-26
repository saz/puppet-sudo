require 'spec_helper'
describe 'sudo' do

  let :default_params do
    {
      :enable              => true,
      :package_ensure      => 'present',
      :purge               => true,
      :config_file_replace => true,
    }
  end

  [ {},
    {
      :package_ensure      => 'present',
      :purge               => false,
      :config_file_replace => false,
    },
    {
      :package_ensure      => 'latest',
      :purge               => true,
      :config_file_replace => false,
    }
  ].each do |param_set|
    describe "when #{param_set == {} ? "using default" : "specifying"} class parameters" do

      let :param_hash do
        default_params.merge(param_set)
      end

      let :params do
        param_set
      end

      ['Debian', 'Redhat'].each do |osfamily|

        let :facts do
          {
            :osfamily        => osfamily,
          }
        end

        describe "on supported osfamily: #{osfamily}" do

          it { should contain_class('sudo::params') }

          it do
              should contain_file('/etc/sudoers').with(
                'ensure'  => 'present',
                'owner'   => 'root',
                'group'   => 'root',
                'mode'    => '0440',
                'replace' => param_hash[:config_file_replace]
              )
          end

          it do
            should contain_file('/etc/sudoers.d/').with(
              'ensure'  => 'directory',
              'owner'   => 'root',
              'group'   => 'root',
              'mode'    => '0550',
              'recurse' => param_hash[:purge],
              'purge'   => param_hash[:purge]
            )
          end

          it do
            should contain_class('sudo::package').with(
              'package'        => 'sudo',
              'package_ensure' => param_hash[:package_ensure]
            )
          end

        end
      end

      describe "on supported osfamily: AIX" do

        let :facts do
          {
            :osfamily => 'AIX',
          }
        end

        it { should contain_class('sudo::params') }

        it do
          should contain_file('/etc/sudoers').with(
            'ensure'  => 'present',
            'owner'   => 'root',
            'group'   => 'system',
            'mode'    => '0440',
            'replace' => param_hash[:config_file_replace]
          )
        end

        it do
          should contain_file('/etc/sudoers.d/').with(
            'ensure'  => 'directory',
            'owner'   => 'root',
            'group'   => 'system',
            'mode'    => '0550',
            'recurse' => param_hash[:purge],
            'purge'   => param_hash[:purge]
          )
        end

        it do
          should contain_class('sudo::package').with(
            'package'        => 'sudo',
            'package_ensure' => param_hash[:package_ensure],
            'package_source' => 'http://www.oss4aix.org/compatible/aix53/sudo-1.8.7-1.aix5.1.ppc.rpm'
          )
        end

      end

      describe "on supported osfamily: Solaris 10" do

        let :facts do
          {
            :osfamily        => 'Solaris',
            :kernelrelease   => '5.10',
          }
        end

        it { should contain_class('sudo::params') }

        it {
          if param_hash[:enable] == 'true'
            should contain_file('/etc/sudoers').with(
              'ensure'  => 'present',
              'owner'   => 'root',
              'group'   => 'system',
              'mode'    => '0440',
              'replace' => param_hash[:config_file_replace]
            )
            should contain_file('/etc/sudoers.d/').with(
              'ensure'  => 'directory',
              'owner'   => 'root',
              'group'   => 'root',
              'mode'    => '0550',
              'recurse' => param_hash[:purge],
              'purge'   => param_hash[:purge]
            )
            should contain_class('sudo::package').with(
              'package' => 'TCMsudo',
              'package_ensure' => 'present',
              'package_source' => 'http://wwwx.sudo.ws/sudo/dist/packages/Solaris/10/TCMsudo-1.8.9p5-i386.pkg.gz',
              'package_admin_file' => '/var/sadm/install/admin/puppet'
            )

          end
        }

      end

      describe "on supported osfamily: Solaris 11" do

        let :facts do
          {
            :osfamily        => 'Solaris',
            :kernelrelease   => '5.11',
          }
        end

        it { should contain_class('sudo::params') }

        it {
          if param_hash[:enable] == 'true'
            should contain_file('/etc/sudoers').with(
              'ensure'  => 'present',
              'owner'   => 'root',
              'group'   => 'system',
              'mode'    => '0440',
              'replace' => param_hash[:config_file_replace]
            )
            should contain_file('/etc/sudoers.d/').with(
              'ensure'  => 'directory',
              'owner'   => 'root',
              'group'   => 'root',
              'mode'    => '0550',
              'recurse' => param_hash[:purge],
              'purge'   => param_hash[:purge]
            )
            should contain_class('sudo::package').with(
              'package' => 'sudo',
              'package_ensure' => 'present'
            )

          end
        }

      end
    end


  end
end

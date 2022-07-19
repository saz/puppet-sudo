# frozen_string_literal: true

require 'spec_helper'
describe 'sudo' do
  let :node do
    'rspec.puppet.com'
  end

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let :facts do
        os_facts
      end

      context 'with all defaults' do
        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_file('/etc/sudoers') }
      end

      context 'with content_template and content_string set' do
        let :params do
          {
            content_template: 'sudo/sudoers.ubuntu.erb',
            content_string: 'some string'
          }
        end

        it { is_expected.to compile.and_raise_error(%r{'content_template' and 'content_string' are mutually exclusive}) }
      end

      context 'with deprecated content and content_string set' do
        let :params do
          {
            content: 'sudo/sudoers.ubuntu.erb',
            content_string: 'some string'
          }
        end

        it { is_expected.to compile.and_raise_error(%r{'content' \(deprecated\) and 'content_string' are mutually exclusive}) }
      end

      context 'with deprecated content set' do
        let :params do
          {
            content: 'sudo/sudoers.ubuntu.erb'
          }
        end

        it { is_expected.to contain_file('/etc/sudoers').with_content(%r{.*Defaults\s+env_reset.*}) }
      end

      context 'with content_string set' do
        let :params do
          {
            content_string: 'just a string'
          }
        end

        it { is_expected.to contain_file('/etc/sudoers').with_content(%r{^just a string$}) }
      end

      context 'with content_template set' do
        let :params do
          {
            content_template: 'sudo/sudoers.ubuntu.erb'
          }
        end

        it { is_expected.to contain_file('/etc/sudoers').with_content(%r{.*Defaults\s+env_reset.*}) }
      end

      unless os =~ %r{^(debian|ubuntu)}
        context 'wheel_config is absent' do
          let :params do
            {
              wheel_config: 'absent'
            }
          end

          it { is_expected.to contain_file('/etc/sudoers').with_content(%r{^# %wheel\s+ALL=\(ALL\)\s+ALL$}) }
          it { is_expected.to contain_file('/etc/sudoers').with_content(%r{^# %wheel\s+ALL=\(ALL\)\s+NOPASSWD:\s+ALL$}) }
        end

        context 'wheel_config is password' do
          let :params do
            {
              wheel_config: 'password'
            }
          end

          it { is_expected.to contain_file('/etc/sudoers').with_content(%r{^%wheel\s+ALL=\(ALL\)\s+ALL$}) }
          it { is_expected.to contain_file('/etc/sudoers').with_content(%r{^# %wheel\s+ALL=\(ALL\)\s+NOPASSWD:\s+ALL$}) }
        end

        context 'wheel_config is nopassword' do
          let :params do
            {
              wheel_config: 'nopassword'
            }
          end

          it { is_expected.to contain_file('/etc/sudoers').with_content(%r{^# %wheel\s+ALL=\(ALL\)\s+ALL$}) }
          it { is_expected.to contain_file('/etc/sudoers').with_content(%r{^%wheel\s+ALL=\(ALL\)\s+NOPASSWD:\s+ALL$}) }
        end
      end
    end
  end

  context 'legacy tests' do
    let :default_params do
      {
        enable: true,
        package_ensure: 'present',
        purge: true,
        config_file_replace: true
      }
    end

    [{},
     {
       package_ensure: 'present',
       purge: false,
       config_file_replace: false
     },
     {
       package_ensure: 'latest',
       purge: true,
       config_file_replace: false
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
              os: {
                'family'  => osfamily,
                'name'    => osfamily,
                'release' => {
                  'full'  => '7.0',
                  'major' => '7',
                },
              },
              puppetversion: '3.7.0'
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
              os: {
                'family'  => 'RedHat',
                'name'    => 'RedHat',
                'release' => {
                  'full'  => '5.4',
                  'major' => '5',
                },
              },
              puppetversion: '3.7.0'
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
              os: {
                'family' => 'AIX',
              },
              puppetversion: '3.7.0'
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
              'package'          => 'sudo',
              'package_ensure'   => param_hash[:package_ensure],
              'package_source'   => 'http://www.sudo.ws/sudo/dist/packages/AIX/5.3/sudo-1.8.27-1.aix53.rpm',
              'package_provider' => 'rpm'
            )
          end
        end

        describe 'on supported osfamily: Solaris 10' do
          let :facts do
            {
              os: {
                'family'   => 'Solaris',
                'name'     => 'Solaris',
                'hardware' => 'i386',
              },
              kernelrelease: '5.10',
              puppetversion: '3.7.0',
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
                package: 'mysudo'
              }
            end

            it do
              is_expected.to contain_class('sudo::package').with(
                'package' => 'mysudo'
              )
              is_expected.to contain_package('mysudo').with(
                'ensure' => 'present'
              )
            end
          end
        end

        describe 'on supported osfamily: Solaris 11' do
          let :facts do
            {
              os: {
                'family' => 'Solaris',
                'name'   => 'Solaris',
              },
              kernelrelease: '5.11',
              puppetversion: '3.7.0'
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

    describe 'on osfamily Debian' do
      let :facts do
        {
          os: {
            'family'  => 'Debian',
            'name'    => 'Debian',
            'release' => {
              'full'  => '7.0',
              'major' => '7',
            },
          },
          puppetversion: '3.7.0'
        }
      end

      it { is_expected.to contain_file('/etc/sudoers').with_content(%r{^Defaults\ssecure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/puppetlabs/bin"$}) }

      context 'secure_path is set' do
        let :params do
          {
            secure_path: 'SecurePathHere'
          }
        end

        it { is_expected.to contain_file('/etc/sudoers').with_content(%r{^Defaults\ssecure_path="SecurePathHere"$}) }
      end
    end
  end
end

require 'spec_helper'
describe 'sudo' do

  let :default_params do
    {
      :ensure              => 'present',
      :autoupgrade         => false,
      :purge               => false,
      :config_file_replace => false,
    }
  end

  [ {},
    {
      :ensure              => 'present',
      :autoupgrade         => false,
      :purge               => true,
      :config_file_replace => false,
    },
    {
      :ensure              => 'present',
      :autoupgrade         => true,
      :purge               => false,
      :config_file_replace => true,
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

          it { 
            if not param_hash[:autoupgrade]
              should contain_package('sudo').with_ensure('present')
            end
          }

          it {
            if param_hash[:autoupgrade]
              should contain_package('sudo').with_ensure('latest')
            end
          }

          it {
            if param_hash[:ensure] == 'present'
              should contain_file('/etc/sudoers').with(
                'ensure'  => 'present',
                'owner'   => 'root',
                'group'   => 'root',
                'mode'    => '0440',
                'replace' => param_hash[:config_file_replace]
              )
            end
          }

          it {
            if param_hash[:ensure] == 'present'
              should contain_file('/etc/sudoers.d/').with(
                'ensure'  => 'directory',
                'owner'   => 'root',
                'group'   => 'root',
                'mode'    => '0550',
                'recurse' => param_hash[:purge],
                'purge'   => param_hash[:purge]
              )
            end
          }
        end
      end
    end
  end
end

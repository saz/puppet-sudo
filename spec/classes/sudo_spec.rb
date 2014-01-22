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

          it {
            if param_hash[:enable] == 'true'
              should contain_file('/etc/sudoers').with(
                'ensure'  => 'present',
                'owner'   => 'root',
                'group'   => 'root',
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
            end
          }

        end
      end
    end
  end
end

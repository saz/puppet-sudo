# frozen_string_literal: true

require 'spec_helper'

describe 'sudo::package' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      case facts[:os]['family']
      when 'Darwin'
        it { is_expected.not_to contain_package('sudo') }
      when 'AIX'
        it { is_expected.to contain_package('foobar') }
      when 'Solaris'
        package_name = case facts[:kernelrelease]
                       when '5.10'
                         'TCMsudo'
                       else
                         'pkg://solaris/security/sudo'
                       end
        let(:params) do
          {
            package: package_name,
            package_ensure: 'present',
          }
        end
        it do
          is_expected.to contain_class('sudo::package::solaris').with(
            'package'        => package_name,
            'package_ensure' => 'present'
          )
          is_expected.to contain_package(package_name).with('ensure' => 'present')
        end
      else
        let(:params) { { 'package' => 'sudo' } }

        it { is_expected.to contain_package('sudo').with('ensure' => 'installed') }
      end
    end
  end
end

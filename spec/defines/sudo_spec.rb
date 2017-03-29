require 'spec_helper'
describe 'sudo::conf', :type => :define do
  let(:title)    { 'admins' }
  let(:filename) { '10_admins' }
  let(:file_path) { '/etc/sudoers.d/10_admins' }

  let :facts do
    {
      lsbdistcodename:           'wheezy',
      operatingsystemmajrelease: '7',
      operatingsystem:           'Debian',
      osfamily:                  'Debian',
      puppetversion:             '3.7.0'
    }
  end

  let :params do
    {
      priority:        10,
      content:         '%admins ALL=(ALL) NOPASSWD: ALL',
      sudo_config_dir: '/etc/sudoers.d'
    }
  end

  describe 'when creating a sudo entry' do
    it do
      is_expected.to contain_sudo__conf('admins').with(
        priority: params[:priority],
        content:  params[:content]
      )
    end

    it do
      is_expected.to contain_file(filename).with(
        ensure:  'present',
        content: "# This file is managed by Puppet; changes may be overwritten\n%admins ALL=(ALL) NOPASSWD: ALL\n",
        owner:   'root',
        group:   'root',
        path:    file_path,
        mode:    '0440'
      )
    end

    it do
      is_expected.to contain_exec("sudo-syntax-check for file #{params[:sudo_config_dir]}/#{params[:priority]}_#{title}").with(
        command:     "visudo -c || ( rm -f '#{params[:sudo_config_dir]}/#{params[:priority]}_#{title}' && exit 1)",
        refreshonly: 'true'
      )
    end

    it { is_expected.to contain_file(filename).that_notifies("Exec[sudo-syntax-check for file #{params[:sudo_config_dir]}/#{params[:priority]}_#{title}]") }
    it { is_expected.not_to contain_file(filename).that_requires("Exec[sudo-syntax-check for file #{params[:sudo_config_dir]}/#{params[:priority]}_#{title}]") }
  end

  describe 'when creating a sudo entry with single number priority' do
    let(:filename) { '05_admins' }
    let(:file_path) { '/etc/sudoers.d/05_admins' }

    let :params do
      {
        priority:        5,
        content:         '%admins ALL=(ALL) NOPASSWD: ALL',
        sudo_config_dir: '/etc/sudoers.d'
      }
    end

    it do
      is_expected.to contain_sudo__conf('admins').with(
        priority: params[:priority],
        content:  params[:content]
      )
    end

    it do
      is_expected.to contain_file(filename).with(
        ensure:  'present',
        content: "# This file is managed by Puppet; changes may be overwritten\n%admins ALL=(ALL) NOPASSWD: ALL\n",
        owner:   'root',
        group:   'root',
        path:    file_path,
        mode:    '0440'
      )
    end

    it do
      is_expected.to contain_exec("sudo-syntax-check for file #{params[:sudo_config_dir]}/0#{params[:priority]}_#{title}").with(
        command:     "visudo -c || ( rm -f '#{params[:sudo_config_dir]}/0#{params[:priority]}_#{title}' && exit 1)",
        refreshonly: 'true'
      )
    end

    it { is_expected.to contain_file(filename).that_notifies("Exec[sudo-syntax-check for file #{params[:sudo_config_dir]}/0#{params[:priority]}_#{title}]") }
    it { is_expected.not_to contain_file(filename).that_requires("Exec[sudo-syntax-check for file #{params[:sudo_config_dir]}/0#{params[:priority]}_#{title}]") }
  end

  describe 'when creating a sudo entry with whitespace in name' do
    let(:title)    { 'admins hq' }
    let(:filename) { '05_admins hq' }
    let(:file_path) { '/etc/sudoers.d/05_admins_hq' }

    let :params do
      {
        priority:        5,
        content:         '%admins_hq ALL=(ALL) NOPASSWD: ALL',
        sudo_config_dir: '/etc/sudoers.d'
      }
    end

    it do
      is_expected.to contain_sudo__conf('admins hq').with(:priority => params[:priority],
                                                          :content  => params[:content])
    end

    it do
      is_expected.to contain_file(filename).with(
        ensure:  'present',
        content: "# This file is managed by Puppet; changes may be overwritten\n%admins_hq ALL=(ALL) NOPASSWD: ALL\n",
        owner:   'root',
        group:   'root',
        path:    file_path,
        mode:    '0440'
      )
    end

    it do
      is_expected.to contain_exec("sudo-syntax-check for file #{params[:sudo_config_dir]}/0#{params[:priority]}_#{title}").with(
        command:     "visudo -c || ( rm -f '#{file_path}' && exit 1)",
        refreshonly: 'true'
      )
    end

    it { is_expected.to contain_file(filename).that_notifies("Exec[sudo-syntax-check for file #{params[:sudo_config_dir]}/0#{params[:priority]}_#{title}]") }
    it { is_expected.not_to contain_file(filename).that_requires("Exec[sudo-syntax-check for file #{params[:sudo_config_dir]}/0#{params[:priority]}_#{title}]") }
  end

  describe 'when removing an sudo entry' do
    let :params do
      {
        ensure:          'absent',
        priority:        10,
        content:         '%admins ALL=(ALL) NOPASSWD: ALL',
        sudo_config_dir: '/etc/sudoers.d'
      }
    end

    it do
      is_expected.to contain_file(filename).with(
        ensure:  'absent',
        content: "# This file is managed by Puppet; changes may be overwritten\n%admins ALL=(ALL) NOPASSWD: ALL\n",
        owner:   'root',
        group:   'root',
        path:    file_path,
        mode:    '0440'
      )
    end
  end

  describe 'when removing an sudo entry with single number priority' do
    let :params do
      {
        ensure:          'absent',
        priority:        5,
        content:         '%admins ALL=(ALL) NOPASSWD: ALL',
        sudo_config_dir: '/etc/sudoers.d'
      }
    end

    let(:filename) { '05_admins' }
    let(:file_path) { '/etc/sudoers.d/05_admins' }

    it do
      is_expected.to contain_file(filename).with(
        ensure:   'absent',
        content:  "# This file is managed by Puppet; changes may be overwritten\n%admins ALL=(ALL) NOPASSWD: ALL\n",
        owner:    'root',
        group:    'root',
        path:     file_path,
        mode:    '0440'
      )
    end
  end

  describe 'when adding a sudo entry with array content' do
    let :params do
      {
        content: [
          '%admins ALL=(ALL) NOPASSWD: ALL',
          '%wheel ALL=(ALL) NOPASSWD: ALL'
        ]
      }
    end

    let(:filename) { '10_admins' }
    let(:file_path) { '/etc/sudoers.d/10_admins' }

    it do
      is_expected.to contain_file(filename).with(
        ensure:   'present',
        content:  "# This file is managed by Puppet; changes may be overwritten\n%admins ALL=(ALL) NOPASSWD: ALL\n%wheel ALL=(ALL) NOPASSWD: ALL\n",
        owner:    'root',
        group:    'root',
        path:     file_path,
        mode:     '0440'
      )
    end
  end
end

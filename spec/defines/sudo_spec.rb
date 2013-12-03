require 'spec_helper'
describe 'sudo::conf', :type => :define do
  let(:title)    { 'admins' }
  let(:filename) { '10_admins' }
  let(:file_path) { '/etc/sudoers.d/10_admins' }

  let :facts do
    {
      :osfamily => 'Debian'
    }
  end

  let :params do
      {
      :priority        => 10,
      :content         => "%admins ALL=(ALL) NOPASSWD: ALL",
      :sudo_config_dir => '/etc/sudoers.d/',
      }
  end

  describe "when creating a sudo entry" do

    it { should contain_sudo__conf('admins').with({
        :priority => params[:priority],
        :content  => params[:content],
      })
    }

    it { should contain_file(filename).with({
        'ensure'  => 'present',
        'content' => "%admins ALL=(ALL) NOPASSWD: ALL\n",
        'owner'   => 'root',
        'group'   => 'root',
        'path'    => file_path,
        'mode'    => '0440',
      })
    }

    it { should contain_exec("sudo-syntax-check for file #{params[:sudo_config_dir]}#{params[:priority]}_#{title}").with({
        'command'     => "visudo -c -f '#{params[:sudo_config_dir]}#{params[:priority]}_#{title}' || ( rm -f '#{params[:sudo_config_dir]}#{params[:priority]}_#{title}' && exit 1)",
        'refreshonly' => 'true',
      })
    }

  end

  describe "when removing an sudo entry" do
    let :params do
      {
      :ensure          => 'absent',
      :priority        => 10,
      :content         => "%admins ALL=(ALL) NOPASSWD: ALL",
      :sudo_config_dir => '/etc/sudoers.d/',
      }
    end

    it { should contain_file(filename).with({
        'ensure'  => 'absent',
        'content' => "%admins ALL=(ALL) NOPASSWD: ALL\n",
        'owner'   => 'root',
        'group'   => 'root',
        'path'    => file_path,
        'mode'    => '0440',
      })
    }
  end
end

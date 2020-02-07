require 'spec_helper_acceptance'

describe 'sudo::conf class' do
  context 'with default parameters' do
    # Using puppet_apply as a helper
    it 'works with no errors' do
      pp = <<-PP
      group { 'janedoe':
        ensure => present;
      }
      ->
      user { 'janedoe' :
        gid => 'janedoe',
        home => '/home/janedoe',
        shell => '/bin/bash',
        managehome => true,
        membership => minimum,
      }
      ->
      user { 'nosudoguy' :
        home => '/home/nosudoguy',
        shell => '/bin/bash',
        managehome => true,
        membership => minimum,
      }
      ->
      class {'sudo':
        purge               => false,
        config_file_replace => false,
      }
      ->
      sudo::conf { 'janedoe_nopasswd':
        content => "janedoe ALL=(ALL) NOPASSWD: ALL\n"
      }
      PP

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_failures => true)
    end

    describe command("su - janedoe -c 'sudo echo Hello World'") do
      its(:stdout) { is_expected.to match %r{Hello World} }
      its(:exit_status) { is_expected.to eq 0 }
    end

    describe command("su - nosudoguy -c 'sudo echo Hello World'") do
      its(:stderr) { is_expected.to match %r{no tty present and no askpass program specified} }
      its(:exit_status) { is_expected.to eq 1 }
    end
  end

  context 'with ignore and suffix specified' do
    describe command("touch /etc/sudoers.d/file-from-rpm") do
      its(:exit_status) { is_expected.to eq 0 }
    end

    it 'create a puppet managed file' do
      pp = <<-PP
      class {'sudo':
        suffix => '_puppet',
        ignore => '[*!_puppet]',
      }
      sudo::conf { 'janedoe_nopasswd':
        content => "janedoe ALL=(ALL) NOPASSWD: ALL\n"
      }
      PP

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      expect(apply_manifest(pp, :catch_failures => true).exit_code).to be_zero
      describe file('/etc/sudoers.d/janedoe_nopasswd_puppet') do
        it { should exist }
      end
      describe file('/etc/sudoers.d/sudoers.d/file-from-rpm') do
        it { should exist }
      end
      pp = <<-PP
      class {'sudo':
        suffix => '_puppet',
        ignore => '[*!_puppet]',
      }
      PP
      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      expect(apply_manifest(pp, :catch_failures => true).exit_code).to be_zero
      describe file('/etc/sudoers.d/janedoe_nopasswd_puppet') do
        it { should_not exist }
      end
      describe file('/etc/sudoers.d/sudoers.d/file-from-rpm') do
        it { should exist }
      end
    end
  end
end

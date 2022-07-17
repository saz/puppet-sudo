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
      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_failures: true)
    end

    describe command("su - janedoe -c 'sudo echo Hello World'") do
      its(:stdout) { is_expected.to match %r{Hello World} }
      its(:exit_status) { is_expected.to eq 0 }
    end

    describe command("su - nosudoguy -c 'sudo echo Hello World'") do
      its(:stderr) { is_expected.to match %r{no tty present and no askpass program specified|a terminal is required to read the password} }
      its(:exit_status) { is_expected.to eq 1 }
    end
  end

  context 'with ignore and suffix specified managed file' do
    describe command('touch /etc/sudoers.d/file-from-rpm') do
      its(:exit_status) { is_expected.to eq 0 }
    end

    describe command('chmod 0440 /etc/sudoers.d/file-from-rpm') do
      its(:exit_status) { is_expected.to eq 0 }
    end

    it 'create a puppet managed file' do
      pp = <<-PP
      class {'sudo':
        suffix       => '_puppet',
        purge_ignore => '[*!_puppet]',
      }
      sudo::conf { 'janedoe_nopasswd':
        content => "janedoe ALL=(ALL) NOPASSWD: ALL\n"
      }
      PP

      # Run it twice and test for idempotency
      apply_manifest(pp, catch_failures: true)
      expect(apply_manifest(pp, catch_failures: true).exit_code).to be_zero
    end

    describe file('/etc/sudoers.d/10_janedoe_nopasswd_puppet') do
      it { is_expected.to be_file }
      it { is_expected.to contain 'janedoe ALL=(ALL) NOPASSWD: ALL' }
    end

    describe file('/etc/sudoers.d/file-from-rpm') do
      it { is_expected.to exist }
    end
  end

  context 'with ignore and suffix specified without managed file' do
    describe command('touch /etc/sudoers.d/file-from-rpm') do
      its(:exit_status) { is_expected.to eq 0 }
    end

    describe command('chmod 0440 /etc/sudoers.d/file-from-rpm') do
      its(:exit_status) { is_expected.to eq 0 }
    end

    it 'without a puppet managed file' do
      pp = <<-PP
      class {'sudo':
        suffix       => '_puppet',
        purge_ignore => '[*!_puppet]',
      }
      PP
      # Run it twice and test for idempotency
      apply_manifest(pp, catch_failures: true)
      expect(apply_manifest(pp, catch_failures: true).exit_code).to be_zero
    end

    describe file('/etc/sudoers.d/10_janedoe_nopasswd_puppet') do
      it { is_expected.not_to exist }
    end

    describe file('/etc/sudoers.d/file-from-rpm') do
      it { is_expected.to exist }
    end
  end

  context 'with ignore and prefix specified managed file' do
    describe command('touch /etc/sudoers.d/file-from-rpm') do
      its(:exit_status) { is_expected.to eq 0 }
    end

    describe command('chmod 0440 /etc/sudoers.d/file-from-rpm') do
      its(:exit_status) { is_expected.to eq 0 }
    end

    it 'create a puppet managed file' do
      pp = <<-PP
      class {'sudo':
        prefix       => 'puppet_',
        purge_ignore => '[!puppet_]*',
      }
      sudo::conf { 'janedoe_nopasswd':
        content => "janedoe ALL=(ALL) NOPASSWD: ALL\n"
      }
      PP

      # Run it twice and test for idempotency
      apply_manifest(pp, catch_failures: true)
      expect(apply_manifest(pp, catch_failures: true).exit_code).to be_zero
    end

    describe file('/etc/sudoers.d/puppet_10_janedoe_nopasswd') do
      it { is_expected.to be_file }
      it { is_expected.to contain 'janedoe ALL=(ALL) NOPASSWD: ALL' }
    end

    describe file('/etc/sudoers.d/file-from-rpm') do
      it { is_expected.to exist }
    end
  end

  context 'with ignore and prefix specified without managed file' do
    describe command('touch /etc/sudoers.d/file-from-rpm') do
      its(:exit_status) { is_expected.to eq 0 }
    end

    describe command('chmod 0440 /etc/sudoers.d/file-from-rpm') do
      its(:exit_status) { is_expected.to eq 0 }
    end

    it 'without a puppet managed file' do
      pp = <<-PP
      class {'sudo':
        prefix       => '_puppet_',
        purge_ignore => '[!puppet_]*',
      }
      PP
      # Run it twice and test for idempotency
      apply_manifest(pp, catch_failures: true)
      expect(apply_manifest(pp, catch_failures: true).exit_code).to be_zero
    end

    describe file('/etc/sudoers.d/puppet_10_janedoe_nopasswd') do
      it { is_expected.not_to exist }
    end

    describe file('/etc/sudoers.d/file-from-rpm') do
      it { is_expected.to exist }
    end
  end
end

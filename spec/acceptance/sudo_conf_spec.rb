# frozen_string_literal: true

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

  { prefix: 'puppet_', suffix: '_puppet' }.each do |k, v|
    context "with ignore and #{k} set to #{v} specified managed file" do
      case k
      when :prefix
        purge_ignore = "[!#{v}]*"
        target_fname = "/etc/sudoers.d/#{v}10_janedoe_nopasswd"
      else
        purge_ignore = "[*!#{v}]"
        target_fname = "/etc/sudoers.d/10_janedoe_nopasswd#{v}"
      end

      describe command('touch /etc/sudoers.d/file-from-rpm'), :a do
        its(:exit_status) { is_expected.to eq 0 }
      end

      describe command('chmod 0440 /etc/sudoers.d/file-from-rpm') do
        its(:exit_status) { is_expected.to eq 0 }
      end

      it 'create a puppet managed file' do
        pp = <<-PP
        class {'sudo':
          #{k}         => '#{v}',
          purge_ignore => '#{purge_ignore}',
        }
        sudo::conf { 'janedoe_nopasswd':
          content => "janedoe ALL=(ALL) NOPASSWD: ALL\n"
        }
        PP

        # Run it twice and test for idempotency
        apply_manifest(pp, catch_failures: true)
        expect(apply_manifest(pp, catch_failures: true).exit_code).to be_zero
      end

      describe file(target_fname) do
        it { is_expected.to be_file }
        it { is_expected.to contain 'janedoe ALL=(ALL) NOPASSWD: ALL' }
      end

      describe file('/etc/sudoers.d/file-from-rpm') do
        it { is_expected.to exist }
      end
    end

    context "with ignore and #{k} set to #{v} specified without managed file" do
      purge_ignore = case k
                     when :prefix
                       "[!#{v}]*"
                     else
                       "[*!#{v}]"
                     end

      describe command('touch /etc/sudoers.d/file-from-rpm'), :b do
        its(:exit_status) { is_expected.to eq 0 }
      end

      describe command('chmod 0440 /etc/sudoers.d/file-from-rpm') do
        its(:exit_status) { is_expected.to eq 0 }
      end

      it 'without a puppet managed file' do
        pp = <<-PP
        class {'sudo':
          #{k}         => '#{v}',
          purge_ignore => '#{purge_ignore}',
        }
        PP
        # Run it twice and test for idempotency
        apply_manifest(pp, catch_failures: true)
        expect(apply_manifest(pp, catch_failures: true).exit_code).to be_zero
      end

      describe file('/etc/sudoers.d/file-from-rpm') do
        it { is_expected.to exist }
      end
    end
  end
end

require 'spec_helper_acceptance'

describe 'sudo::conf class' do

  context 'default parameters' do
    # Using puppet_apply as a helper
    it 'should work with no errors' do
      pp = <<-EOS
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
      class {'sudo':
        purge               => false,
        config_file_replace => false,
      }
      ->
      sudo::conf { 'janedoe_nopasswd':
        content => "janedoe ALL=(ALL) NOPASSWD: ALL\n"
      }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_failures => true)
    end

    describe command("su - janedoe -c 'echo Hello World'") do
      its(:stdout) { should match /Hello World/ }
    end
  end
end

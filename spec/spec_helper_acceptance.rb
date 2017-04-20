require 'beaker-rspec'

# Install Puppet
unless ENV['RS_PROVISION'] == 'no'
  # This will install the latest available package on el and deb based
  # systems fail on windows and osx, and install via gem on other *nixes
  foss_opts = { :default_action => 'gem_install' }

  default.is_pe? ? install_pe : install_puppet(foss_opts)

  hosts.each do |host|
    on host, "mkdir -p #{host['distmoduledir']}"
  end
end

UNSUPPORTED_PLATFORMS = ['windows'].freeze

RSpec.configure do |c|
  # Project root
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    # Install module and dependencies
    puppet_module_install(:source => proj_root, :module_name => 'sudo')
    hosts.each do |_host|
      shell("/bin/touch #{default['puppetpath']}/hiera.yaml")
      shell('puppet module install puppetlabs-stdlib --version >= 2.6.0', :acceptable_exit_codes => [0])
    end
  end
end

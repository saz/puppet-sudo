# Class: sudo::configs
#
# This class enables support for a full hiera based sudoers configuration.
# Hiera functionality is auto enabled during the initial sudo module load;
#   this class is not intended to be loaded directly.
#
# See the primary sudo module documentation for usage and examples.
#
class sudo::configs {

  # NOTE: hiera_hash does not work as expected in a parameterized class
  #   definition; so we call it here.
  #
  # http://docs.puppetlabs.com/hiera/1/puppet.html#limitations
  # https://tickets.puppetlabs.com/browse/HI-118
  #
  # NOTE: There is no way to detect the existence of hiera. This functionality
  #   is therefore made exclusive to Puppet 3+ (hiera is embedded) in order
  #   to preserve backwards compatibility.
  #
  # http://projects.puppetlabs.com/issues/12345
  #
  if (versioncmp($::puppetversion, '3') != -1) {
    $configs = hiera_hash('sudo::configs', undef)

    if $configs {
      create_resources('::sudo::conf', $configs)
    }
  }

}


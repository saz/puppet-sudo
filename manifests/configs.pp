# Class: sudo::configs
#
# This class enables support for a full hiera based sudoers configuration.
# Hiera functionality is auto enabled during the initial sudo module load;
#   this class is not intended to be loaded directly.
#
# See the primary sudo module documentation for usage and examples.
#
class sudo::configs (
    $configs_hash = {},
  ){

  validate_hash ( $configs_hash )
  # NOTE: hiera_hash does not work as expected in a parameterized class
  #   definition; so we call it here.
  #
  # http://docs.puppetlabs.com/hiera/1/puppet.html#limitations
  # https://tickets.puppetlabs.com/browse/HI-118
  #
  $configs = hiera_hash('sudo::configs', $configs_hash)

  if !empty($configs) {
    create_resources('sudo::conf', $configs)
  }

}


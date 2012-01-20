class sudo::params {
  case $::operatingsystem {
    ubuntu, debian: {
      $package = 'sudo'
      $config_file = '/etc/sudoers'
      $config_dir = '/etc/sudoers.d/'
      $source = 'puppet:///modules/sudo/sudoers'
    }
    default: {
      fail("Unsupported platform: ${::operatingsystem}")
    }
  }
}

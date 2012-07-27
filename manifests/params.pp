class sudo::params {
  case $::osfamily {
    'Debian': {
      $package = 'sudo'
      $config_file = '/etc/sudoers'
      $config_dir = '/etc/sudoers.d/'
      $source = 'puppet:///modules/sudo/sudoers.deb'
    }
    'RedHat': {
      $package = 'sudo'
      $config_file = '/etc/sudoers'
      $config_dir = '/etc/sudoers.d/'
      $source = 'puppet:///modules/sudo/sudoers.rhel'
    }
    'Suse': {
      $package = 'sudo'
      $config_file = '/etc/sudoers'
      $config_dir = '/etc/sudoers.d/'
      $source = 'puppet:///modules/sudo/sudoers.suse'
    }
    default: {
      case $::operatingsystem {
        'gentoo': {
          $package = 'sudo'
          $config_file = '/etc/sudoers'
          $config_dir = '/etc/sudoers.d/'
          $source = 'puppet:///modules/sudo/sudoers.deb'
        }
        default: {
          fail("Unsupported platform: ${::osfamily} or ${::operatingsystem}")
        }
      }
    }
  }
}

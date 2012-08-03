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
    'Solaris': {
      $package = 'SFWsudo'
      $config_file = '/opt/sfw/etc/sudoers'
      $config_dir = '/opt/sfw/etc/sudoers.d/'
      $source = 'puppet:///modules/sudo/sudoers.solaris'
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

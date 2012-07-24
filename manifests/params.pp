class sudo::params {
  case $::operatingsystem {
    ubuntu, debian, gentoo: {
      $package = 'sudo'
      $config_file = '/etc/sudoers'
      $config_dir = '/etc/sudoers.d/'
      $source = 'puppet:///modules/sudo/sudoers.deb'
    }
    redhat, centos, fedora: {
      $package = 'sudo'
      $config_file = '/etc/sudoers'
      $config_dir = '/etc/sudoers.d/'
      $source = 'puppet:///modules/sudo/sudoers.rhel'
    }
    "OpenSuSE", "SLES", "SLED", "SuSE":  {
      $package = 'sudo'
      $config_file = '/etc/sudoers'
      $config_dir = '/etc/sudoers.d/'
      $source = 'puppet:///modules/sudo/sudoers.suse'
    }
    default: {
      fail("Unsupported platform: ${::operatingsystem}")
    }
  }
}

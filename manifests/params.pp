class sudo::params {
  $source_base = "puppet:///modules/${module_name}/"

  case $::osfamily {
    debian: {
      $package = 'sudo'
      $config_file = '/etc/sudoers'
      $config_dir = '/etc/sudoers.d/'
      $source = "${source_base}sudoers.deb"
      $config_file_group = 'root'
    }
    redhat: {
      $package = 'sudo'
      $config_file = '/etc/sudoers'
      $config_dir = '/etc/sudoers.d/'
      $source = "${source_base}sudoers.rhel"
      $config_file_group = 'root'
    }
    suse: {
      $package = 'sudo'
      $config_file = '/etc/sudoers'
      $config_dir = '/etc/sudoers.d/'
      $source = "${source_base}sudoers.suse"
      $config_file_group = 'root'
    }
    solaris: {
      $package = 'SFWsudo'
      $config_file = '/opt/sfw/etc/sudoers'
      $config_dir = '/opt/sfw/etc/sudoers.d/'
      $source = "${source_base}sudoers.solaris"
      $config_file_group = 'root'
    }
    freebsd: {
      $package = 'security/sudo'
      $config_file = '/usr/local/etc/sudoers'
      $config_dir = '/usr/local/etc/sudoers.d'
      $source = "${source_base}sudoers.freebsd"
      $config_file_group = 'wheel'
    }
    default: {
      case $::operatingsystem {
        gentoo, archlinux: {
          $package = 'sudo'
          $config_file = '/etc/sudoers'
          $config_dir = '/etc/sudoers.d/'
          $source = "${source_base}sudoers.deb"
          $config_file_group = 'root'
        }
        default: {
          fail("Unsupported platform: ${::osfamily}/${::operatingsystem}")
        }
      }
    }
  }
}

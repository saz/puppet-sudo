#class sudo::params 
#Set the paramters for the sudo module
class sudo::params {
  $source_base = "puppet:///modules/${module_name}/"

  case $::osfamily {
    debian: {
      $package_admin_file = false
      $package_source = false
      case $::operatingsystem {
        'Ubuntu': {
          $source = "${source_base}sudoers.ubuntu"
        }
        default: {

          case $::lsbdistcodename {
            'wheezy': {
              $source = "${source_base}sudoers.wheezy"
            }
            default: {
              $source = "${source_base}sudoers.deb"
            }
          }
        }
      }
      $package           = 'sudo'
      $package_ensure    = 'present'
      $config_file       = '/etc/sudoers'
      $config_dir        = '/etc/sudoers.d/'
      $config_file_group = 'root'
    }
    redhat: {
      $package_admin_file = false
      $package_source = false
      $package = 'sudo'

      # rhel 5.0 to 5.4 use sudo 1.6.9 which does not support
      # includedir, so we have to make sure sudo 1.7 (comes with rhel
      # 5.5) is installed.
      $package_ensure = $::operatingsystemrelease ? {
        /^5.[01234]/ => "latest",
        default     => "present",
      }
      $config_file = '/etc/sudoers'
      $config_dir = '/etc/sudoers.d/'
      $source = $::operatingsystemrelease ? {
        /^5/    => "${source_base}sudoers.rhel5",
        /^6/    => "${source_base}sudoers.rhel6",
        default => "${source_base}sudoers.rhel6",
        }
      $config_file_group = 'root'
    }
    suse: {
      $package_admin_file = false
      $package_source = false
      $package = 'sudo'
      $package_ensure = 'present'
      $config_file = '/etc/sudoers'
      $config_dir = '/etc/sudoers.d/'
      $source = "${source_base}sudoers.suse"
      $config_file_group = 'root'
    }
    solaris: {
      case $::operatingsystem {
        'OmniOS': {
          $package_admin_file = false
          $package_source = false
          $package = 'sudo'
          $package_ensure = 'present'
          $config_file = '/etc/sudoers'
          $config_dir = '/etc/sudoers.d/'
          $source = "${source_base}sudoers.omnios"
          $config_file_group = 'root'
        }
        default: {
          case $::kernelrelease {
            '5.11': {
              $package_admin_file = false
              $package_source = false
              $package = 'pkg://solaris/security/sudo'
              $package_ensure = 'present'
              $config_file = '/etc/sudoers'
              $config_dir = '/etc/sudoers.d/'
              $source = "${source_base}sudoers.solaris"
              $config_file_group = 'root'
            }
            '5.10': {
              $package = 'TCMsudo'
              $package_ensure = 'present'
              $package_source = 'http://www.sudo.ws/sudo/dist/packages/Solaris/10/TCMsudo-1.8.9p5-i386.pkg.gz'
              $package_admin_file = '/var/sadm/install/admin/puppet'
              $config_file = '/etc/sudoers'
              $config_dir = '/etc/sudoers.d/'
              $source = "${source_base}sudoers.solaris"
              $config_file_group = 'root'
            }
            default: {
              fail("Unsupported platform: ${::osfamily}/${::operatingsystem}/${::kernelrelease}")
            }
          }
        }
      }
    }
    freebsd: {
      $package_admin_file = false
      $package_source = false
      $package = 'security/sudo'
      $package_ensure = 'present'
      $config_file = '/usr/local/etc/sudoers'
      $config_dir = '/usr/local/etc/sudoers.d/'
      $source = "${source_base}sudoers.freebsd"
      $config_file_group = 'wheel'
    }
    aix: {
      $package_admin_file = false
      $package_source = false
      $package = 'sudo'
      $package_ensure = 'present'
      $package_source = 'http://www.sudo.ws/sudo/dist/packages/AIX/5.3/sudo-1.8.9-6.aix53.lam.rpm'
      $config_file = '/etc/sudoers'
      $config_dir = '/etc/sudoers.d/'
      $source = "${source_base}sudoers.aix"
      $config_file_group = 'system'
    }
    default: {
      $package_admin_file = false
      $package_source = false
      case $::operatingsystem {
        gentoo: {
          $package = 'sudo'
          $package_ensure = 'present'
          $config_file = '/etc/sudoers'
          $config_dir = '/etc/sudoers.d/'
          $source = "${source_base}sudoers.deb"
          $config_file_group = 'root'
        }
        archlinux: {
          $package = 'sudo'
          $package_ensure = 'present'
          $config_file = '/etc/sudoers'
          $config_dir = '/etc/sudoers.d/'
          $source = "${source_base}sudoers.archlinux"
          $config_file_group = 'root'
        }
        amazon: {
          $package = 'sudo'
          $package_ensure = 'present'
          $config_file = '/etc/sudoers'
          $config_dir = '/etc/sudoers.d/'
          $source = $::operatingsystemrelease ? {
            /^5/    => "${source_base}sudoers.rhel5",
            /^6/    => "${source_base}sudoers.rhel6",
            default => "${source_base}sudoers.rhel6",
          }
          $config_file_group = 'root'
        }
        default: {
          fail("Unsupported platform: ${::osfamily}/${::operatingsystem}")
        }
      }
    }
  }
}

#class sudo::params 
#Set the paramters for the sudo module
class sudo::params {
  $source_base = "puppet:///modules/${module_name}/"

  case $::osfamily {
    debian: {
      case $::operatingsystem {
        'Ubuntu': {
          $source = "${source_base}sudoers.ubuntu"
        }
        default: {
          if (0 + $::operatingsystemmajrelease >= 7) {
            $source = "${source_base}sudoers.debian"
          } else {
            $source = "${source_base}sudoers.olddebian"
          }
        }
      }
      $package           = 'sudo'
      $package_ensure    = 'present'
      $package_source    = ''
      $package_admin_file = ''
      $config_file       = '/etc/sudoers'
      $config_dir        = '/etc/sudoers.d/'
      $config_file_group = 'root'
    }
    redhat: {
      $package = 'sudo'

      # rhel 5.0 to 5.4 use sudo 1.6.9 which does not support
      # includedir, so we have to make sure sudo 1.7 (comes with rhel
      # 5.5) is installed.
      $package_ensure = $::operatingsystemrelease ? {
        /^5.[01234]/ => 'latest',
        default      => 'present',
      }
      $package_source = ''
      $package_admin_file = ''
      $config_file = '/etc/sudoers'
      $config_dir = '/etc/sudoers.d/'
      $source = $::operatingsystemrelease ? {
        /^5/    => "${source_base}sudoers.rhel5",
        /^6/    => "${source_base}sudoers.rhel6",
        /^7/    => "${source_base}sudoers.rhel7",
        default => "${source_base}sudoers.rhel6",
        }
      $config_file_group = 'root'
    }
    suse: {
      $package = 'sudo'
      $package_ensure = 'present'
      $package_source = ''
      $package_admin_file = ''
      $config_file = '/etc/sudoers'
      $config_dir = '/etc/sudoers.d/'
      $source = "${source_base}sudoers.suse"
      $config_file_group = 'root'
    }
    solaris: {
      case $::operatingsystem {
        'OmniOS': {
          $package = 'sudo'
          $package_ensure = 'present'
          $package_source = ''
          $package_admin_file = ''
          $config_file = '/etc/sudoers'
          $config_dir = '/etc/sudoers.d/'
          $source = "${source_base}sudoers.omnios"
          $config_file_group = 'root'
        }
        default: {
          case $::kernelrelease {
            '5.11': {
              $package = 'pkg://solaris/security/sudo'
              $package_ensure = 'present'
              $package_source = ''
              $package_admin_file = ''
              $config_file = '/etc/sudoers'
              $config_dir = '/etc/sudoers.d/'
              $source = "${source_base}sudoers.solaris"
              $config_file_group = 'root'
            }
            '5.10': {
              $package = 'TCMsudo'
              $package_ensure = 'present'
              $package_source = "http://www.sudo.ws/sudo/dist/packages/Solaris/10/TCMsudo-1.8.9p5-${::hardwareisa}.pkg.gz"
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
      $package = 'security/sudo'
      $package_ensure = 'present'
      $package_source = ''
      $package_admin_file = ''
      $config_file = '/usr/local/etc/sudoers'
      $config_dir = '/usr/local/etc/sudoers.d/'
      $source = "${source_base}sudoers.freebsd"
      $config_file_group = 'wheel'
    }
    openbsd: {
      $package = undef
      $package_ensure = 'present'
      $package_source = ''
      $package_admin_file = ''
      $config_file = '/etc/sudoers'
      $config_dir = '/etc/sudoers.d/'
      $source = "${source_base}sudoers.openbsd"
      $config_file_group = 'wheel'
    }
    aix: {
      $package = 'sudo'
      $package_ensure = 'present'
      $package_source = 'http://www.sudo.ws/sudo/dist/packages/AIX/5.3/sudo-1.8.9-6.aix53.lam.rpm'
      $package_admin_file = ''
      $config_file = '/etc/sudoers'
      $config_dir = '/etc/sudoers.d/'
      $source = "${source_base}sudoers.aix"
      $config_file_group = 'system'
    }
    default: {
      case $::operatingsystem {
        gentoo: {
          $package = 'sudo'
          $package_ensure = 'present'
          $config_file = '/etc/sudoers'
          $config_dir = '/etc/sudoers.d/'
          $source = "${source_base}sudoers.gentoo"
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
      $package_source = ''
      $package_admin_file = ''
    }
  }
}

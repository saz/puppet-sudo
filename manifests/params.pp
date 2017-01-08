#class sudo::params
#Set the paramters for the sudo module
class sudo::params {
  $source_base = "puppet:///modules/${module_name}/"

  case $::osfamily {
    'Debian': {
      case $::operatingsystem {
        'Ubuntu': {
          $source = "${source_base}sudoers.ubuntu"
        }
        default: {
          if (versioncmp($::operatingsystemmajrelease, '7') >= 0) or
            ($::operatingsystemmajrelease =~ /\/sid/) or
            ($::operatingsystemmajrelease =~ /Kali/) {
            $source = "${source_base}sudoers.debian"
          } else {
            $source = "${source_base}sudoers.olddebian"
          }
        }
      }
      $package = 'sudo'
      $package_ldap = 'sudo-ldap'
      $package_ensure    = 'present'
      $package_source    = ''
      $package_admin_file = ''
      $config_file       = '/etc/sudoers'
      $includedirsudoers = false
      $config_dir        = '/etc/sudoers.d/'
      $config_file_group = 'root'
    }
    'RedHat': {
      $package = 'sudo'
      # in redhat sudo package is already compiled for ldap support
      $package_ldap = $package

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
      $includedirsudoers = $::operatingsystemmajrelease ? {
        '5'     => true,
        default => false,
      }
      $config_dir = '/etc/sudoers.d/'
      $source = $::operatingsystemrelease ? {
        /^5/    => "${source_base}sudoers.rhel5",
        /^6/    => "${source_base}sudoers.rhel6",
        /^7/    => "${source_base}sudoers.rhel7",
        default => "${source_base}sudoers.rhel6",
        }
      $config_file_group = 'root'
    }
    'Suse': {
      $package = 'sudo'
      $package_ldap = $package
      $package_ensure = 'present'
      $package_source = ''
      $package_admin_file = ''
      $config_file = '/etc/sudoers'
      $includedirsudoers = false
      $config_dir = '/etc/sudoers.d/'
      $source = "${source_base}sudoers.suse"
      $config_file_group = 'root'
    }
    'Solaris': {
      case $::operatingsystem {
        'OmniOS': {
          $package = 'sudo'
          $package_ldap = undef
          $package_ensure = 'present'
          $package_source = ''
          $package_admin_file = ''
          $config_file = '/etc/sudoers'
          $includedirsudoers = false
          $config_dir = '/etc/sudoers.d/'
          $source = "${source_base}sudoers.omnios"
          $config_file_group = 'root'
        }
        'SmartOS': {
          $package = 'sudo'
          $package_ldap = undef
          $package_ensure = 'present'
          $package_source = ''
          $package_admin_file = ''
          $config_file = '/opt/local/etc/sudoers'
          $config_dir = '/opt/local/etc/sudoers.d/'
          $source = "${source_base}sudoers.smartos"
          $config_file_group = 'root'
        }
        default: {
          case $::kernelrelease {
            '5.11': {
              $package = 'pkg://solaris/security/sudo'
              $package_ldap = undef
              $package_ensure = 'present'
              $package_source = ''
              $package_admin_file = ''
              $config_file = '/etc/sudoers'
              $includedirsudoers = false
              $config_dir = '/etc/sudoers.d/'
              $source = "${source_base}sudoers.solaris"
              $config_file_group = 'root'
            }
            '5.10': {
              $package = 'TCMsudo'
              $package_ldap = undef
              $package_ensure = 'present'
              $package_source = "http://www.sudo.ws/sudo/dist/packages/Solaris/10/TCMsudo-1.8.9p5-${::hardwareisa}.pkg.gz"
              $package_admin_file = '/var/sadm/install/admin/puppet'
              $config_file = '/etc/sudoers'
              $includedirsudoers = false
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
    'FreeBSD': {
      $package = 'security/sudo'
      $package_ldap = undef
      $package_ensure = 'present'
      $package_source = ''
      $package_admin_file = ''
      $config_file = '/usr/local/etc/sudoers'
      $includedirsudoers = false
      $config_dir = '/usr/local/etc/sudoers.d/'
      $source = "${source_base}sudoers.freebsd"
      $config_file_group = 'wheel'
    }
    'OpenBSD': {
      if (versioncmp($::kernelversion, '5.8') < 0) {
        $package = undef
      } else {
        $package = 'sudo'
      }
      $package_ldap = undef
      $package_ensure = 'present'
      $package_source = ''
      $package_admin_file = ''
      $config_file = '/etc/sudoers'
      $includedirsudoers = false
      $config_dir = '/etc/sudoers.d/'
      $source = "${source_base}sudoers.openbsd"
      $config_file_group = 'wheel'
    }
    'AIX': {
      $package = 'sudo'
      $package_ldap = undef
      $package_ensure = 'present'
      $package_source = 'http://www.sudo.ws/sudo/dist/packages/AIX/5.3/sudo-1.8.9-6.aix53.lam.rpm'
      $package_admin_file = ''
      $config_file = '/etc/sudoers'
      $includedirsudoers = false
      $config_dir = '/etc/sudoers.d/'
      $source = "${source_base}sudoers.aix"
      $config_file_group = 'system'
    }
    'Darwin': {
      $package = undef
      $package_ldap = undef
      $package_ensure = 'present'
      $package_source = ''
      $package_admin_file = ''
      $config_file = '/etc/sudoers'
      $config_dir = '/etc/sudoers.d/'
      $source = "${source_base}sudoers.darwin"
      $config_file_group = 'wheel'
    }
    default: {
      case $::operatingsystem {
        'Gentoo': {
          $package = 'sudo'
          $package_ldap = $package
          $package_ensure = 'present'
          $config_file = '/etc/sudoers'
          $includedirsudoers = false
          $config_dir = '/etc/sudoers.d/'
          $source = "${source_base}sudoers.gentoo"
          $config_file_group = 'root'
        }
        'Archlinux': {
          $package = 'sudo'
          $package_ldap = $package
          $package_ensure = 'present'
          $config_file = '/etc/sudoers'
          $includedirsudoers = false
          $config_dir = '/etc/sudoers.d/'
          $source = "${source_base}sudoers.archlinux"
          $config_file_group = 'root'
        }
        'Amazon': {
          $package = 'sudo'
          $package_ldap = $package
          $package_ensure = 'present'
          $config_file = '/etc/sudoers'
          $includedirsudoers = false
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

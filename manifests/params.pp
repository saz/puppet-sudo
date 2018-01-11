#class sudo::params
#Set the paramters for the sudo module
class sudo::params {
  $content_base     = "${module_name}/"
  $config_file_mode = '0440'
  $config_dir_mode  = '0550'

  case $::osfamily {
    'Debian': {
      case $::operatingsystem {
        'Ubuntu': {
          $content = "${content_base}sudoers.ubuntu.erb"
        }
        default: {
          if (versioncmp($::operatingsystemmajrelease, '7') >= 0) or
            ($::operatingsystemmajrelease =~ /\/sid/) or
            ($::operatingsystemmajrelease =~ /Kali/) {
            $content = "${content_base}sudoers.debian.erb"
          } else {
            $content = "${content_base}sudoers.olddebian.erb"
          }
        }
      }
      $package = 'sudo'
      $package_ldap = 'sudo-ldap'
      $package_ensure    = 'present'
      $package_source    = ''
      $package_admin_file = ''
      $config_file       = '/etc/sudoers'
      $config_dir        = '/etc/sudoers.d'
      $config_file_group = 'root'
      $config_dir_keepme = false
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
      $config_dir = '/etc/sudoers.d'
      $content = $::operatingsystemrelease ? {
        /^5/    => "${content_base}sudoers.rhel5.erb",
        /^6/    => "${content_base}sudoers.rhel6.erb",
        /^7/    => "${content_base}sudoers.rhel7.erb",
        default => "${content_base}sudoers.rhel6.erb",
        }
      $config_file_group = 'root'
      $config_dir_keepme = false
    }
    'Suse': {
      $package = 'sudo'
      $package_ldap = $package
      $package_ensure = 'present'
      $package_source = ''
      $package_admin_file = ''
      $config_file = '/etc/sudoers'
      $config_dir = '/etc/sudoers.d'
      $content = "${content_base}sudoers.suse.erb"
      $config_file_group = 'root'
      $config_dir_keepme = false
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
          $config_dir = '/etc/sudoers.d'
          $content = "${content_base}sudoers.omnios.erb"
          $config_file_group = 'root'
          $config_dir_keepme = false
        }
        'SmartOS': {
          $package = 'sudo'
          $package_ldap = undef
          $package_ensure = 'present'
          $package_source = ''
          $package_admin_file = ''
          $config_file = '/opt/local/etc/sudoers'
          $config_dir = '/opt/local/etc/sudoers.d'
          $content = "${content_base}sudoers.smartos.erb"
          $config_file_group = 'root'
          $config_dir_keepme = false
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
              $config_dir = '/etc/sudoers.d'
              $content = "${content_base}sudoers.solaris.erb"
              $config_file_group = 'root'
              $config_dir_keepme = false
            }
            '5.10': {
              $package = 'TCMsudo'
              $package_ldap = undef
              $package_ensure = 'present'
              $package_source = "http://www.sudo.ws/sudo/dist/packages/Solaris/10/TCMsudo-1.8.9p5-${::hardwareisa}.pkg.gz"
              $package_admin_file = '/var/sadm/install/admin/puppet'
              $config_file = '/etc/sudoers'
              $config_dir = '/etc/sudoers.d'
              $content = "${content_base}sudoers.solaris.erb"
              $config_file_group = 'root'
              $config_dir_keepme = false
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
      $config_dir = '/usr/local/etc/sudoers.d'
      $content = "${content_base}sudoers.freebsd.erb"
      $config_file_group = 'wheel'
      $config_dir_keepme = true
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
      $config_dir = '/etc/sudoers.d'
      $content = "${content_base}sudoers.openbsd.erb"
      $config_file_group = 'wheel'
      $config_dir_keepme = false
    }
    'AIX': {
      $package = 'sudo'
      $package_ldap = undef
      $package_ensure = 'present'
      $package_source = 'http://www.sudo.ws/sudo/dist/packages/AIX/5.3/sudo-1.8.9-6.aix53.lam.rpm'
      $package_admin_file = ''
      $config_file = '/etc/sudoers'
      $config_dir = '/etc/sudoers.d'
      $content = "${content_base}sudoers.aix.erb"
      $config_file_group = 'system'
      $config_dir_keepme = false
    }
    'Darwin': {
      $package = undef
      $package_ldap = undef
      $package_ensure = 'present'
      $package_source = ''
      $package_admin_file = ''
      $config_file = '/etc/sudoers'
      $config_dir = '/etc/sudoers.d'
      $content = "${content_base}sudoers.darwin.erb"
      $config_file_group = 'wheel'
      $config_dir_keepme = false
    }
    default: {
      case $::operatingsystem {
        'Gentoo': {
          $package = 'sudo'
          $package_ldap = $package
          $package_ensure = 'present'
          $config_file = '/etc/sudoers'
          $config_dir = '/etc/sudoers.d'
          $content = "${content_base}sudoers.gentoo.erb"
          $config_file_group = 'root'
          $config_dir_keepme = false
        }
        'Archlinux': {
          $package = 'sudo'
          $package_ldap = $package
          $package_ensure = 'present'
          $config_file = '/etc/sudoers'
          $config_dir = '/etc/sudoers.d'
          $content = "${content_base}sudoers.archlinux.erb"
          $config_file_group = 'root'
          $config_dir_keepme = false
        }
        'Amazon': {
          $package = 'sudo'
          $package_ldap = $package
          $package_ensure = 'present'
          $config_file = '/etc/sudoers'
          $config_dir = '/etc/sudoers.d'
          $content = $::operatingsystemrelease ? {
            /^5/    => "${content_base}sudoers.rhel5.erb",
            /^6/    => "${content_base}sudoers.rhel6.erb",
            default => "${content_base}sudoers.rhel6.erb",
          }
          $config_file_group = 'root'
          $config_dir_keepme = false
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

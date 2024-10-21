# @summary
#   Params class for the sudo module
#
# @api private
class sudo::params {
  $content_base     = "${module_name}/"
  $config_file_mode = '0440'
  $config_dir_mode  = '0550'

  case $facts['os']['family'] {
    'Debian': {
      case $facts['os']['name'] {
        'Ubuntu': {
          $content_template = "${content_base}sudoers.ubuntu.epp"
          $secure_path      = '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/puppetlabs/bin:/snap/bin'
        }
        default: {
          $content_template = "${content_base}sudoers.debian.epp"
          $secure_path      = '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/puppetlabs/bin'
        }
      }
      $package            = 'sudo'
      $package_ldap       = 'sudo-ldap'
      $package_ensure     = 'present'
      $package_source     = undef
      $package_admin_file = undef
      $config_file        = '/etc/sudoers'
      $config_dir         = '/etc/sudoers.d'
      $config_file_group  = 'root'
      $config_dir_keepme  = false
      $package_provider   = undef
      $wheel_config       = 'absent'
      $defaults           = {
        'env_reset'    => undef,
        'mail_badpass' => undef,
      }
    }
    'RedHat': {
      $package = 'sudo'
      # in redhat sudo package is already compiled for ldap support
      $package_ldap = $package

      $package_ensure     = 'present'
      $package_source     = undef
      $package_admin_file = undef
      $config_file        = '/etc/sudoers'
      $config_dir         = '/etc/sudoers.d'
      $content_template   = "${content_base}sudoers.rhel.epp"

      case [$facts['os']['name'], $facts['os']['release']['major']] {
        ['Amazon', '2023']: {
          $secure_path = '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/puppetlabs/bin:/var/lib/snapd/snap/bin'
        }
        default: {
          $secure_path = '/sbin:/bin:/usr/sbin:/usr/bin:/opt/puppetlabs/bin'
        }
      }

      $wheel_config       = 'password'
      $config_file_group  = 'root'
      $config_dir_keepme  = false
      $package_provider   = undef
      $defaults           = {
        'env_reset' => undef,
      }
    }
    'Suse': {
      $package            = 'sudo'
      $package_ldap       = $package
      $package_ensure     = 'present'
      $package_source     = undef
      $package_admin_file = undef
      $config_file        = '/etc/sudoers'
      $config_dir         = '/etc/sudoers.d'
      $content_template   = "${content_base}sudoers.suse.epp"
      $secure_path        = '/usr/sbin:/usr/bin:/sbin:/bin:/opt/puppetlabs/bin'
      $config_file_group  = 'root'
      $config_dir_keepme  = false
      $package_provider   = undef
      $wheel_config       = 'absent'
      $defaults           = {}
    }
    'Solaris': {
      case $facts['os']['name'] {
        'OmniOS': {
          $package            = 'sudo'
          $package_ldap       = undef
          $package_ensure     = 'present'
          $package_source     = undef
          $package_admin_file = undef
          $config_file        = '/etc/sudoers'
          $config_dir         = '/etc/sudoers.d'
          $content_template   = "${content_base}sudoers.omnios.epp"
          $secure_path        = undef
          $config_file_group  = 'root'
          $config_dir_keepme  = false
          $package_provider   = undef
          $wheel_config       = 'absent'
        }
        'SmartOS': {
          $package            = 'sudo'
          $package_ldap       = undef
          $package_ensure     = 'present'
          $package_source     = undef
          $package_admin_file = undef
          $config_file        = '/opt/local/etc/sudoers'
          $config_dir         = '/opt/local/etc/sudoers.d'
          $content_template   = "${content_base}sudoers.smartos.epp"
          $secure_path        = undef
          $config_file_group  = 'root'
          $config_dir_keepme  = false
          $package_provider   = undef
          $wheel_config       = 'absent'
        }
        default: {
          case $facts['kernelrelease'] {
            '5.11': {
              $package            = 'pkg://solaris/security/sudo'
              $package_ldap       = undef
              $package_ensure     = 'present'
              $package_source     = undef
              $package_admin_file = undef
              $config_file        = '/etc/sudoers'
              $config_dir         = '/etc/sudoers.d'
              $content_template   = "${content_base}sudoers.solaris.epp"
              $secure_path        = undef
              $config_file_group  = 'root'
              $config_dir_keepme  = false
              $package_provider   = undef
              $wheel_config       = 'absent'
            }
            '5.10': {
              $package            = 'TCMsudo'
              $package_ldap       = undef
              $package_ensure     = 'present'
              $package_source     = "http://www.sudo.ws/sudo/dist/packages/Solaris/10/TCMsudo-1.8.9p5-${facts['os']['hardware']}.pkg.gz"
              $package_admin_file = '/var/sadm/install/admin/puppet'
              $config_file        = '/etc/sudoers'
              $config_dir         = '/etc/sudoers.d'
              $content_template   = "${content_base}sudoers.solaris.epp"
              $secure_path        = undef
              $config_file_group  = 'root'
              $config_dir_keepme  = false
              $package_provider   = undef
              $wheel_config       = 'absent'
            }
            default: {
              fail("Unsupported platform: ${facts['os']['family']}/${facts['os']['name']}/${facts['kernelrelease']}")
            }
          }
        }
      }
      $defaults           = {
        'env_reset' => undef,
      }
    }
    'FreeBSD': {
      $package            = 'security/sudo'
      $package_ldap       = undef
      $package_ensure     = 'present'
      $package_source     = undef
      $package_admin_file = undef
      $config_file        = '/usr/local/etc/sudoers'
      $config_dir         = '/usr/local/etc/sudoers.d'
      $content_template   = "${content_base}sudoers.freebsd.epp"
      $secure_path        = '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/puppetlabs/bin'
      $config_file_group  = 'wheel'
      $config_dir_keepme  = true
      $package_provider   = undef
      $wheel_config       = 'absent'
      $defaults           = {}
    }
    'OpenBSD': {
      $package = 'sudo'
      $package_ldap       = undef
      $package_ensure     = 'present'
      $package_source     = undef
      $package_admin_file = undef
      $config_file        = '/etc/sudoers'
      $config_dir         = '/etc/sudoers.d'
      $content_template   = "${content_base}sudoers.openbsd.epp"
      $config_file_group  = 'wheel'
      $config_dir_keepme  = false
      $package_provider   = undef
      $wheel_config       = 'absent'
      $defaults           = {}
    }
    'AIX': {
      $package            = 'sudo'
      $package_ldap       = undef
      $package_ensure     = 'present'
      $package_source     = 'http://www.sudo.ws/sudo/dist/packages/AIX/5.3/sudo-1.8.27-1.aix53.rpm'
      $package_admin_file = undef
      $config_file        = '/etc/sudoers'
      $config_dir         = '/etc/sudoers.d'
      $content_template   = "${content_base}sudoers.aix.epp"
      $secure_path        = undef
      $config_file_group  = 'system'
      $config_dir_keepme  = false
      $package_provider   = 'rpm'
      $wheel_config       = 'absent'
      $defaults           = {}
    }
    'Darwin': {
      $package            = undef
      $package_ldap       = undef
      $package_ensure     = 'present'
      $package_source     = undef
      $package_admin_file = undef
      $config_file        = '/etc/sudoers'
      $config_dir         = '/etc/sudoers.d'
      $content_template   = "${content_base}sudoers.darwin.epp"
      $secure_path        = undef
      $config_file_group  = 'wheel'
      $config_dir_keepme  = false
      $package_provider   = undef
      $wheel_config       = 'absent'
      $defaults           = {
        'env_reset' => undef,
      }
    }
    default: {
      case $facts['os']['name'] {
        'Gentoo': {
          $package            = 'sudo'
          $package_ldap       = $package
          $package_ensure     = 'present'
          $package_source     = undef
          $package_admin_file = undef
          $config_file        = '/etc/sudoers'
          $config_dir         = '/etc/sudoers.d'
          $content_template   = "${content_base}sudoers.gentoo.epp"
          $secure_path        = undef
          $config_file_group  = 'root'
          $config_dir_keepme  = false
          $package_provider   = undef
          $wheel_config       = 'absent'
          $defaults           = {}
        }
        /^(Arch|Manjaro)(.{0}|linux)$/: {
          $package            = 'sudo'
          $package_ldap       = $package
          $package_ensure     = 'present'
          $package_source     = undef
          $package_admin_file = undef
          $config_file        = '/etc/sudoers'
          $config_dir         = '/etc/sudoers.d'
          $content_template   = "${content_base}sudoers.archlinux.epp"
          $secure_path        = undef
          $config_file_group  = 'root'
          $config_dir_keepme  = false
          $package_provider   = undef
          $wheel_config       = 'absent'
          $defaults           = {}
        }
        default: {
          fail("Unsupported platform: ${facts['os']['family']}/${facts['os']['name']}")
        }
      }
    }
  }
}

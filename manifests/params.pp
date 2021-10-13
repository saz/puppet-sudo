class sudo::params (
  $content_base     = "${module_name}/",
){
  $config_file_mode = '0440'
  $config_dir_mode  = '0550'
  case $facts['os']['family'] {
    'Debian': {
      case $facts['os']['name'] {
        'Ubuntu': {
          $content     = "${content_base}sudoers.ubuntu.erb"
          $secure_path = '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/puppetlabs/bin:/snap/bin'
        }
        default: {
          if (versioncmp($facts['os']['release']['major'], '7') >= 0) or
          ($facts['os']['release']['major'] =~ /\/sid/) or
          ($facts['os']['release']['major'] =~ /Kali/) {
            $content = "${content_base}sudoers.debian.erb"
            $secure_path = '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/puppetlabs/bin'
          } else {
            $content     = "${content_base}sudoers.olddebian.erb"
            $secure_path = undef
          }
        }
      }
      $package            = 'sudo'
      $package_ldap       = 'sudo-ldap'
      $package_ensure     = 'present'
      $package_source     = ''
      $package_admin_file = ''
      $config_file        = '/etc/sudoers'
      $config_dir         = '/etc/sudoers.d'
      $config_file_group  = 'root'
      $config_dir_keepme  = false
      $package_provider   = undef
    }
    'RedHat': {
      $package = 'sudo'
      # in redhat sudo package is already compiled for ldap support
      $package_ldap = $package

      # rhel 5.0 to 5.4 use sudo 1.6.9 which does not support
      # includedir, so we have to make sure sudo 1.7 (comes with rhel
      # 5.5) is installed.
      $package_ensure     = $facts['os']['release']['full'] ? {
        /^5.[01234]$/ => 'latest',
        default       => 'present',
      }
      $package_source     = ''
      $package_admin_file = ''
      $config_file        = '/etc/sudoers'
      $config_dir         = '/etc/sudoers.d'
      case $facts['os']['release']['full'] {
        /^5/: {
          $content     = "${content_base}sudoers.rhel5.erb"
          $secure_path = undef
        }
        /^6/: {
          $content     = "${content_base}sudoers.rhel6.erb"
          $secure_path = '/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin'
        }
        /^7/: {
          $content     = "${content_base}sudoers.rhel7.erb"
          $secure_path = '/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/opt/puppetlabs/bin'
        }
        /^8/: {
          $content     = "${content_base}sudoers.rhel8.erb"
          $secure_path = '/sbin:/bin:/usr/sbin:/usr/bin:/opt/puppetlabs/bin'
        }
        default: {
          $content     = "${content_base}sudoers.rhel8.erb"
          $secure_path = '/sbin:/bin:/usr/sbin:/usr/bin:/opt/puppetlabs/bin'
        }
      }
      $config_file_group  = 'root'
      $config_dir_keepme  = false
      $package_provider   = undef
    }
    'Suse': {
      $package            = 'sudo'
      $package_ldap       = $package
      $package_ensure     = 'present'
      $package_source     = ''
      $package_admin_file = ''
      $config_file        = '/etc/sudoers'
      $config_dir         = '/etc/sudoers.d'
      $content            = "${content_base}sudoers.suse.erb"
      $secure_path        = '/usr/sbin:/usr/bin:/sbin:/bin:/opt/puppetlabs/bin'
      $config_file_group  = 'root'
      $config_dir_keepme  = false
      $package_provider   = undef
    }
    'Solaris': {
      case $facts['os']['name'] {
        'OmniOS': {
          $package            = 'sudo'
          $package_ldap       = undef
          $package_ensure     = 'present'
          $package_source     = ''
          $package_admin_file = ''
          $config_file        = '/etc/sudoers'
          $config_dir         = '/etc/sudoers.d'
          $content            = "${content_base}sudoers.omnios.erb"
          $secure_path        = undef
          $config_file_group  = 'root'
          $config_dir_keepme  = false
          $package_provider   = undef
        }
        'SmartOS': {
          $package            = 'sudo'
          $package_ldap       = undef
          $package_ensure     = 'present'
          $package_source     = ''
          $package_admin_file = ''
          $config_file        = '/opt/local/etc/sudoers'
          $config_dir         = '/opt/local/etc/sudoers.d'
          $content            = "${content_base}sudoers.smartos.erb"
          $secure_path        = undef
          $config_file_group  = 'root'
          $config_dir_keepme  = false
          $package_provider   = undef
        }
        default: {
          case $::kernelrelease {
            '5.11': {
              $package            = 'pkg://solaris/security/sudo'
              $package_ldap       = undef
              $package_ensure     = 'present'
              $package_source     = ''
              $package_admin_file = ''
              $config_file        = '/etc/sudoers'
              $config_dir         = '/etc/sudoers.d'
              $content            = "${content_base}sudoers.solaris.erb"
              $secure_path        = undef
              $config_file_group  = 'root'
              $config_dir_keepme  = false
              $package_provider   = undef
            }
            '5.10': {
              $package            = 'TCMsudo'
              $package_ldap       = undef
              $package_ensure     = 'present'
              $package_source     = "http://www.sudo.ws/sudo/dist/packages/Solaris/10/TCMsudo-1.8.9p5-${facts['os']['hardware']}.pkg.gz"
              $package_admin_file = '/var/sadm/install/admin/puppet'
              $config_file        = '/etc/sudoers'
              $config_dir         = '/etc/sudoers.d'
              $content            = "${content_base}sudoers.solaris.erb"
              $secure_path        = undef
              $config_file_group  = 'root'
              $config_dir_keepme  = false
              $package_provider   = undef
            }
            default: {
              fail("Unsupported platform: ${facts['os']['family']}/${facts['os']['name']}/${::kernelrelease}")
            }
          }
        }
      }
    }
    'FreeBSD': {
      $package            = 'security/sudo'
      $package_ldap       = undef
      $package_ensure     = 'present'
      $package_source     = ''
      $package_admin_file = ''
      $config_file        = '/usr/local/etc/sudoers'
      $config_dir         = '/usr/local/etc/sudoers.d'
      $content            = "${content_base}sudoers.freebsd.erb"
      $secure_path        = '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/puppetlabs/bin'
      $config_file_group  = 'wheel'
      $config_dir_keepme  = true
      $package_provider   = undef
    }
    'OpenBSD': {
      if (versioncmp($::kernelversion, '5.8') < 0) {
        $package = undef
      } else {
        $package = 'sudo'
      }
      $package_ldap       = undef
      $package_ensure     = 'present'
      $package_source     = ''
      $package_admin_file = ''
      $config_file        = '/etc/sudoers'
      $config_dir         = '/etc/sudoers.d'
      $content            = "${content_base}sudoers.openbsd.erb"
      $config_file_group  = 'wheel'
      $config_dir_keepme  = false
      $package_provider   = undef
    }
    'AIX': {
      $package            = 'sudo'
      $package_ldap       = undef
      $package_ensure     = 'present'
      $package_source     = 'http://www.sudo.ws/sudo/dist/packages/AIX/5.3/sudo-1.8.27-1.aix53.rpm'
      $package_admin_file = ''
      $config_file        = '/etc/sudoers'
      $config_dir         = '/etc/sudoers.d'
      $content            = "${content_base}sudoers.aix.erb"
      $secure_path        = undef
      $config_file_group  = 'system'
      $config_dir_keepme  = false
      $package_provider   = 'rpm'
    }
    'Darwin': {
      $package            = undef
      $package_ldap       = undef
      $package_ensure     = 'present'
      $package_source     = ''
      $package_admin_file = ''
      $config_file        = '/etc/sudoers'
      $config_dir         = '/etc/sudoers.d'
      $content            = "${content_base}sudoers.darwin.erb"
      $secure_path        = undef
      $config_file_group  = 'wheel'
      $config_dir_keepme  = false
      $package_provider   = undef
    }
    default: {
      case $facts['os']['name'] {
        'Gentoo': {
          $package            = 'sudo'
          $package_ldap       = $package
          $package_ensure     = 'present'
          $package_source     = ''
          $package_admin_file = ''
          $config_file        = '/etc/sudoers'
          $config_dir         = '/etc/sudoers.d'
          $content            = "${content_base}sudoers.gentoo.erb"
          $secure_path        = undef
          $config_file_group  = 'root'
          $config_dir_keepme  = false
          $package_provider   = undef
        }
        /^(Arch|Manjaro)(.{0}|linux)$/: {
          $package            = 'sudo'
          $package_ldap       = $package
          $package_ensure     = 'present'
          $package_source     = ''
          $package_admin_file = ''
          $config_file        = '/etc/sudoers'
          $config_dir         = '/etc/sudoers.d'
          $content            = "${content_base}sudoers.archlinux.erb"
          $secure_path        = undef
          $config_file_group  = 'root'
          $config_dir_keepme  = false
          $package_provider   = undef
        }
        'Amazon': {
          $package            = 'sudo'
          $package_ldap       = $package
          $package_ensure     = 'present'
          $package_source     = ''
          $package_admin_file = ''
          $config_file        = '/etc/sudoers'
          $config_dir         = '/etc/sudoers.d'
          case $facts['os']['release']['full'] {
            /^5/: {
              $content     = "${content_base}sudoers.rhel5.erb"
              $secure_path = undef
            }
            /^6/: {
              $content     = "${content_base}sudoers.rhel6.erb"
              $secure_path = '/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin'
            }
            default: {
              $content     = "${content_base}sudoers.rhel6.erb"
              $secure_path = '/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin'
            }
          }
          $config_file_group  = 'root'
          $config_dir_keepme  = false
          $package_provider   = undef
        }
        default: {
          fail("Unsupported platform: ${facts['os']['family']}/${facts['os']['name']}")
        }
      }
    }
  }
}

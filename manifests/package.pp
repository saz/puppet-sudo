# == Class: sudo::package
#
# @summary
#   Installs the sudo package on various platforms.
#
# @param package
#   The name of the sudo package to be installed
#
# @param package_ensure
#   Ensure if present or absent
#
# @param package_source
#   Where to find the sudo packge, should be a local file or a uri
#
# @param package_provider
#   Set package provider
#
# @param package_admin_file
#   Solaris 10 package admin file for unattended installation
#
# @param ldap_enable
#   Set ldap use flag for sudo package
#
# @author
#   Toni Schmidbauer <toni@stderr.at>
#
# @api private
class sudo::package (
  Optional[String[1]] $package            = undef,
  String[1]           $package_ensure     = present,
  Optional[String[1]] $package_source     = undef,
  Optional[String[1]] $package_provider   = undef,
  Optional[String[1]] $package_admin_file = undef,
  Boolean             $ldap_enable        = false,
) {
  if $ldap_enable == true {
    case $facts['os']['family'] {
      'Gentoo': {
        if defined( 'portage' ) {
          Class['sudo'] -> Class['portage']
          package_use { 'app-admin/sudo':
            ensure => present,
            use    => ['ldap'],
            target => 'sudo-flags',
          }
        } else {
          fail ('portage package needed to define ldap use on sudo')
        }
      }
      default: {}
    }
  }

  case $facts['os']['family'] {
    'Darwin': {}
    'AIX': {
      class { 'sudo::package::aix':
        package        => $package,
        package_source => $package_source,
      }
    }
    'Solaris': {
      class { 'sudo::package::solaris':
        package            => $package,
        package_source     => $package_source,
        package_admin_file => $package_admin_file,
      }
    }
    default: {
      if $package {
        package { $package:
          ensure   => $package_ensure,
          provider => $package_provider,
        }
      }
    }
  }
}

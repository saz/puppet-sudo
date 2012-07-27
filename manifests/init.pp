# Class: sudo
#
# This module manages sudo
#
# Parameters:
#   [*ensure*]
#     Ensure if present or absent.
#     Default: present
#
#   [*autoupgrade*]
#     Upgrade package automatically, if there is a newer version.
#     Default: false
#
#   [*package*]
#     Name of the package.
#     Only set this, if your platform is not supported or you know,
#     what you're doing.
#     Default: auto-set, platform specific
#
#   [*config_file*]
#     Main configuration file.
#     Only set this, if your platform is not supported or you know,
#     what you're doing.
#     Default: auto-set, platform specific
#
#   [*config_file_replace*]
#     Replace configuration file with that one delivered with this module
#     Default: true
#
#   [*config_dir*]
#     Main configuration directory
#     Only set this, if your platform is not supported or you know,
#     what you're doing.
#     Default: auto-set, platform specific
#
#   [*source*]
#     Alternate source file location
#     Only set this, if your platform is not supported or you know,
#     what you're doing.
#     Default: auto-set, platform specific
#
# Actions:
#   Installs locales package and generates specified locales
#
# Requires:
#   Nothing
#
# Sample Usage:
#   class { 'locales':
#     locales => [
#       'en_US.UTF-8 UTF-8',
#       'de_DE.UTF-8 UTF-8',
#       'en_GB.UTF-8 UTF-8',
#     ],
#   }
#
# [Remember: No empty lines between comments and class definition]
class sudo(
  $ensure = 'present',
  $autoupgrade = false,
  $package = $sudo::params::package,
  $config_file = $sudo::params::config_file,
  $config_file_replace = true,
  $config_dir = $sudo::params::config_dir,
  $source = $sudo::params::source
) inherits sudo::params {

  case $ensure {
    /(present)/: {
      $dir_ensure = 'directory'
      if $autoupgrade == true {
        $package_ensure = 'latest'
      } else {
        $package_ensure = 'present'
      }
    }
    /(absent)/: {
      $package_ensure = 'absent'
      $dir_ensure = 'absent'
    }
    default: {
      fail('ensure parameter must be present or absent')
    }
  }

  package { $package:
    ensure => $package_ensure,
  }

  file { $config_file:
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0440',
    replace => $config_file_replace,
    source  => $source,
    require => Package[$package],
  }

  file { $config_dir:
    ensure  => $dir_ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0550',
    recurse => true,
    purge   => true,
    require => Package[$package],
  }
}

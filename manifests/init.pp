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
#   [*package_source*]
#     Where to find the package.
#     Only set this on AIX (required) or if your platform is not supported or you know,
#     what you're doing.
#     Default: auto-set
#
#   [*purge*]
#     Whether or not to purge sudoers.d directory
#     Default: false
#
#   [*config_file*]
#     Main configuration file.
#     Only set this, if your platform is not supported or you know,
#     what you're doing.
#     Default: auto-set, platform specific
#
#   [*config_file_replace*]
#     Replace configuration file with that one delivered with this module
#     Default: false
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
#   Installs sudo package and checks the state of sudoers file and sudoers.d directory.
#
# Requires:
#   Nothing
#
# Sample Usage:
#   class { 'sudo': }
#
# [Remember: No empty lines between comments and class definition]
class sudo(
  $ensure = 'present',
  $autoupgrade = false,
  $package = $sudo::params::package,
  $package_source = $sudo::params::package_source,
  $purge = false,
  $config_file = $sudo::params::config_file,
  $config_file_replace = false,
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

  class { 'sudo::package':
    package        => $package,
    package_ensure => $package_ensure,
    package_source => $package_source,
  }

  file { $config_file:
    ensure  => $ensure,
    owner   => 'root',
    group   => $sudo::params::config_file_group,
    mode    => '0440',
    replace => $config_file_replace,
    source  => $source,
    require => Package[$package],
  }

  file { $config_dir:
    ensure  => $dir_ensure,
    owner   => 'root',
    group   => $sudo::params::config_file_group,
    mode    => '0550',
    recurse => $purge,
    purge   => $purge,
    require => Package[$package],
  }
}

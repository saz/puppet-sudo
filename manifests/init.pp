# Class: sudo
#
# This module manages sudo
#
# Parameters:
#   [*ensure*]
#     Ensure if present or absent.
#     Default: present
#
#   [*package*]
#     Name of the package.
#     Only set this, if your platform is not supported or you know,
#     what you're doing.
#     Default: auto-set, platform specific
#
#   [*package_ensure*]
#     Allows you to ensure a particular version of a package
#     Default: present
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
  $enable = true,
  $package = $sudo::params::package,
  $package_ensure = present,
  $package_source = $sudo::params::package_source,
  $purge = true,
  $config_file = $sudo::params::config_file,
  $config_file_replace = true,
  $config_dir = $sudo::params::config_dir,
  $source = $sudo::params::source
) inherits sudo::params {


  validate_bool($enable)
  case $enable {
    true: {
      $dir_ensure = 'directory'
      $file_ensure = 'present'
    }
    false: {
      $dir_ensure = 'absent'
      $file_ensure = 'absent'
    }
  }

  class { 'sudo::package':
    package        => $package,
    package_ensure => $package_ensure,
    package_source => $package_source,
  }

  file { $config_file:
    ensure  => $file_ensure,
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

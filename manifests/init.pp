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
#     Default: present / lastest for RHEL < 5.5
#
#   [*package_source*]
#     Where to find the package.  Only set this on AIX (required) and
#     Solaris (required) or if your platform is not supported or you
#     know, what you're doing.
#
#     The default for aix is the perzl sudo package. For solaris 10 we
#     use the official www.sudo.ws binary package.
#
#     Default: AIX: perzl.org
#              Solaris: www.sudo.ws
#
#   [*package_admin_file*]
#     Where to find a Solaris 10 package admin file for
#     an unattended installation. We do not supply a default file, so
#     this has to be staged separately
#
#     Only set this on Solaris 10 (required)
#     Default: /var/sadm/install/admin/puppet
#
#   [*purge*]
#     Whether or not to purge sudoers.d directory
#     Default: true
#
#   [*purge_ignore*]
#     Files to exclude from purging in sudoers.d directory
#     Default: undef
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
  $enable              = true,
  $package             = $sudo::params::package,
  $package_ensure      = $sudo::params::package_ensure,
  $package_source      = $sudo::params::package_source,
  $package_admin_file  = $sudo::params::package_admin_file,
  $purge               = true,
  $purge_ignore        = undef,
  $config_file         = $sudo::params::config_file,
  $config_file_replace = true,
  $config_dir          = $sudo::params::config_dir,
  $source              = $sudo::params::source
) inherits sudo::params {


  validate_bool($enable)
  case $enable {
    true: {
      $dir_ensure  = 'directory'
      $file_ensure = 'present'
    }
    false: {
      $dir_ensure  = 'absent'
      $file_ensure = 'absent'
    }
    default: { fail('no $enable is set') }
  }

  class { 'sudo::package':
    package            => $package,
    package_ensure     => $package_ensure,
    package_source     => $package_source,
    package_admin_file => $package_admin_file,
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
    ignore  => $purge_ignore,
    require => Package[$package],
  }

  if $config_file_replace == false and $::osfamily == 'RedHat' and $::operatingsystemmajrelease == '5' {
    augeas { 'includedirsudoers':
      changes => ['set /files/etc/sudoers/#includedir /etc/sudoers.d'],
      incl    => $config_file,
      lens    => 'FixedSudoers.lns',
    }
  }

  # Load the Hiera based sudoer configuration (if enabled and present)
  #
  # NOTE: We must use 'include' here to avoid circular dependencies with
  #     sudo::conf
  #
  # NOTE: There is no way to detect the existence of hiera. This automatic
  #   functionality is therefore made exclusive to Puppet 3+ (hiera is embedded)
  #   in order to preserve backwards compatibility.
  #
  #   http://projects.puppetlabs.com/issues/12345
  #
  if (versioncmp($::puppetversion, '3') != -1) {
    include 'sudo::configs'
  }

  anchor { 'sudo::begin': } ->
  Class['sudo::package']    ->
  anchor { 'sudo::end': }
}

# @summary
#   This module manages sudo
#
# @param enable
#   Ensure if present or absent.
#
# @param package
#   Name of the package.
#   Only set this, if your platform is not supported or you know,
#   what you're doing.
#
# @param package_ldap
#   Name of the package with ldap support, if ldap_enable is set.
#
# @param package_ensure
#   Allows you to ensure a particular version of a package
#
# @param package_source
#   Where to find the package. Only set this on AIX (required) and
#   Solaris (required), if your platform is not supported or you
#   know, what you're doing.
#
# @param package_provider
#   Allows you to set a package provider.
#
# @param package_admin_file
#   Where to find a Solaris 10 package admin file for
#   an unattended installation. We do not supply a default file, so
#   this has to be staged separately and is required on Solaris 10.
#
# @param purge
#   Whether or not to purge sudoers.d directory
#
# @param purge_ignore
#   Files to exclude from purging in sudoers.d directory
#
# @param suffix
#   Adds a custom suffix to all files created in sudoers.d directory.
#
# @param prefix
#   Adds a custom prefix to all files created in sudoers.d directory.
#
# @param config_file
#   Main configuration file.
#   Only set this, if your platform is not supported or you know,
#   what you're doing.
#
# @param config_file_replace
#   Wether or not the config file should be replaced.
#
# @param config_file_mode
#   The mode to set on the config file.
#
# @param config_dir
#   Main directory containing sudo snippets, imported via
#   includedir stanza in sudoers file
#
# @param config_dir_mode
#   The mode to set for the config directory.
#
# @param extra_include_dirs
#   Array of additional directories containing sudo snippets
#
# @param content
#   Alternate content template file location
#   *Deprecated*, use *content_template* instead.
#
# @param content_template
#   Alternate content template file location
#   Only set this, if your platform is not supported or you know,
#   what you're doing.
#   Note: some parameters won't work, if default template isn't
#   used
#
# @param content_string
#   Alternate config file content string
#   Note: some parameters won't work, if default template isn't
#   used
#
# @param secure_path
#   The secure_path variable in sudoers.
#
# @param ldap_enable
#   Enable ldap support on the package
#
# @param delete_on_error
#   True if you want that the configuration is deleted on an error
#   during a complete visudo -c run. If false it will just return
#   an error and will add a comment to the sudoers configuration so
#   that the resource will be checked at the following run.
#
# @param validate_single
#   Do a validate on the "single" file in the sudoers.d directory.
#   If the validate fail the file will not be saved or changed
#   if a file already exist.
#
# @param config_dir_keepme
#   Add a .keep-me file to the config dir
#
# @param use_sudoreplay
#   Boolean to enable the usage of sudoreplay.
#
# @param wheel_config
#   How to configure the wheel group in /etc/sudoers
#   Options are either not to configure it it, configure it prompting for password,
#   or configuring it without password prompt.
#
# @param sudoreplay_discard
#   Array of additional command to discard in sudo log.
#
# @param configs
#   A hash of sudo::conf's
#
# @example
#   class { 'sudo': }
#
class sudo (
  Boolean                                        $enable              = true,
  Optional[String[1]]                            $package             = $sudo::params::package,
  Optional[String[1]]                            $package_ldap        = $sudo::params::package_ldap,
  String[1]                                      $package_ensure      = $sudo::params::package_ensure,
  Optional[String[1]]                            $package_source      = $sudo::params::package_source,
  Optional[String[1]]                            $package_provider    = $sudo::params::package_provider,
  Optional[String[1]]                            $package_admin_file  = $sudo::params::package_admin_file,
  Boolean                                        $purge               = true,
  Optional[Variant[String[1], Array[String[1]]]] $purge_ignore        = undef,
  Optional[String[1]]                            $suffix              = undef,
  Optional[Pattern[/^[^.]+$/]]                   $prefix              = undef,
  String[1]                                      $config_file         = $sudo::params::config_file,
  Boolean                                        $config_file_replace = true,
  String[1]                                      $config_file_mode    = $sudo::params::config_file_mode,
  String[1]                                      $config_dir          = $sudo::params::config_dir,
  String[1]                                      $config_dir_mode     = $sudo::params::config_dir_mode,
  Optional[Array[String[1]]]                     $extra_include_dirs  = undef,
  Optional[String[1]]                            $content             = undef,
  Optional[String[1]]                            $content_template    = undef,
  Optional[String[1]]                            $content_string      = undef,
  Optional[String[1]]                            $secure_path         = $sudo::params::secure_path,
  Boolean                                        $ldap_enable         = false,
  Boolean                                        $delete_on_error     = true,
  Boolean                                        $validate_single     = false,
  Boolean                                        $config_dir_keepme   = $sudo::params::config_dir_keepme,
  Boolean                                        $use_sudoreplay      = false,
  Enum['absent','password','nopassword']         $wheel_config        = $sudo::params::wheel_config,
  Optional[Array[String[1]]]                     $sudoreplay_discard  = undef,
  Hash                                           $configs             = {},
) inherits sudo::params {
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

  case $ldap_enable {
    true: {
      if $package_ldap == undef {
        fail('on your os ldap support for sudo is not yet supported')
      }
      $package_real = $package_ldap
    }
    false: {
      $package_real = $package
    }
    default: { fail('no $ldap_enable is set') }
  }
  if $package_real {
    class { 'sudo::package':
      package            => $package_real,
      package_ensure     => $package_ensure,
      package_source     => $package_source,
      package_provider   => $package_provider,
      package_admin_file => $package_admin_file,
      ldap_enable        => $ldap_enable,
      before             => [
        File[$config_file],
        File[$config_dir],
      ],
    }
  }

  if $content_template and $content_string {
    fail("'content_template' and 'content_string' are mutually exclusive")
  }

  if $content and $content_string {
    fail("'content' (deprecated) and 'content_string' are mutually exclusive")
  }

  if $content {
    warning("Class['sudo'] parameter 'content' is deprecated in favor of 'content_template'")
    $content_real = template($content)
  } else {
    if $content_string {
      $content_real = $content_string
    } elsif $content_template {
      $content_real = template($content_template)
    } else {
      $content_real = template($sudo::params::content_template)
    }
  }

  file { $config_file:
    ensure  => $file_ensure,
    owner   => 'root',
    group   => $sudo::params::config_file_group,
    mode    => $config_file_mode,
    replace => $config_file_replace,
    content => $content_real,
  }

  file { $config_dir:
    ensure  => $dir_ensure,
    owner   => 'root',
    group   => $sudo::params::config_file_group,
    mode    => $config_dir_mode,
    recurse => $purge,
    purge   => $purge,
    ignore  => $purge_ignore,
  }

  if $config_dir_keepme {
    file { "${config_dir}/.keep-me":
      ensure => file,
      owner  => 'root',
      group  => $sudo::params::config_file_group,
    }
  }

  $configs.each |$config_name, $config| {
    sudo::conf { $config_name:
      * => $config,
    }
  }
}

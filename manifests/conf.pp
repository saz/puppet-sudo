# Define: sudo::conf
#
# This module manages sudo configurations
#
# Parameters:
#   [*ensure*]
#     Ensure if present or absent.
#     Default: present
#
#   [*priority*]
#     Prefix file name with $priority
#     Default: 10
#
#   [*content*]
#     Content of configuration snippet.
#     Default: undef
#
#   [*source*]
#     Source of configuration snippet.
#     Default: undef
#
#   [*sudo_config_dir*]
#     Where to place configuration snippets.
#     Only set this, if your platform is not supported or
#     you know, what you're doing.
#     Default: auto-set, platform specific
#
# Actions:
#   Installs sudo configuration snippets
#
# Requires:
#   Class sudo
#
# Sample Usage:
#   sudo::conf { 'admins':
#     source => 'puppet:///files/etc/sudoers.d/admins',
#   }
#
# [Remember: No empty lines between comments and class definition]
define sudo::conf(
  $ensure           = present,
  $priority         = 10,
  $content          = undef,
  $source           = undef,
  $template         = undef,
  $sudo_config_dir  = undef,
  $sudo_file_name   = undef,
  $sudo_syntax_path = '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'
  ) {

    include ::sudo

  # Hack to allow the user to set the config_dir from the
  # sudo::config parameter, but default to $sudo::params::config_dir
  # if it is not provided. $sudo::params isn't included before
  # the parameters are loaded in.
  $sudo_config_dir_real = $sudo_config_dir ? {
    undef            => $sudo::config_dir,
    $sudo_config_dir => $sudo_config_dir
  }

  # sudo skip file name that contain a "."
  $dname = regsubst($name, '\.', '-', 'G')

  if size("x${priority}") == 2 {
    $priority_real = "0${priority}"
  } else {
    $priority_real = $priority
  }

  # build current file name with path
  if $sudo_file_name != undef {
    $cur_file = "${sudo_config_dir_real}/${sudo_file_name}"
  } else {
    $cur_file = "${sudo_config_dir_real}/${priority_real}_${dname}"
  }

  # replace whitespace in file name
  $cur_file_real = regsubst($cur_file, '\s+', '_', 'G')

  Class['sudo'] -> Sudo::Conf[$name]

  if $::osfamily == 'RedHat' {
    if (versioncmp($::sudoversion, '1.7.2p1') < 0) {
      warning("Found sudo with version ${::sudoversion}, but at least version 1.7.2p1 is required!")
    }
  }

  if $content != undef {
    if $content =~ Array {
      $lines = join($content, "\n")
      $content_real = "# This file is managed by Puppet; changes may be overwritten\n${lines}\n"
    } else {
      $content_real = "# This file is managed by Puppet; changes may be overwritten\n${content}\n"
    }
  } elsif $template != undef {
    $content_real = template($template)
  } else {
    $content_real = undef
  }

  if $ensure == 'present' {
    if $sudo::validate_single {
      $validate_cmd_real = 'visudo -c -f %'
    } else {
      $validate_cmd_real = undef
    }
    if $sudo::delete_on_error {
      $notify_real = Exec["sudo-syntax-check for file ${cur_file}"]
      $delete_cmd = "( rm -f '${cur_file_real}' && exit 1)"
    } else {
      $notify_real = Exec["sudo-syntax-check for file ${cur_file}"]
      $errormsg = "Error on global-syntax-check with file ${cur_file_real}"
      $delete_cmd = "( echo '${errormsg}' && echo '#${errormsg}' >>${cur_file_real} && exit 1)"
    }
  } else {
    $delete_cmd = ''
    $notify_real = undef
    $validate_cmd_real = undef
  }

  file { "${priority_real}_${dname}":
    ensure       => $ensure,
    path         => $cur_file_real,
    owner        => 'root',
    group        => $sudo::params::config_file_group,
    mode         => $sudo::params::config_file_mode,
    source       => $source,
    content      => $content_real,
    notify       => $notify_real,
    validate_cmd => $validate_cmd_real,
  }

  exec {"sudo-syntax-check for file ${cur_file}":
    command     => "visudo -c || ${delete_cmd}",
    refreshonly => true,
    path        => $sudo_syntax_path,
  }


}

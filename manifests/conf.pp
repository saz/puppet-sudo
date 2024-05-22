# Define: sudo::conf
#
# @summary
#   Manages sudo configuration snippets
#
# @param ensure
#     Ensure if present or absent
#
# @param priority
#     Prefix file name with $priority
#
# @param content
#     Content of configuration snippet
#
# @param source
#     Source of configuration snippet
#
# @param template
#     Path of a erb template file or epp template file without parameters
#
# @param template_epp
#     Path of an epp template and associated template parameters
#
# @param sudo_config_dir
#     Where to place configuration snippets.
#     Only set this, if your platform is not supported or
#     you know, what you're doing.
#
# @param sudo_file_name
#   Set a custom file name for the snippet
#
# @param sudo_syntax_path
#   Path to use for executing the sudo syntax check
#
# @example
#   sudo::conf { 'admins':
#     source => 'puppet:///files/etc/sudoers.d/admins',
#   }
#
define sudo::conf (
  Enum['present', 'absent']                                $ensure           = present,
  Integer[0]                                               $priority         = 10,
  Optional[Variant[Array[String[1]], String[1]]]           $content          = undef,
  Optional[String[1]]                                      $source           = undef,
  Optional[String[1]]                                      $template         = undef,
  Optional[Struct[{ filename => String, params => Hash }]] $template_epp     = undef,
  Optional[String[1]]                                      $sudo_config_dir  = undef,
  Optional[String[1]]                                      $sudo_file_name   = undef,
  String[1]                                                $sudo_syntax_path = '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'
) {
  include sudo

  # Hack to allow the user to set the config_dir from the
  # sudo::config parameter, but default to $sudo::params::config_dir
  # if it is not provided. $sudo::params isn't included before
  # the parameters are loaded in.
  $sudo_config_dir_real = $sudo_config_dir ? {
    undef            => $sudo::config_dir,
    $sudo_config_dir => $sudo_config_dir
  }

  # Append suffix
  if $sudo::suffix {
    $_name_suffix = "${name}${sudo::suffix}"
  } else {
    $_name_suffix = $name
  }

  # sudo skip file name that contain a "."
  $dname = regsubst($_name_suffix, '\.', '-', 'G')

  # Prepend prefix
  if $sudo::prefix {
    $_name_prefix = $sudo::prefix
  }  else {
    $_name_prefix = ''
  }

  if size("x${priority}") == 2 {
    $priority_real = "0${priority}"
  } else {
    $priority_real = $priority
  }

  # build current file name with path
  if $sudo_file_name != undef {
    $cur_file = "${sudo_config_dir_real}/${sudo_file_name}"
  } else {
    $cur_file = "${sudo_config_dir_real}/${_name_prefix}${priority_real}_${dname}"
  }

  # replace whitespace in file name
  $cur_file_real = regsubst($cur_file, '\s+', '_', 'G')

  if $facts['os']['family'] == 'RedHat' {
    if (versioncmp($facts['sudoversion'], '1.7.2p1') < 0) {
      warning("Found sudo with version ${facts['sudoversion']}, but at least version 1.7.2p1 is required!")
    }
  }

  if $template and $template_epp {
    fail("'template' and 'template_epp' are mutually exclusive")
  }

  if $content != undef {
    if $content =~ Array {
      $lines = join($content, "\n")
      $content_real = "# This file is managed by Puppet; changes may be overwritten\n${lines}\n"
    } else {
      $content_real = "# This file is managed by Puppet; changes may be overwritten\n${content}\n"
    }
  } elsif $template != undef {
    if $template =~ /\.epp$/ {
      $lines = epp($template)
    } else {
      $lines = template($template)
    }
    $content_real = "# This file is managed by Puppet; changes may be overwritten\n${lines}\n"
  } elsif $template_epp != undef {
    $missing_data_error = "'template_epp' must be a hash containing two elements; filename(string) and params(hash)"
    if $template_epp[filename] == undef {
      fail("template_epp hash missing filename element: ${missing_data_error}")
    }
    if $template_epp[params] == undef {
      fail("template_epp hash missing params element: ${missing_data_error}")
    }
    $lines = epp($template_epp[filename], $template_epp[params])
    $content_real = "# This file is managed by Puppet; changes may be overwritten\n${lines}\n"
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
    require      => File[$sudo_config_dir_real],
    validate_cmd => $validate_cmd_real,
  }

  exec { "sudo-syntax-check for file ${cur_file}":
    command     => "visudo -c || ${delete_cmd}",
    refreshonly => true,
    path        => $sudo_syntax_path,
  }
}

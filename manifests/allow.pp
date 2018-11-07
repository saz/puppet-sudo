# Class: sudo::allow
#
# This class allows you to take complete advantage of automatic parameter
# lookup using a Hiera database. Providing a singleton class that accepts
# arrays in the parameters makes it possible to implement specific user
# or group configuration in Hiera, whereas the use of defined types is
# normally restricted to Puppet manifests.
#
# Furthermore, having separate parameters for "add" and "replace" modes
# allows you to take full advantage of inheritance in the Hiera database
# while still allowing for exceptions if required.
#
# This class works best with Puppet 3.0 or higher.
#
# Parameters:
#   [*add_users*]
#     Define the set of users with sudo privileges by getting all values in
#     the hierarchy for this key, then flattening them into a single array
#     of unique values.
#     Default: empty array
#
#   [*add_groups*]
#     Define the set of groups with sudo privileges by getting all values in
#     the hierarchy for this key, then flattening them into a single array
#     of unique values.
#     Default: empty array
#
#   [*replace_users*]
#     Override any values specified in add_users. If you specify this value
#     in your manifest or Hiera database, the contents of "add_users" will
#     be ignored. With Hiera, a standard priority lookup is used. Note that
#     if replace_users is specified at ANY level of the hierarchy, then
#     add_users is ignored at EVERY level of the hierarchy.
#     Default: undef
#
#   [*replace_groups*]
#     Override any values specified in add_groups. If you specify this value
#     in your manifest or Hiera database, the contents of "add_groups" will
#     be ignored. With Hiera, a standard priority lookup is used. Note that
#     if replace_groups is specified at ANY level of the hierarchy, then
#     add_groups is ignored at EVERY level of the hierarchy.
#     Default: undef
#
# Actions:
#   Creates file in sudoers.d that permits specific users and groups to sudo.
#
# Sample Usage:
#   class { 'sudo::allow':
#     add_users  => ['jsmith'],
#     add_groups => ['wheel'],
#   }
#
# [Remember: No empty lines between comments and class definition]
class sudo::allow(
  $add_users = [],
  $add_groups = [],
  $replace_users = undef,
  $replace_groups = undef
) {
  # TODO validate that all input is arrays

  if $replace_users != undef {
    $users = $replace_users
  } else {
    $users = lookup("${module_name}::allow::add_users", Array, 'unique', $add_users)
  }
  if $replace_groups != undef {
    $groups = $replace_groups
  } else {
    $groups = lookup("${module_name}::allow::add_groups", Array, 'unique', $add_groups)
  }

  sudo::conf { 'sudo_users_groups':
    content  => template("${module_name}/users_groups.erb"),
  }
}

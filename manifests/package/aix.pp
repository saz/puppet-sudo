# @summary
#   Install the perzl.org sudo package. It also requires the openldap
#   rpm. so we add a dependencies to the ldap module.
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
# @example
#  class { sudo::package::aix:
#    package => 'sudo',
#    package_source 'http://myaixpkgserver/pkgs/aix/sudo-1.8.6p7-1.aix5.1.ppc.rpm'',
#  }
#
# @author
#   Toni Schmidbauer <toni@stderr.at>
#
# @api private
class sudo::package::aix (
  Optional[String[1]] $package          = undef,
  Optional[String[1]] $package_source   = undef,
  String[1]           $package_ensure   = present,
  Optional[String[1]] $package_provider = undef,
) {
  package { $package:
    ensure   => $package_ensure,
    source   => $package_source,
    provider => $package_provider,
  }
}

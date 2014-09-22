# == Class: sudo::package::aix
#
# Install the perzl.org sudo package. It also requires the openldap
# rpm. so we add a dependencies to the ldap module.
#
# === Parameters
#
# Document parameters here.
#
# [*package*]
#   The name of the sudo package to be installed
#
# [*package_ensure*]
#   Ensure if present or absent
#
# [*package_source*]
#   Where to find the sudo packge, should be a local file or a uri
#
# === Examples
#
#  class { sudo::package::aix:
#    package => 'sudo',
#    package_source 'http://myaixpkgserver/pkgs/aix/sudo-1.8.6p7-1.aix5.1.ppc.rpm'',
#  }
#
# === Authors
#
# Toni Schmidbauer <toni@stderr.at>
#
# === Copyright
#
# Copyright 2013 Toni Schmidbauer
#
class sudo::package::aix (
  $package = '',
  $package_source = '',
  $package_ensure = 'present',

  ) {

    package { $package:
      ensure   => $package_ensure,
      source   => $package_source,
      provider => rpm,
    }
}

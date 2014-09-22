# == Class: sudo::package::solaris
#
# install sudo under solaris 10/11.
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
# [*package_admin_file*]
#   Solaris 10 package admin file for unattended installation
#
# === Examples
#
#  class { sudo::package::solaris:
#    package => 'sudo',
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
class sudo::package::solaris (
  $package = '',
  $package_source     = '',
  $package_ensure     = 'present',
  $package_admin_file = '',
  ) {

  case $::kernelrelease {
    '5.11': {
      package { $package:
        ensure => $package_ensure,
      }
    }
    '5.10': {
      package { $package:
        ensure          => $package_ensure,
        source          => $package_source,
        adminfile       => $package_admin_file,
        install_options => ['-G', ],
      }
    }
    default: {
      fail("Unsupported Solaris kernelrelease ${::kernelrelease}!")
    }
  }
}

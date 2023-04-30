# @summary
#   install sudo under solaris 10/11.
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
# @param package_admin_file
#   Solaris 10 package admin file for unattended installation
#
# @example
#  class { sudo::package::solaris:
#    package => 'sudo',
#  }
#
# @author
#   Toni Schmidbauer <toni@stderr.at>
#
# @api private
class sudo::package::solaris (
  Optional[String[1]] $package            = undef,
  Optional[String[1]] $package_source     = undef,
  String[1]           $package_ensure     = 'present',
  Optional[String[1]] $package_admin_file = undef,
  Optional[String[1]] $package_provider   = undef,
) {
  $package_defaults = {
    ensure   => $package_ensure,
    provider => $package_provider,
  }

  case $facts['kernelrelease'] {
    '5.11': {
      package { $package:
        * => $package_defaults,
      }
    }
    '5.10': {
      package { $package:
        *               => $package_defaults,
        source          => $package_source,
        adminfile       => $package_admin_file,
        install_options => [
          '-G',
        ],
      }
    }
    default: {
      fail("Unsupported Solaris kernelrelease ${facts['kernelrelease']}!")
    }
  }
}

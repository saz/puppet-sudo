class sudo::params {
    case $operatingsystem {
        /(Ubuntu|Debian)/: {
            $package_name = 'sudo'
            $sudoers = '/etc/sudoers'
        }
    }
}

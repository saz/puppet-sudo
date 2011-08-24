class sudo::params {
    case $operatingsystem {
        /(Ubuntu|Debian)/: {
            $package_name = 'sudo'
            $sudoers = '/etc/sudoers'
            $conf_dir = '/etc/sudoers.d/'
        }
    }
}

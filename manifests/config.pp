class sudo::config {
    file { $sudo::params::sudoers:
        owner   => root,
        group   => root,
        mode    => 440,
        require => Class['sudo::install'],
        source  => 'puppet:///modules/sudo/sudoers',
    }

    file { $sudo::params::conf_dir:
        owner   => root,
        group   => root,
        mode    => 640,
        require => Class['sudo::install'],
        recurse => true,
        purge   => true,
        force   => true,
    }
}

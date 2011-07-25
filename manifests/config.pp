class sudo::config {
    file { $sudo::params::sudoers:
        owner   => root,
        group   => root,
        mode    => 440,
        require => Class['sudo::install'],
    }
}

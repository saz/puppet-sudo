define sudo::conf($priority = 10, $content = undef, $source = undef) {
    include sudo

    file { "${priority}_${name}":
        path    => "${sudo::params::conf_dir}${priority}_${name}",
        ensure  => present,
        owner   => root,
        group   => root,
        mode    => 0440,
        source  => $source,
        content => $content,
    }
}

define sudo::conf($priority = 10, $content = undef, $source = undef) {
    include sudo

    file { "${priority}_${name}":
        ensure  => present,
        owner   => root,
        group   => root,
        mode    => 0440,
        source  => $source,
        content => $content,
    }
}

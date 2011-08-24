define sudo::conf($content = undef, $source = undef) {
    include sudo

    file { $name:
        ensure  => present,
        owner   => root,
        group   => root,
        mode    => 640,
        source  => $source,
        content => $content,
    }
}

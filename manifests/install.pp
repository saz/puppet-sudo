class sudo::install {
    package { $sudo::params::package_name:
        ensure => latest,
    }
}

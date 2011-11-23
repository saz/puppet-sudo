# puppet-sudo

Manage sudo configuration via Puppet

## How to use

### Install sudo with default sudoers

```
    include sudo
```

### Adding sudoers definition (includes installation of sudo)

```
    sudo::conf { 'admins':
        priority => 10,
        content  => '%admins ALL=(ALL) NOPASSWD: ALL',
    }
```

* sudo::conf places a file in /etc/sudoers (on Debian/Ubuntu) named $priority_$name
* You don't have to explicitly use `include sudo` if you're using `sudo::conf`
* Instead of 'content' you can set 'source' to use a file instead of inline content
* You can also use `content => template('path/to/template.erb'`
* Priority defaults to 10


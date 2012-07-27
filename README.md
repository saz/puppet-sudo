# puppet-sudo

Manage sudo configuration via Puppet

## Usage

### Install sudo with default sudoers

```
    class { 'sudo': }
```

### Adding sudoers configuration snippet

```
    class { 'sudo': }
    sudo::conf { 'web':
      source => 'puppet:///files/etc/sudoers.d/web',
    }
    sudo::conf { 'admins':
      priority => 10,
      content  => "%admins ALL=(ALL) NOPASSWD: ALL\n",
    }
    sudo::conf { 'joe':
      priority => 60,
      source   => 'puppet:///files/etc/sudoers.d/users/joed',
    }
```

### sudo::conf notes
* You can pass template() through content parameter.
* One of content or source must be set.
* content values must include a \n and be enclosed in double quotes

## Additional class parameters
* ensure: present or absent, default: present
* autoupgrade: true or false, default: false
* package: string, default: OS specific. Set package name, if platform is not supported.
* config_file: string, default: OS specific. Set config_file, if platform is not supported.
* config_file_replace: true or false, default: true. Replace config file with module config file.
* config_dir: string, default: OS specific. Set config_dir, if platform is not supported.
* source: string, default: OS specific. Set source, if platform is not supported.

## sudo::conf parameters
* ensure: present or absent, default: present
* priority: number, default: 10
* content: string, default: undef
* source: string, default: undef
* sudo_config_dir: string, default: OS specific. Set sudo_config_dir, if platform is not supported.

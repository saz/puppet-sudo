# puppet-sudo [![Build Status](https://secure.travis-ci.org/saz/puppet-sudo.png)](http://travis-ci.org/saz/puppet-sudo)
https://github.com/saz/puppet-sudo

Manage sudo configuration via Puppet

### Supported Puppet versions
* Puppet >= 4
* Last version supporting Puppet 3: v4.2.0

### Supported OS
Some family and some specific os are supported by this module
* debian osfamily (debian, ubuntu, kali, ...)
* redhat osfamily (redhat, centos, fedora, ...)
* suse osfamily (suse, opensuse, ...)
* solaris osfamily (Solaris, OmniOS, SmartOS, ...)
* freebsd osfamily
* openbsd osfamily
* aix osfamily
* darwin osfamily
* gentoo operating system
* archlinux operating system
* amazon operating system

### Gittip
[![Support via Gittip](https://rawgithub.com/twolfson/gittip-badge/0.2.0/dist/gittip.png)](https://www.gittip.com/saz/)

## Usage

### WARNING
**This module will purge your current sudo config**

If this is not what you're expecting, set `purge` and/or `config_file_replace` to **false**

### Install sudo with default sudoers

#### Purge current sudo config
```puppet
    class { 'sudo': }
```

#### Purge sudoers.d directory, but leave sudoers file as it is
```puppet
    class { 'sudo':
      config_file_replace => false,
    }
```

#### Leave current sudo config as it is
```puppet
    class { 'sudo':
      purge               => false,
      config_file_replace => false,
    }
```

#### Use LDAP along with sudo

Sudo do not always include by default the support for LDAP.
On Debian and Ubuntu a special package sudo-ldap will be used.
On Gentoo there is also the needing to include [puppet portage module by Gentoo](https://forge.puppetlabs.com/gentoo/portage). If not present, only a notification will be shown.

```puppet
    class { 'sudo':
      ldap_enable         => true,
    }
```

### Adding sudoers configuration

#### Using Code

```puppet
    class { 'sudo': }
    sudo::conf { 'web':
      source => 'puppet:///files/etc/sudoers.d/web',
    }
    sudo::conf { 'admins':
      priority => 10,
      content  => "%admins ALL=(ALL) NOPASSWD: ALL",
    }
    sudo::conf { 'joe':
      priority => 60,
      source   => 'puppet:///files/etc/sudoers.d/users/joe',
    }
```

#### Using Hiera

A hiera hash may be used to assemble the sudoers configuration.
Hash merging is also enabled, which supports layering the configuration settings.

Examples using:
- YAML backend
- an environment called __production__
- a __/etc/puppet/hiera.yaml__ hierarchy configuration:

```yaml
:hierarchy:
  - "%{environment}"
  - "defaults"
```

##### Load module

###### Using Puppet version 3+

Load the module via Puppet Code or your ENC.

```puppet
    include sudo
```

###### Using Puppet version 2.7+

After [Installing Hiera](http://docs.puppetlabs.com/hiera/1/installing.html):

- Load the `sudo` and `sudo::configs` modules via Puppet Code or your ENC.

```puppet
    include sudo
    include sudo::configs
```

##### Configure Hiera YAML __(defaults.yaml)__

These defaults will apply to all systems.

```yaml
sudo::configs:
    'web':
        'source'    : 'puppet:///files/etc/sudoers.d/web'
    'admins':
        'content'   : "%admins ALL=(ALL) NOPASSWD: ALL"
        'priority'  : 10
    'joe':
        'priority'  : 60
        'source'    : 'puppet:///files/etc/sudoers.d/users/joe'
```

##### Configure Hiera YAML __(production.yaml)__

This will only apply to the production environment.
In this example we are:
- inheriting/preserving the __web__ configuration
- overriding the __admins__ configuration
- removing the __joe__ configuration
- adding the __bill__ template

```yaml
sudo::configs:
    'admins':
        'content'   : "%prodadmins ALL=(ALL) NOPASSWD: ALL"
        'priority'  : 10
    'joe':
        'ensure'    : 'absent'
        'source'    : 'puppet:///files/etc/sudoers.d/users/joe'
    'bill':
        'template'  : "mymodule/bill.erb"
```

If you have Hiera version >= 1.2.0 and enable [Hiera Deeper Merging](http://docs.puppetlabs.com/hiera/1/lookup_types.html#deep-merging-in-hiera--120) you may conditionally override any setting.

In this example we are:
- inheriting/preserving the __web__ configuration
- overriding the __admins:content__ setting
- inheriting/preserving the __admins:priority__ setting
- inheriting/preserving the __joe:source__ and __joe:priority__ settings
- removing the __joe__ configuration
- adding the __bill__ template

```yaml
sudo::configs:
    'admins':
        'content'   : "%prodadmins ALL=(ALL) NOPASSWD: ALL"
    'joe':
        'ensure'    : 'absent'
    'bill':
        'template'  : "mymodule/bill.erb"
```

##### Set a custom name for the sudoers file

In some edge cases, the automatically generated sudoers file name is insufficient. For example, when an application generates a sudoers file with a fixed file name, using this class with the purge option enabled will always delete the custom file and adding it manually will generate a file with the right content, but the wrong name. To solve this, you can use the ```sudo_file_name``` option to manually set the desired file name. 

```puppet
sudo::conf { "foreman-proxy":
	ensure          => "present",
	source          => "puppet:///modules/sudo/foreman-proxy",
	sudo_file_name  => "foreman-proxy",
}
```

### sudo::conf / sudo::configs notes
* One of content or source must be set.
* Content may be an array, string will be added with return carriage after each element.
* In order to properly pass a template() use template instead of content, as hiera would run template function otherwise.

## sudo class parameters

| Parameter           | Type    | Default     | Description |
| :--------------     | :------ |:----------- | :---------- |
| enable              | boolean | true        | Set this to remove or purge all sudoers configs |
| package             | string  | OS specific | Set package name _(for unsupported platforms)_ |
| package_ensure      | string  | present     | latest, absent, or a specific package version |
| package_source      | string  | OS specific | Set package source _(for unsupported platforms)_ |
| purge               | boolean | true        | Purge unmanaged files from config_dir |
| purge_ignore        | string  | undef       | Files excluded from purging in config_dir |
| config_file         | string  | OS specific | Set config_file _(for unsupported platforms)_ |
| config_file_replace | boolean | true        | Replace config file with module config file |
| includedirsudoers   | boolean | OS specific | Add #includedir /etc/sudoers.d with augeas |
| config_dir          | string  | OS specific | Set config_dir _(for unsupported platforms)_ |
| content             | string  | OS specific | Alternate content file location |
| ldap_enable         | boolean | false       | Add support to LDAP |

## sudo::conf class / sudo::configs hash parameters

| Parameter       | Type   | Default     | Description |
| :-------------- | :----- |:----------- | :---------- |
| ensure          | string | present     | present or absent |
| priority        | number | 10          | file name prefix |
| content         | string | undef       | content of configuration snippet |
| source          | string | undef       | source of configuration snippet |
| template        | string | undef       | template of configuration snippet |
| sudo_config_dir | string | OS Specific | configuration snippet directory _(for unsupported platforms)_ |
| sudo_file_name  | string | undef		 | custom file name for sudo file in sudoers directory |

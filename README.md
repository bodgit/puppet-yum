# yum

Tested with Travis CI

[![Build Status](https://travis-ci.org/bodgit/puppet-yum.svg?branch=master)](https://travis-ci.org/bodgit/puppet-yum)
[![Coverage Status](https://coveralls.io/repos/bodgit/puppet-yum/badge.svg?branch=master&service=github)](https://coveralls.io/github/bodgit/puppet-yum?branch=master)
[![Puppet Forge](http://img.shields.io/puppetforge/v/bodgit/yum.svg)](https://forge.puppetlabs.com/bodgit/yum)

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with yum](#setup)
    * [Beginning with yum](#beginning-with-yum)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Description

This module manages your Yum configuration, any additional plugins and also
the base OS repositories.

CentOS, RHEL, Scientific and Oracle Enterprise Linux is supported using Puppet
4.6.0 or later.

## Setup

### Beginning with yum

In the very simplest case, you can just include the following which mimics the
default configuration, plugins and repositories:

```puppet
include ::yum
```

## Usage

To not manage any default plugins or repositories:

```puppet
class { '::yum':
  default_plugins => {},
  repos           => {},
}
```

Beware some plugins such as `fastestmirror` cannot be easily removed so it's
better to manage them as disabled:

```puppet
class { '::yum':
  default_plugins => {
    'fastestmirror' => {
      'enable' => false,
    },
  },
}
```

## Reference

The reference documentation is generated with
[puppet-strings](https://github.com/puppetlabs/puppet-strings) and the latest
version of the documentation is hosted at
[https://bodgit.github.io/puppet-yum/](https://bodgit.github.io/puppet-yum/).

## Limitations

This module has been built on and tested against Puppet 4.6.0 and higher.

The module has been tested on:

* CentOS Enterprise Linux 6/7

The module could do with more thorough acceptance testing on RedHat,
Scientific and Oracle Enterprise Linux.

## Development

The module has both [rspec-puppet](http://rspec-puppet.com) and
[beaker-rspec](https://github.com/puppetlabs/beaker-rspec) tests. Run them
with:

```
$ bundle exec rake test
$ PUPPET_INSTALL_TYPE=agent PUPPET_INSTALL_VERSION=x.y.z bundle exec rake beaker:<nodeset>
```

Please log issues or pull requests at
[github](https://github.com/bodgit/puppet-yum).

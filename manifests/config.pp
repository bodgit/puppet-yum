# @!visibility private
class yum::config {

  file { $::yum::repo_dir:
    ensure => directory,
    owner  => 0,
    group  => 0,
    mode   => '0644',
  }

  file { "${::yum::conf_dir}/pluginconf.d":
    ensure       => directory,
    owner        => 0,
    group        => 0,
    mode         => '0644',
    force        => true,
    purge        => true,
    recurse      => true,
    recurselimit => 1,
  }

  file { $::yum::conf_file:
    ensure => file,
    owner  => 0,
    group  => 0,
    mode   => '0644',
  }

  Yum_conf {
    require => File[$::yum::conf_file],
  }

  resources { 'yum_conf':
    purge => true,
  }

  $config = delete_undef_values({
    'main/bugtracker_url'    => $::yum::bugtracker_url,
    'main/cachedir'          => $::yum::cachedir,
    'main/debuglevel'        => $::yum::debuglevel,
    'main/distroverpkg'      => $::yum::distroverpkg,
    'main/exactarch'         => $::yum::exactarch ? {
      undef   => undef,
      default => bool2num($::yum::exactarch),
    },
    'main/gpgcheck'          => $::yum::gpgcheck ? {
      undef   => undef,
      default => bool2num($::yum::gpgcheck),
    },
    'main/installonly_limit' => $::yum::installonly_limit,
    'main/keepcache'         => $::yum::keepcache ? {
      undef   => undef,
      default => bool2num($::yum::keepcache),
    },
    'main/logfile'           => $::yum::logfile,
    'main/obsoletes'         => $::yum::obsoletes ? {
      undef   => undef,
      default => bool2num($::yum::obsoletes),
    },
    'main/plugins'           => $::yum::plugins ? {
      undef   => undef,
      default => bool2num($::yum::plugins),
    },
  })

  $config.each |$setting, $value| {
    yum_conf { $setting:
      value => $value,
    }
  }

  include ::yum::clean

  resources { 'yumrepo':
    purge  => $::yum::purge_repos,
    notify => Class['::yum::clean'],
  }

  $::yum::repos.each |$repo, $attributes| {
    yumrepo { $repo:
      *      => $attributes,
      notify => Class['::yum::clean'],
    }
  }

  $::yum::default_plugins.each |$type, $resources| {
    $resources.each |$instance, $attributes| {
      Resource[$type] {
        $instance: * => $attributes,
      }
    }
  }
}
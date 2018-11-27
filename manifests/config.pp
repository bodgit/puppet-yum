# @!visibility private
class yum::config {

  file { $::yum::repo_dir:
    ensure => directory,
    owner  => 0,
    group  => 0,
    mode   => '0644',
  }

  file { $::yum::conf_dir:
    ensure => directory,
    owner  => 0,
    group  => 0,
    mode   => '0644',
  }

  [
    $::yum::fssnap_dir,
    $::yum::pluginconf_dir,
    $::yum::protected_dir,
    $::yum::variable_dir,
  ].filter |$x| {
    $x =~ NotUndef
  }.each |Stdlib::Absolutepath $directory| {
    file { $directory:
      ensure       => directory,
      owner        => 0,
      group        => 0,
      mode         => '0644',
      force        => true,
      purge        => true,
      recurse      => true,
      recurselimit => 1,
    }
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

  $config = {
    'bugtracker_url'    => $::yum::bugtracker_url,
    'cachedir'          => $::yum::cachedir,
    'debuglevel'        => $::yum::debuglevel,
    'distroverpkg'      => $::yum::distroverpkg,
    'exactarch'         => $::yum::exactarch ? {
      undef   => undef,
      default => bool2num($::yum::exactarch),
    },
    'gpgcheck'          => $::yum::gpgcheck ? {
      undef   => undef,
      default => bool2num($::yum::gpgcheck),
    },
    'installonly_limit' => $::yum::installonly_limit,
    'keepcache'         => $::yum::keepcache ? {
      undef   => undef,
      default => bool2num($::yum::keepcache),
    },
    'logfile'           => $::yum::logfile,
    'obsoletes'         => $::yum::obsoletes ? {
      undef   => undef,
      default => bool2num($::yum::obsoletes),
    },
    'plugins'           => $::yum::plugins ? {
      undef   => undef,
      default => bool2num($::yum::plugins),
    },
  }.filter |$x| {
    $x[1] =~ NotUndef
  }

  $config.each |$setting, $value| {
    yum_conf { "main/${setting}":
      value => $value,
    }
  }

  exec { "yum clean --enablerepo='*' expire-cache packages headers metadata dbcache rpmdb":
    path        => $::path,
    refreshonly => true,
  }

  exec { 'yum clean plugins':
    path        => $::path,
    refreshonly => true,
  }

  Yumrepo <| tag == $module_name |>
    ~> Exec["yum clean --enablerepo='*' expire-cache packages headers metadata dbcache rpmdb"]
    -> Package <| tag == $module_name and title != $::yum::package_name |>

  resources { 'yumrepo':
    purge  => $::yum::purge_repos,
    notify => Exec["yum clean --enablerepo='*' expire-cache packages headers metadata dbcache rpmdb"],
  }

  $::yum::default_plugins.each |$instance, $attributes| {
    class { "::${module_name}::plugin::${instance}":
      * => $attributes,
    }
  }

  $::yum::groups.each |$group, $attributes| {
    ::yum::group { $group:
      * => $attributes,
    }
  }

  $::yum::protected.each |$protect, $attributes| {
    ::yum::protect { $protect:
      * => $attributes,
    }
  }

  $::yum::repos.each |$repo, $attributes| {
    yumrepo { $repo:
      * => $attributes,
    }
  }

  $::yum::variables.each |$variable, $attributes| {
    ::yum::variable { $variable:
      * => $attributes,
    }
  }
}

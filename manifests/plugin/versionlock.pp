# Manage the Yum versionlock plugin.
#
# @example Declaring the class
#   include ::yum
#   include ::yum::plugin::versionlock
#
# @param ensure
# @param enable
# @param package_name
# @param follow_obsoletes
# @param locklist
#
# @see puppet_classes::yum ::yum
# @see puppet_defined_types::yum::plugin ::yum::plugin
# @see puppet_defined_types::yum::plugin::versionlock::entry ::yum::plugin::versionlock::entry
#
# @since 1.0.0
class yum::plugin::versionlock (
  Enum['present', 'absent'] $ensure           = 'present',
  Boolean                   $enable           = true,
  String                    $package_name     = $::yum::params::versionlock_package_name,
  Optional[Boolean]         $follow_obsoletes = undef,
  Stdlib::Absolutepath      $locklist         = "${::yum::pluginconf_dir}/versionlock.list",
) inherits ::yum::params {

  if ! defined(Class['::yum']) {
    fail('You must include the yum base class before using the yum::plugin::versionlock class')
  }

  package { $package_name:
    ensure => $ensure,
  }

  if $ensure == 'present' {
    ::yum::plugin { 'versionlock':
      content => template("${module_name}/versionlock.conf.erb"),
      require => Package[$package_name],
    }

    ::concat { $locklist:
      owner => 0,
      group => 0,
      mode  => '0644',
    }
  }
}

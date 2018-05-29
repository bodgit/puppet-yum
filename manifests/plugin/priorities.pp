# Manage the Yum priorities plugin.
#
# @example Declaring the class
#   include ::yum
#   include ::yum::plugin::priorities
#
# @param ensure
# @param enable
# @param package_name
#
# @see puppet_classes::yum ::yum
# @see puppet_defined_types::yum::plugin ::yum::plugin
#
# @since 1.0.0
class yum::plugin::priorities (
  Enum['present', 'absent'] $ensure       = 'present',
  Boolean                   $enable       = true,
  String                    $package_name = $::yum::params::priorities_package_name,
) inherits ::yum::params {

  if ! defined(Class['::yum']) {
    fail('You must include the yum base class before using the yum::plugin::priorities class')
  }

  package { $package_name:
    ensure => $ensure,
  }

  if $ensure == 'present' {
    ::yum::plugin { 'priorities':
      content => template("${module_name}/plugin.conf.erb"),
      require => Package[$package_name],
    }
  }
}

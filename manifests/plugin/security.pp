# Manage the Yum security plugin.
#
# @example Declaring the class
#   include ::yum
#   include ::yum::plugin::security
#
# @param ensure
# @param enable
# @param package_name
#
# @see puppet_classes::yum ::yum
# @see puppet_defined_types::yum::plugin ::yum::plugin
#
# @since 1.0.0
class yum::plugin::security (
  Enum['present', 'absent'] $ensure       = 'present',
  Boolean                   $enable       = true,
  String                    $package_name = $::yum::params::security_package_name,
) inherits ::yum::params {

  if ! defined(Class['::yum']) {
    fail('You must include the yum base class before using the yum::plugin::security class')
  }

  package { $package_name:
    ensure => present,
  }

  if $ensure == 'present' {
    ::yum::plugin { 'security':
      content => template("${module_name}/plugin.conf.erb"),
      require => Package[$package_name],
    }
  }
}

# Manage the Yum RHN plugin
#
# @example Declaring the class
#   include ::yum
#   include ::yum::plugin::rhnplugin
#
# @param ensure
# @param enable
# @param package_name
# @param gpgcheck
# @param timeout
#
# @see puppet_classes::yum ::yum
# @see puppet_defined_types::yum::plugin ::yum::plugin
#
# @since 1.0.0
class yum::plugin::rhnplugin (
  Enum['present', 'absent'] $ensure       = 'present',
  Boolean                   $enable       = true,
  String                    $package_name = $::yum::params::rhnplugin_package_name,
  Optional[Boolean]         $gpgcheck     = true,
  Optional[Integer[0]]      $timeout      = 120,
) inherits ::yum::params {

  if ! defined(Class['::yum']) {
    fail('You must include the yum base class before using the yum::plugin::rhnplugin class')
  }

  package { $package_name:
    ensure => $ensure,
  }

  if $ensure == 'present' {
    ::yum::plugin { 'rhnplugin':
      content => template("${module_name}/rhnplugin.conf.erb"),
      require => Package[$package_name],
    }
  }
}

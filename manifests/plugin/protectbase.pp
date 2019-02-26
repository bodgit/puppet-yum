# Manage the Yum protectbase plugin.
#
# @example Declaring the class
#   include ::yum
#   include ::yum::plugin::protectbase
#
# @param ensure
# @param enable
# @param package_name
#
# @see puppet_classes::yum ::yum
# @see puppet_defined_types::yum::plugin ::yum::plugin
#
# @since 1.0.0
class yum::plugin::protectbase (
  Enum['present', 'absent'] $ensure       = 'present',
  Boolean                   $enable       = true,
  String                    $package_name = $::yum::params::protectbase_package_name,
) inherits ::yum::params {

  if ! defined(Class['::yum']) {
    fail('You must include the yum base class before using the yum::plugin::protectbase class')
  }

  package { $package_name:
    ensure => present,
    tag    => [
      "bodgit::${module_name}",
    ],
  }

  if $ensure == 'present' {
    ::yum::plugin { 'protectbase':
      content => template("${module_name}/plugin.conf.erb"),
      require => Package[$package_name],
    }
  }
}

# Description
#
# @example Declaring the class
#   include ::yum
#   include ::yum::plugin::kabi
#
# @param ensure
# @param enable
# @param package_name
# @param enforce
# @param whitelists
#
# @see puppet_classes::yum ::yum
# @see puppet_defined_types::yum::plugin ::yum::plugin
#
# @since 1.0.0
class yum::plugin::kabi (
  Enum['present', 'absent']      $ensure       = 'present',
  Boolean                        $enable       = true,
  String                         $package_name = $::yum::params::kabi_package_name,
  Optional[Boolean]              $enforce      = undef,
  Optional[Stdlib::Absolutepath] $whitelists   = '/lib/modules/kabi-current',
) inherits ::yum::params {

  if ! defined(Class['::yum']) {
    fail('You must include the yum base class before using the yum::plugin::kabi class')
  }

  package { $package_name:
    ensure => $ensure,
  }

  if $ensure == 'present' {
    ::yum::plugin { 'kabi':
      content => template("${module_name}/kabi.conf.erb"),
      require => Package[$package_name],
    }
  }
}

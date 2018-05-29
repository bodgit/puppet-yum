# Manage the Yum etckeeper plugin.
#
# @example Declaring the class
#   include ::yum
#   include ::yum::plugin::etckeeper
#
# @param ensure
# @param enable
#
# @see puppet_classes::yum ::yum
# @see puppet_defined_types::yum::plugin ::yum::plugin
#
# @since 1.0.0
class yum::plugin::etckeeper (
  Enum['present', 'absent'] $ensure = 'present',
  Boolean                   $enable = true,
) inherits ::yum::params {

  if ! defined(Class['::yum']) {
    fail('You must include the yum base class before using the yum::plugin::etckeeper class')
  }

  include ::etckeeper

  if $ensure == 'present' {
    ::yum::plugin { 'etckeeper':
      content => template("${module_name}/plugin.conf.erb"),
      require => Class['::etckeeper'],
    }
  }
}

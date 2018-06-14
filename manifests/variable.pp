# Set internal Yum variables.
#
# @example Set an example variable
#   include ::yum
#   ::yum::variable { 'foo':
#     value => 'bar',
#   }
#
# @param value
# @param variable
#
# @see puppet_classes::yum ::yum
#
# @since 1.0.0
define yum::variable (
  String $value,
  String $variable = $title,
) {

  if ! defined(Class['::yum']) {
    fail('You must include the yum base class before using any yum defined resources')
  }

  file { "${::yum::variable_dir}/${variable}":
    ensure  => file,
    owner   => 0,
    group   => 0,
    mode    => '0644',
    content => "${value}\n",
  }
}

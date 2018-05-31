# Manage the Yum utils
#
# @example Declaring the class
#   include ::yum
#   include ::yum::utils
#
# @param package_name
#
# @see puppet_classes::yum ::yum
#
# @since 1.0.0
class yum::utils (
  String $package_name = $::yum::params::utils_package_name,
) inherits ::yum::params {

  if ! defined(Class['::yum']) {
    fail('You must include the yum base class before using the yum::utils class')
  }

  contain ::yum::utils::install
}

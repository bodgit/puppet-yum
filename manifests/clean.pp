# Class for invalidating the Yum caches.
#
# @example Declaring the class
#   include ::yum
#   include ::yum::clean
#
#   Yumrepo <||> ~> Class['::yum::clean']
#
# @see puppet_classes::yum ::yum
#
# @since 1.0.0
class yum::clean {

  if ! defined(Class['::yum']) {
    fail('You must include the yum base class before using the yum::clean class')
  }

  exec { 'yum clean all':
    path        => $::path,
    refreshonly => true,
  }
}

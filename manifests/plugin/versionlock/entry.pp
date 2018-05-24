# Description
#
# @example
#
# @param packages
#
# @see puppet_classes::yum::plugin::versionlock
#
# @since 1.0.0
define yum::plugin::versionlock::entry (
  Array[String, 1] $packages,
) {

  if ! defined(Class['::yum::plugin::versionlock']) {
    fail('You must include the yum::plugin::versionlock base class before using any yum::plugin::versionlock defined resources')
  }

  ::concat::fragment { "${::yum::plugin::versionlock::locklist} ${title}":
    content => "${join($packages, "\n")}\n",
    target  => $::yum::plugin::versionlock::locklist,
  }
}
